import 'package:brick_cloud_firestore/cloud_firestore.dart';
import 'package:pizza_shoppe/app/models/pizza.dart';

@ConnectOfflineFirstWithCloudFirestore()
class Customer extends OfflineFirstWithCloudFirestoreModel {
  final String firstName;

  final String lastName;

  final List<Pizza> pizzas;

  Customer({
    this.firstName,
    this.lastName,
    this.pizzas,
  });
}
