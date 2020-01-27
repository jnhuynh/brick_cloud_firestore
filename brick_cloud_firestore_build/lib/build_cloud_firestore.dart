import 'package:brick_build/builders.dart';
import 'package:brick_cloud_firestore_abstract/annotations.dart';
import 'package:brick_cloud_firestore_build/src/cloud_firestore_model_dictionary_generator.dart';
import 'package:brick_cloud_firestore_build/src/cloud_firestore_serializable_generator.dart';
import 'package:build/build.dart';

final cloudFirestoreSerializableGenerator = const CloudFirestoreSerializableGenerator();

Builder cloudFirestoreAggregateBuilder(options) {
  return AggregateBuilder(requiredImports: [
    "import 'package:brick_cloud_firestore_abstract/annotations.dart';",
    "import 'package:brick_cloud_firestore/cloud_firestore.dart';",
  ]);
}

Builder cloudFirestoreAdaptersBuilder(options) {
  return AdapterBuilder<CloudFirestoreSerializable>(cloudFirestoreSerializableGenerator);
}

Builder offlineFirstModelDictionaryBuilder(options) {
  return ModelDictionaryBuilder<CloudFirestoreSerializable>(
    const CloudFirestoreModelDictionaryGenerator(),
    expectedImportRemovals: [
      "import 'package:brick_cloud_firestore_abstract/annotations.dart';",
      'import "package:brick_cloud_firestore_abstract/annotations.dart";',
      "import 'package:brick_cloud_firestore/cloud_firestore.dart';",
      'import "package:brick_cloud_firestore/cloud_firestore.dart";',
    ],
  );
}
