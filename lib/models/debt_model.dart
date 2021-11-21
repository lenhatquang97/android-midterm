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
  String createdBy = '';
  DebtModel.empty();
  DebtModel(
      {required amount,
      required dueDate,
      required createdAt,
      required enable,
      required isDebt,
      required name,
      required note,
      required phone,
      required createdBy});
  Future<void> fetchDebt(docId, uid) async {
    final firestoreInstance = FirebaseFirestore.instance;
    await firestoreInstance.collection("khoanno").doc(docId).get().then((data) {
      createdBy = data["created_by"];
      if (createdBy == uid) {
        note = data["note"];
        dueDate = data["due_date"].toDate();
        amount = data["amount"];
        name = data["name"];
        enable = data["enable"];
        isDebt = data["is_debt"];
        createdAt = data["created_at"].toDate();
        phone = data["phone_number"];
      }
    });
  }

  Future<void> update(docId, uid, newData) async {
    if (createdBy == uid) {
      final firestoreInstance = FirebaseFirestore.instance;
      await firestoreInstance.collection('khoanno').doc(docId).update(newData);
      await fetchDebt(docId, uid);
    }
  }

  DebtModel.fromJson(Map<String, dynamic> json) {
    note = json['note'] as String;
    amount = json['amount'] as int;
    enable = json['enable'] as bool;
    dueDate = (json['due_date'] as Timestamp).toDate();
    name = json['name'] as String;
    createdAt = (json['created_at'] as Timestamp).toDate();
    phone = json['phone_number'] as String;
    createdBy = json['created_by'] as String;
    isDebt = json['is_debt'] as bool;
  }
}
