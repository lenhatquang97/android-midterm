import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DebtModel {
  int amount = 0;
  DateTime dueDate = DateTime.now();
  DateTime createdAt = DateTime.now();
  bool enable = true;
  bool isDebt = true;
  String name;
  String note = '';
  String phone = '';
  String createdBy = '';
  DebtModel(
      {required amount,
      required dueDate,
      required createdAt,
      required enable,
      required isDebt,
      this.name = "",
      required note,
      required phone,
      required createdBy});
  Future<void> fetchOrder(docId) async {
    final firestoreInstance = FirebaseFirestore.instance;
    await firestoreInstance.collection("khoanno").doc(docId).get().then((data) {
      note = data["note"] ?? "Unknown";
      phone = data["phone"] ?? "Unknown";
      dueDate = data["dueDate"].toDate() ?? DateTime.now();
      name = data["name"] ?? "";
      enable = data["enable"] ?? true;
      isDebt = data["is_debt"] ?? true;
      createdAt = data["created_at"].toDate();
      phone = data["phoneNumber"];
      createdBy = data["created_by"];
    });
  }
}
