import 'package:android_midterm/models/item.dart';
import 'package:android_midterm/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbols.dart';

class OrderProvider extends ChangeNotifier {
  // ignore: non_constant_identifier_names, prefer_final_fields
  late List<ItemOrder> _list_item = <ItemOrder>[];

  // ignore: non_constant_identifier_names
  List<ItemOrder> get list_item => _list_item;

  // ignore: non_constant_identifier_names
  void AddItem(ItemOrder item) {
    _list_item.add(item);
    notifyListeners();
  }

  // ignore: non_constant_identifier_names
  void DeleteItem(int index) {
    _list_item.removeAt(index);
    notifyListeners();
  }

  // ignore: non_constant_identifier_names
  void UpdateItem(ItemOrder item, int index) {
    _list_item[index] = item;
  }

  // ignore: non_constant_identifier_names
  Future<void> SaveOrder(String name, String phone, String note,
      GeoPoint location, String address, String createdBy) async {
    var data = <String, dynamic>{};
    data["name"] = name;
    data["phone_number"] = phone;
    data["note"] = note;
    data["location"] = location;
    data["address"] = address;
    data["enable"] = true;
    data["created_by"] = createdBy;
    data["products"] = [];
    for (var i = 0; i < _list_item.length; i++) {
      var temp = {"name": _list_item[i].item_name, "qua": _list_item[i].amount};
      data["products"].add(temp);
    }
    final firestoreInstance = FirebaseFirestore.instance;
    await firestoreInstance
        .collection("donhang")
        .add(data)
        .catchError((onError) => print(onError));
  }
}
