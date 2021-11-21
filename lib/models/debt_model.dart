import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DebtModel {
  int amount = 0;
  DateTime dueDate = DateTime.now();
  DateTime createdAt = DateTime.now();
  bool enable = true;
  bool isDebt = true;
  String name = '';
  String note = '';
  String phone = '';

  DebtModel(
      {required amount,
      required dueDate,
      required createdAt,
      required enable,
      required isDebt,
      required name,
      required note,
      required phone});
  Future<void> fetchOrder(docId) async {
    final firestoreInstance = FirebaseFirestore.instance;
    await firestoreInstance.collection("khoanno").doc(docId).get().then((data) {
      note = data["note"];
      phone = data["phone"];
      dueDate = data["dueDate"].toDate();
      name = data["name"];
      enable = data["enable"];
      isDebt = data["is_debt"];
      createdAt = data["created_at"].toDate();
      phone = data["phoneNumber"];
    });
  }
}
