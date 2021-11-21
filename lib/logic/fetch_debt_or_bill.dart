//Fetch data from cloud_firestore
import 'package:android_midterm/utils/user_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, Map<String, dynamic>>> fetchData(
    String collectionType) async {
  final uid = await SecureStorage.readSecureData(SecureStorage.userID);
  final firestore = FirebaseFirestore.instance;
  final result = await firestore.collection(collectionType).get();
  final docFilter =
      result.docs.where((element) => element.data()['created_by'] == uid);
  if (docFilter.isNotEmpty) {
    return {for (var docs in docFilter) docs.id: docs.data()};
  }
  return {};
}

void fetchTest() async {
  final uid = await SecureStorage.readSecureData(SecureStorage.userID);
  final firestore = FirebaseFirestore.instance;
  final result = await firestore.collection('khoanno').get();
  final docFilter =
      result.docs.where((element) => element.data()['created_by'] == uid);
  if (docFilter.isNotEmpty) {
    for (var e in docFilter) {
      print(e.data());
    }
  }
}
