import 'package:analyzer/dart/element/element.dart';
import 'package:brick_build/generators.dart';
import 'package:brick_build/src/serdes_generator.dart';
import 'package:brick_cloud_firestore_abstract/annotations.dart';
import 'package:brick_cloud_firestore_abstract/cloud_firestore_model.dart';
import 'package:brick_cloud_firestore_build/cloud_firestore_fields.dart';
import 'package:meta/meta.dart';

class CloudFirestoreSerializerGenerator<_Model extends CloudFirestoreModel>
    extends SerdesGenerator<CloudFirestore, _Model> {
  final String providerName = 'CloudFirestore';
  final String repositoryName;

  CloudFirestoreSerializerGenerator(
    ClassElement element,
    CloudFirestoreFields fields, {
    @required this.repositoryName,
  }) : super(element, fields);

  @override
  final doesDeserialize = false;

  @override
  List<String> get instanceFieldsAndMethods {
    final nodeKey = element.name.toLowerCase();

    return ["final String collectionNodeKey = '$nodeKey';"];
  }

  @override
  String coderForField(field, checker, {wrappedInFuture, fieldAnnotation}) {
    final fieldValue = serdesValueForField(field, fieldAnnotation.name, checker: checker);

    // DateTime
    if (checker.isDateTime) {
      return '$fieldValue?.toIso8601String()';

      // bool, double, int, num, String, Map, Iterable, enum
    } else if ((checker.isDartCoreType) || checker.isMap) {
      return fieldValue;

      // Iterable
    } else if (checker.isIterable) {
      final argTypeChecker = checkerForType(checker.argType);

      // Iterable<enum>
      if (argTypeChecker.isEnum) {
        return '$fieldValue?.map((e) => ${checker.argType.getDisplayString()}.values.indexOf(e))';
      }

      // Iterable<CloudFirestoreModel>, Iterable<Future<CloudFirestoreModel>>
      if (checker.isArgTypeASibling) {
        final awaited = checker.isArgTypeAFuture ? 'async' : '';
        final awaitedValue = checker.isArgTypeAFuture ? '(await s)' : 's';
        return '''await Future.wait<Map<String, dynamic>>(
          $fieldValue?.map((s) $awaited =>
            ${checker.unFuturedArgType}Adapter().toCloudFirestore($awaitedValue)
          )?.toList() ?? []
        )''';
      }

      return fieldValue;

      // CloudFirestoreModel, Future<CloudFirestoreModel>
    } else if (checker.isSibling) {
      final wrappedField = wrappedInFuture ? '(await $fieldValue)' : fieldValue;

      return 'await ${checker.unFuturedType}Adapter().toCloudFirestore($wrappedField ?? {})';

      // enum
    } else if (checker.isEnum) {
      return '$fieldValue != null ? ${field.type}.values.indexOf($fieldValue) : null';
    }

    return null;
  }
}
