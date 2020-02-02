import 'package:brick_cloud_firestore/cloud_firestore.dart';
import 'package:brick_offline_first/offline_first.dart';
// run flutter pub run build_runner build before using this example
import 'package:pizza_shoppe/app/db/schema.g.dart';
import 'brick.g.dart';

class Repository extends OfflineFirstRepository {
  Repository._()
      : super(
          remoteProvider: CloudFirestoreProvider(
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
