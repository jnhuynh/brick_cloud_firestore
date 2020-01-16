import 'package:brick_core/core.dart';

abstract class CloudFirestoreModel extends Model {
  final String uuid;

  CloudFirestoreModel({this.uuid});
}
