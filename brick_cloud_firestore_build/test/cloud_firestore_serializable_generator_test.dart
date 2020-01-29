import 'package:brick_cloud_firestore_build/src/cloud_firestore_serializable_generator.dart';
import 'package:test/test.dart';
import 'package:source_gen/source_gen.dart';
import 'package:brick_build/testing.dart';

final _generator = CloudFirestoreSerializableGenerator();
final folder = 'cloud_firestore_serializable_generator';
final generateReader = generateLibraryForFolder(folder);

void main() {
  group('CloudFirestoreSerializableGenerator', () {
    group('constructor arguments', () {
      test('repositoryName', () async {
        final generator = OfflineFirstGenerator(repositoryName: 'MyCustom');
        await generateAdapterExpectation(
            'constructor_arguments', _$constructorArguments.repositoryNameAdapterExpectation,
            generator: generator);
      });

      test('superAdapterName', () async {
        final generator = OfflineFirstGenerator(superAdapterName: 'SuperDuper');
        await generateAdapterExpectation(
            'constructor_arguments', _$constructorArguments.superAdapterNameAdapterExpectation,
            generator: generator);
      });
    });

    group('#generate', () {
      test('CustomOfflineFirstSerdes', () async {
        await generateExpectation('custom_offline_first_serdes', _$customOfflineFirstSerdes.output);
      });

      test('CustomSerdes', () async {
        await generateExpectation('custom_serdes', _$customSerdes.output);
      });

      test('NoFinalNoConst', () async {
        await generateExpectation('no_final_no_const', _$noFinalNoConst.output);
      });

      test('OneToManyAssociation', () async {
        await generateExpectation('one_to_many_association', _$oneToManyAssociation.output);
      });

      test('OneToOneAssociation', () async {
        await generateExpectation('one_to_one_association', _$oneToOneAssociation.output);
      });

      test('OnlyStaticMembers', () async {
        await generateExpectation('only_static_members', _$onlyStaticMembers.output);
      });

      test('PrimitiveFields', () async {
        await generateExpectation('primitive_fields', _$primitiveFields.output);
      });

      test('UnrelatedAssociation', () async {
        await generateExpectation('unrelated_association', _$unrelatedAssociation.output);
      });
    });

    group('FieldSerializable', () {
      test('name', () async {
        await generateExpectation('specify_field_name', _$specifyFieldName.output);
      });

      test('defaultValue', () async {
        await generateExpectation('default_value', _$defaultValue.output);
      });

      test('ignore', () async {
        await generateExpectation('ignore_field', _$ignoreField.output);
      });

      test('nullable', () async {
        await generateExpectation('nullable_field', _$nullableField.output);
      });
    });
  });
}

Future<void> generateExpectation(String filename, String output,
    {OfflineFirstGenerator generator}) async {
  final reader = await generateReader(filename);
  final generated = await (generator ?? _generator).generate(reader, null);
  expect(generated.trim(), output.trim());
}

Future<void> generateAdapterExpectation(String filename, String output,
    {OfflineFirstGenerator generator}) async {
  final annotation = await annotationForFile<ConnectOfflineFirstWithRest>(folder, filename);
  final generated = await (generator ?? _generator).generateAdapter(
    annotation?.element,
    annotation?.annotation,
    null,
  );
  expect(generated.trim(), output.trim());
}
