import 'package:brick_build/builders.dart';
import 'package:brick_cloud_firestore_abstract/annotations.dart';
import 'package:brick_connect_cloud_firestore_build/src/connect_cloud_firestore_generator.dart';
import 'package:brick_connect_cloud_firestore_build/src/connect_cloud_firestore_model_dictionary_generator.dart';
import 'package:build/build.dart';

final cloudFirestoreGenerator = const ConnectCloudFirestoreGenerator();

Builder cloudFirestoreAdaptersBuilder(options) {
  return AdapterBuilder<ConnectCloudFirestore>(cloudFirestoreGenerator);
}

Builder connectCloudFirestoreAggregateBuilder(options) => AggregateBuilder(requiredImports: [
      "import 'package:brick_cloud_firestore_abstract/annotations.dart';",
      "import 'package:brick_cloud_firestore/offline_first_with_cloud_firestore_repository.dart';",
      "import 'package:brick_cloud_firestore/cloud_firestore_adapter.dart';",
      "import 'package:brick_cloud_firestore/cloud_firestore_provider.dart';",
    ]);

Builder cloudFirestoreModelDictionaryBuilder(options) {
  return ModelDictionaryBuilder<ConnectCloudFirestore>(
    const ConnectCloudFirestoreModelDictionaryGenerator(),
    expectedImportRemovals: [
      "import 'package:brick_cloud_firestore_abstract/annotations.dart';",
      'import "package:brick_cloud_firestore_abstract/annotations.dart";',
      "import 'package:brick_cloud_firestore/cloud_firestore.dart';",
      'import "package:brick_cloud_firestore/cloud_firestore.dart";',
    ],
  );
}
