import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String name;
  final int qua;

  Product({required this.name, required this.qua});
  Product.fromJson(Map<String, dynamic> json)
      : name = json["name"] as String,
        qua = json["qua"] as int;
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
  OrderModel();
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

  OrderModel.fromJson(Map<String, dynamic> json) {
    print(json);
    address = json['address'] as String;
    createdBy = json['created_by'] as String;
    dueDate = (json['due_date'] as Timestamp).toDate();
    enable = json['enable'] as bool;
    location = json['location'] as GeoPoint;
    name = json['name'] as String;
    note = json['note'] as String;
    phone = json['phone_number'] as String;
    if (json['product'] != null) {
      products = <Product>[];
      json['product'].forEach((v) {
        products.add(Product.fromJson(v));
      });
    }
  }
}
