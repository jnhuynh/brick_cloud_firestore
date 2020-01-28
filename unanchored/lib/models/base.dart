import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

abstract class Base extends Equatable {
  final String uuid;
  final Timestamp createdAt;

  Base({this.uuid, this.createdAt});

  Base copyWith();

  Map<String, dynamic> toJson();

  String get formattedCreatedAt => DateFormat('yyyy/MM/dd').format(createdAt.toDate());
}
