import 'package:brick_build/builders.dart';
import 'package:brick_cloud_firestore_abstract/annotations.dart';
import 'package:brick_offline_first_with_cloud_firestore_build/src/offline_first_generator.dart';
import 'package:brick_offline_first_with_cloud_firestore_build/src/offline_first_model_dictionary_generator.dart';
import 'package:brick_offline_first_with_cloud_firestore_build/src/offline_first_sqlite_builders.dart';
import 'package:build/build.dart';

final offlineFirstGenerator = const OfflineFirstGenerator();

Builder cloudFirestoreAdaptersBuilder(options) {
  return AdapterBuilder<ConnectOfflineFirstWithCloudFirestore>(offlineFirstGenerator);
}

Builder offlineFirstAggregateBuilder(options) => AggregateBuilder(requiredImports: [
      "import 'package:brick_cloud_firestore_abstract/annotations.dart';",
      "import 'package:brick_cloud_firestore/cloud_firestore_repository.dart';",
      "import 'package:brick_cloud_firestore/cloud_firestore_adapter.dart';",
      "import 'package:brick_cloud_firestore/cloud_firestore_provider.dart';",
      "import 'package:brick_offline_first/offline_first.dart';",
      "import 'package:brick_sqlite_abstract/db.dart';",
    ]);

Builder cloudFirestoreModelDictionaryBuilder(options) {
  return ModelDictionaryBuilder<ConnectOfflineFirstWithCloudFirestore>(
    const OfflineFirstModelDictionaryGenerator(),
    expectedImportRemovals: [
      "import 'package:brick_cloud_firestore_abstract/annotations.dart';",
      'import "package:brick_cloud_firestore_abstract/annotations.dart";',
      "import 'package:brick_cloud_firestore/cloud_firestore.dart';",
      'import "package:brick_cloud_firestore/cloud_firestore.dart";',
    ],
  );
}

Builder offlineFirstNewMigrationBuilder(options) => OfflineFirstMigrationBuilder();
Builder offlineFirstSchemaBuilder(options) => OfflineFirstSchemaBuilder();
