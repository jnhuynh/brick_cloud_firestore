import 'package:brick_build/src/builders/adapter_builder.dart';
import 'package:brick_build/src/builders/aggregate_builder.dart';
import 'package:brick_cloud_firestore_abstract/annotations.dart' show CloudFirestoreSerializable;
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
