import 'package:brick_cloud_firestore_abstract/annotations.dart';
import 'package:brick_offline_first_with_cloud_firestore_build/src/offline_first_generator.dart';
import 'package:test/test.dart';
import 'package:brick_build/testing.dart';

import 'offline_first_generator/test_simple.dart' as _$simple;

final _generator = OfflineFirstGenerator();
final folder = 'offline_first_generator';
final generateReader = generateLibraryForFolder(folder);

void main() {
  group('CloudFirestoreSerdes', () {
    test('simple', () async {
      await generateAdapterExpectation('simple', _$simple.output);
    });
  });
}

Future<void> generateAdapterExpectation(String filename, String output,
    {OfflineFirstGenerator generator}) async {
  final annotation =
      await annotationForFile<ConnectOfflineFirstWithCloudFirestore>(folder, filename);
  final generated = await (generator ?? _generator)
      .generateAdapter(annotation?.element, annotation?.annotation, null);
  expect(generated.trim(), output.trim());
}
