import 'package:android_midterm/models/item.dart';
import 'package:flutter/material.dart';

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
  bool SaveOrder() {
    for (var item in _list_item) {
      if (item.item_name.isEmpty || item.amount == 0) {
        return false;
      }
    }
    //Save order to database code
    return true;
  }
}
