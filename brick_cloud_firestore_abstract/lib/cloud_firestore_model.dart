import 'package:brick_core/core.dart';

abstract class FirebaseModel extends Model {
  final String uuid;

  FirebaseModel({this.uuid});
}
