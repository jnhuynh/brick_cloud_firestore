import 'package:brick_cloud_firestore/cloud_firestore.dart';
import 'package:brick_offline_first/offline_first.dart';
import 'package:brick_sqlite/memory_cache_provider.dart';
import 'package:meta/meta.dart';

import 'package:brick_sqlite_abstract/db.dart' show Migration;

import 'package:brick_sqlite/sqlite.dart';

export 'package:brick_offline_first/offline_first.dart' hide OfflineFirstRepository;
export 'package:brick_cloud_firestore_abstract/annotations.dart';
export 'package:brick_cloud_firestore_abstract/cloud_firestore_model.dart';

class OfflineFirstWithCloudFirestoreRepository
    extends OfflineFirstRepository<OfflineFirstWithCloudFirestoreModel> {
  /// The type declaration is important here for the rare circumstances that
  /// require interfacting with [RestProvider]'s client directly.
  @override
  final CloudFirestoreProvider remoteProvider;

  OfflineFirstWithCloudFirestoreRepository({
    @required CloudFirestoreProvider cloudFirestoreProvider,
    @required SqliteProvider sqliteProvider,
    MemoryCacheProvider memoryCacheProvider,
    Set<Migration> migrations,
    bool autoHydrate,
    String loggerName,
  })  : remoteProvider = cloudFirestoreProvider,
        super(
          autoHydrate: autoHydrate,
          loggerName: loggerName,
          memoryCacheProvider: memoryCacheProvider,
          migrations: migrations,
          sqliteProvider: sqliteProvider,
        );
}
