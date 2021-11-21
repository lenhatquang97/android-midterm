import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String name;
  final int qua;

  Product({required this.name, required this.qua});
}

class OrderModel {
  String note = '';
  String phone = '';
  String name = '';
  DateTime dueDate = DateTime.now();
  GeoPoint location = const GeoPoint(10.0, 10.0);
  String address = '';
  List<Product> products = [];
  bool enable = true;
  String createdBy = '';
  OrderModel() {}
  Future<void> fetchOrder(docId, uid) async {
    final firestoreInstance = FirebaseFirestore.instance;
    await firestoreInstance.collection("donhang").doc(docId).get().then((data) {
      createdBy = data["created_by"];
      if (createdBy == uid) {
        note = data["note"];
        phone = data["phone_number"];
        dueDate = data["due_date"].toDate();
        location = data["location"];
        address = data["address"];
        name = data["name"];
        enable = data["enable"];
        List<dynamic> tmp = List.from(data["product"]);
        products = [];
        for (var element in tmp) {
          // print(element['name']);
          products.add(Product(name: element['name'], qua: element['qua']));
        }
      }
    });
  }

  Future<void> update(docId, uid, newData) async {
    if (createdBy == uid) {
      final firestoreInstance = FirebaseFirestore.instance;
      await firestoreInstance.collection('donhang').doc(docId).update(newData);
      await fetchOrder(docId, uid);
    }
  }
}
