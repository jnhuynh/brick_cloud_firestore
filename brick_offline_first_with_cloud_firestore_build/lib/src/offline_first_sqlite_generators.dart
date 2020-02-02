import 'package:analyzer/dart/element/element.dart';
import 'package:brick_build/generators.dart';
import 'package:brick_cloud_firestore_abstract/cloud_firestore_model.dart';
import 'package:brick_offline_first_with_cloud_firestore_build/src/offline_first_checker.dart';
import 'package:brick_sqlite_generators/generators.dart';
import 'package:brick_sqlite_generators/sqlite_model_serdes_generator.dart';
import 'package:source_gen/source_gen.dart';

class _OfflineFirstSqliteSerialize extends SqliteSerialize<OfflineFirstWithCloudFirestoreModel> {
  _OfflineFirstSqliteSerialize(ClassElement element, SqliteFields fields, {String repositoryName})
      : super(element, fields, repositoryName: repositoryName);

  @override
  OfflineFirstChecker checkerForType(type) => OfflineFirstChecker(type);

  @override
  String get generateSuffix =>
      "..addAll({'${CloudFirestoreModel.DOCUMENT_ID_COLUMN_NAME}': instance.documentId});";

  @override
  String coderForField(field, checker, {wrappedInFuture, fieldAnnotation}) {
    final fieldValue = serdesValueForField(field, fieldAnnotation.name, checker: checker);

    if (checker.isIterable) {
      final argTypeChecker = checkerForType(checker.argType);

      // Iterable<OfflineFirstSerdes>
      if (argTypeChecker.hasSerdes) {
        final _hasSerializer = hasSerializer(checker.argType);
        if (_hasSerializer) {
          final serializableType = argTypeChecker.superClassTypeArgs.last.getDisplayString();
          return '''
            jsonEncode($fieldValue?.map(
              (${checker.unFuturedArgType} c) => c?.$serializeMethod()
            )?.toList()?.cast<$serializableType>() ?? [])
          ''';
        }
      }
    }

    // OfflineFirstSerdes
    if ((checker as OfflineFirstChecker).hasSerdes) {
      final _hasSerializer = hasSerializer(field.type);
      if (_hasSerializer) {
        return '$fieldValue?.$serializeMethod()';
      }
    }

    return super.coderForField(field, checker,
        wrappedInFuture: wrappedInFuture, fieldAnnotation: fieldAnnotation);
  }
}

class _OfflineFirstSqliteDeserialize extends SqliteDeserialize {
  _OfflineFirstSqliteDeserialize(ClassElement element, SqliteFields fields, {String repositoryName})
      : super(element, fields, repositoryName: repositoryName);

  @override
  OfflineFirstChecker checkerForType(type) => OfflineFirstChecker(type);

  @override
  String get generateSuffix {
    final prior = super.generateSuffix.replaceAll(';', '');
    final withDocumentId =
        "..${CloudFirestoreModel.DOCUMENT_ID_FIELD_NAME} = data['${CloudFirestoreModel.DOCUMENT_ID_COLUMN_NAME}']";
    return [prior, withDocumentId].join('\n') + ';';
  }

  @override
  String coderForField(field, checker, {wrappedInFuture, fieldAnnotation}) {
    final fieldValue = serdesValueForField(field, fieldAnnotation.name, checker: checker);

    // Iterable
    if (checker.isIterable) {
      final argType = checker.unFuturedArgType;
      final argTypeChecker = OfflineFirstChecker(checker.argType);
      final castIterable = SerdesGenerator.iterableCast(argType,
          isSet: checker.isSet,
          isList: checker.isList,
          isFuture: wrappedInFuture || checker.isFuture);

      // Iterable<OfflineFirstSerdes>
      if (argTypeChecker.hasSerdes) {
        final _hasConstructor = hasConstructor(checker.argType);
        if (_hasConstructor) {
          final serializableType = argTypeChecker.superClassTypeArgs.last.getDisplayString();
          return '''
            jsonDecode($fieldValue).map(
              (c) => $argType.$constructorName(c as $serializableType)
            )$castIterable
          ''';
        }
      }
    }

    // OfflineFirstSerdes
    if ((checker as OfflineFirstChecker).hasSerdes) {
      final _hasConstructor = hasConstructor(field.type);
      if (_hasConstructor) {
        final serializableType = checker.superClassTypeArgs.last.getDisplayString();
        return "${field.type}.$constructorName($fieldValue as $serializableType)";
      }
    }

    return super.coderForField(field, checker,
        wrappedInFuture: wrappedInFuture, fieldAnnotation: fieldAnnotation);
  }
}

class OfflineFirstSqliteSerdes extends SqliteModelSerdesGenerator {
  OfflineFirstSqliteSerdes(Element element, ConstantReader reader, {String repositoryName})
      : super(element, reader, repositoryName: repositoryName);

  @override
  get generators {
    final classElement = element as ClassElement;
    final fields = SqliteFields(classElement, config);
    return [
      _OfflineFirstSqliteDeserialize(classElement, fields, repositoryName: repositoryName),
      _OfflineFirstSqliteSerialize(classElement, fields, repositoryName: repositoryName),
    ];
  }
}
