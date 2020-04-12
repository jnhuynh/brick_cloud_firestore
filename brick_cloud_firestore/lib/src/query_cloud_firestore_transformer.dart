import 'package:brick_core/core.dart' as brick;
import 'package:cloud_firestore/cloud_firestore.dart';

class QueryCloudFirestoreTransformer {
  final brick.Query query;
  final CollectionReference ref;

  QueryCloudFirestoreTransformer(this.query, this.ref);

  Query get asFirebaseQuery {
    if (query == null) return ref;

    var composedRef = ref;
    if (query.where != null && query.where.isNotEmpty) {
      composedRef = query.where.fold<CollectionReference>(composedRef, (acc, condition) {
        return expandWhereCondition(condition, acc);
      });
    }

    if (query.providerArgs['limit'] != null) {
      composedRef = composedRef.limit(query.providerArgs['limit']);
    }

    if (query.providerArgs['orderBy'] != null) {
      final descending = (query.providerArgs['orderBy'] as String).endsWith('DESC');
      composedRef = composedRef.orderBy(query.providerArgs['orderBy'], descending: descending);
    }

    return composedRef;
  }

  /// Recursively append a Firestore `.where` condition to the existing reference
  ///
  /// TODO support associations
  Query expandWhereCondition(
    brick.WhereCondition condition,
    CollectionReference composedRef,
  ) {
    if (condition.conditions != null && condition.conditions.isNotEmpty) {
      return condition.conditions.fold<CollectionReference>(composedRef, (acc, _condition) {
        return expandWhereCondition(_condition, acc);
      });
    }

    switch (condition.compare) {
      case brick.Compare.exact:
        return composedRef.where(condition.evaluatedField, isEqualTo: condition.value);
      case brick.Compare.between:
        return composedRef.where(condition.evaluatedField,
            isGreaterThanOrEqualTo: condition.value[0], isLessThanOrEqualTo: condition.value[1]);
      case brick.Compare.contains:
        if (condition.value is Iterable) {
          return composedRef.where(condition.evaluatedField, arrayContainsAny: condition.value);
        }
        // substring hack as described here: https://stackoverflow.com/a/46568525
        return composedRef
            .where(condition.evaluatedField, isGreaterThanOrEqualTo: condition.value)
            .where(condition.evaluatedField, isLessThanOrEqualTo: condition.value);
      case brick.Compare.greaterThan:
        return composedRef.where(condition.evaluatedField, isGreaterThan: condition.value);
      case brick.Compare.lessThan:
        return composedRef.where(condition.evaluatedField, isLessThan: condition.value);
      case brick.Compare.greaterThanOrEqualTo:
        return composedRef.where(condition.evaluatedField, isGreaterThanOrEqualTo: condition.value);
      case brick.Compare.lessThanOrEqualTo:
        return composedRef.where(condition.evaluatedField, isLessThanOrEqualTo: condition.value);
      default:
        return composedRef;
    }
  }
}
