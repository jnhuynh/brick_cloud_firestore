import 'package:brick_core/core.dart';
import 'package:brick_offline_first_abstract/abstract.dart';

abstract class CloudFirestoreModel implements Model {
  String documentId;

  static const String DOCUMENT_ID_FIELD_NAME = 'documentId';
  static const String DOCUMENT_ID_COLUMN_NAME = 'document_id';
}

abstract class OfflineFirstWithCloudFirestoreModel extends OfflineFirstModel
    with CloudFirestoreModel {}
