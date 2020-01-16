import 'package:analyzer/dart/element/element.dart';
import 'package:brick_build/generators.dart';
import 'package:brick_build/src/serdes_generator.dart';
import 'package:brick_cloud_firestore_abstract/annotations.dart';
import 'package:brick_cloud_firestore_abstract/cloud_firestore_model.dart';
import 'package:brick_cloud_firestore_generator/cloud_firestore_fields.dart';
import 'package:meta/meta.dart';

class CloudFirestoreDeserializerGenerator<_Model extends CloudFirestoreModel>
    extends SerdesGenerator<CloudFirestore, _Model> {
  final String providerName = 'CloudFirestore';
  final String repositoryName;

  CloudFirestoreDeserializerGenerator(
    ClassElement element,
    CloudFirestoreFields fields, {
    @required this.repositoryName,
  }) : super(element, fields);

  @override
  final doesDeserialize = true;

  @override
  String get generateSuffix =>
      "..${CloudFirestoreModel.DOCUMENT_ID_FIELD_NAME} = data['${CloudFirestoreModel.DOCUMENT_ID_FIELD_NAME}'];";

  @override
  String coderForField(field, checker, {wrappedInFuture, fieldAnnotation}) {
    final fieldValue = serdesValueForField(field, fieldAnnotation.name, checker: checker);
    final defaultValue = SerdesGenerator.defaultValueSuffix(fieldAnnotation);

    // DateTime
    if (checker.isDateTime) {
      return '$fieldValue == null ? null : DateTime.tryParse($fieldValue$defaultValue as String)';

      // bool, double, int, num, String
    } else if (checker.isDartCoreType) {
      return '$fieldValue as ${field.type}$defaultValue';

      // Iterable
    } else if (checker.isIterable) {
      final argType = checker.unFuturedArgType;
      final argTypeChecker = checkerForType(checker.argType);
      final castIterable = SerdesGenerator.iterableCast(argType,
          isSet: checker.isSet,
          isList: checker.isList,
          isFuture: wrappedInFuture || checker.isFuture);

      // Iterable<CloudFirestoreModel>, Iterable<Future<CloudFirestoreModel>>
      if (checker.isArgTypeASibling) {
        final fromRestCast = SerdesGenerator.iterableCast(argType,
            isSet: checker.isSet, isList: checker.isList, isFuture: true);

        var deserializeMethod = '''
          $fieldValue?.map((d) =>
            ${argType}Adapter().fromRest(d, provider: provider, repository: repository)
          )$fromRestCast
        ''';

        if (wrappedInFuture) {
          deserializeMethod = 'Future.wait<$argType>($deserializeMethod ?? [])';
        } else if (!checker.isArgTypeAFuture && !checker.isFuture) {
          deserializeMethod = 'await Future.wait<$argType>($deserializeMethod ?? [])';
        }

        if (checker.isSet) {
          return '($deserializeMethod$defaultValue)?.toSet()';
        }

        return '$deserializeMethod$defaultValue';
      }

      // Iterable<enum>
      if (argTypeChecker.isEnum) {
        return '$fieldValue.map((e) => $argType.values.indexOf(e))$castIterable$defaultValue';
      }

      // List
      if (checker.isList) {
        final addon = fieldAnnotation.defaultValue ?? 'List<${checker.argType}>()';
        return '$fieldValue$castIterable ?? $addon';

        // Set
      } else if (checker.isSet) {
        final addon = fieldAnnotation.defaultValue ?? 'Set<${checker.argType}>()';
        return '$fieldValue$castIterable ?? $addon';

        // other Iterable
      } else {
        return '$fieldValue$castIterable$defaultValue';
      }

      // CloudFirestoreModel
    } else if (checker.isSibling) {
      final shouldAwait = wrappedInFuture ? '' : 'await ';

      return '''$shouldAwait${checker.unFuturedType}Adapter().fromRest(
          $fieldValue, provider: provider, repository: repository
        )''';

      // enum
    } else if (checker.isEnum) {
      return '$fieldValue is int ? ${field.type}.values[$fieldValue as int] : null$defaultValue';

      // Map
    } else if (checker.isMap) {
      return '$fieldValue$defaultValue';
    }

    return null;
  }
}
