import 'package:brick_cloud_firestore/cloud_firestore.dart';

@ConnectOfflineFirstWithCloudFirestore()
class Pizza extends OfflineFirstWithCloudFirestoreModel {
  final List<Topping> toppings;

  final bool frozen;

  Pizza({
    this.toppings,
    this.frozen,
  });
}

enum Topping { olive, pepperoni }
