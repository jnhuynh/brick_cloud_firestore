import 'package:brick_cloud_firestore/cloud_firestore.dart';
import 'package:brick_cloud_firestore/offline_first_with_cloud_firestore_repository.dart';
// run flutter pub run build_runner build before using this example
import 'package:pizza_shoppe/app/db/schema.g.dart';
import 'brick.g.dart';

class Repository extends OfflineFirstWithCloudFirestoreRepository {
  Repository._()
      : super(
          cloudFirestoreProvider: CloudFirestoreProvider(
            modelDictionary: cloudFirestoreModelDictionary,
          ),
          sqliteProvider: SqliteProvider(
            "pizzaShoppe.sqlite",
            modelDictionary: sqliteModelDictionary,
          ),
          migrations: migrations,
        );

  factory Repository() {
    if (_singleton != null) return _singleton;
    return _singleton = Repository._();
  }

  static Repository _singleton;
}
