import 'package:cloud_firestore/cloud_firestore.dart';

class Databasemethods {
  
  // Add data (Create)
  Future addData(Map<String, dynamic> infoMap, String id, String collectionName) async {
    return await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(id)
        .set(infoMap);
  }

  // Get data (Read - Stream)
  Future<Stream<QuerySnapshot>> getAllData(String collectionName) async {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .snapshots();
  }

  // Get selected data (Filter/Search)
  Future<Stream<QuerySnapshot>> getSelectedData(
      String collectionName, String field, String value) async {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .where(field, isEqualTo: value)
        .snapshots();
  }

  Future updateData(String collectionName, String id, Map<String, dynamic> updateMap) async {
    return await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(id)
        .update(updateMap);
  }

  Future deleteData(String collectionName, String id) async {
    return await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(id)
        .delete();
  }
}