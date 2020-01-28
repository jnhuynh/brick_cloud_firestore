import 'dart:async';

import 'package:brick_cloud_firestore/cloud_firestore.dart';
import 'package:brick_core/core.dart' as brick;

class CloudFirestoreRepository implements brick.SingleProviderRepository {
  @override
  FutureOr<bool> delete<T extends brick.Model>(T instance, {brick.Query query}) {
    // TODO: implement delete
    return null;
  }

  @override
  FutureOr<List<T>> get<T extends brick.Model>({brick.Query query}) {
    // TODO: implement get
    return null;
  }

  @override
  Future<void> initialize() {
    // TODO: implement initialize
    return null;
  }

  @override
  final CloudFirestoreProvider provider = CloudFirestoreProvider();

  @override
  FutureOr<T> upsert<T extends brick.Model>(T instance, {brick.Query query}) {
    // TODO: implement upsert
    return null;
  }
}
