import 'package:brick_core/core.dart';
import 'package:brick_offline_first_abstract/abstract.dart';

abstract class CloudFirestoreModel implements Model {
  String get uuid;
}

abstract class OfflineFirstWithCloudFirestoreModel extends OfflineFirstModel
    with CloudFirestoreModel {}
