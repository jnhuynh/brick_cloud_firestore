import 'package:brick_build/src/utils/shared_checker.dart';
import 'package:brick_cloud_firestore_abstract/cloud_firestore_model.dart';
import 'package:brick_cloud_firestore_build/src/cloud_firestore_field_serdes_generator.dart';
import 'package:source_gen/source_gen.dart' show TypeChecker;
import 'package:analyzer/dart/element/type.dart';

const _serdesClassChecker = TypeChecker.fromRuntime(CloudFirestoreFieldSerdesGenerator);

class CloudFirestoreTypeChecker extends SharedChecker<CloudFirestoreModel> {
  CloudFirestoreTypeChecker(DartType type) : super(type);

  @override
  bool get isSerializable {
    final alreadySerializable = super.isSerializable;
    if (alreadySerializable) return true;

    if (isIterable) {
      final argTypeChecker = CloudFirestoreTypeChecker(argType);

      return argTypeChecker.hasSerdes ||
          (argTypeChecker.isFuture && argTypeChecker.canSerializeArgType);
    }

    return hasSerdes || (isFuture && canSerializeArgType);
  }

  /// This class has serialize methods and deserialize factories.
  /// Useful for non-primitive types that are not associations but should still be
  /// serialized and deserialized as a field.
  bool get hasSerdes => _serdesClassChecker.isSuperTypeOf(targetType);
}
