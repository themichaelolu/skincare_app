import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestoreService {
  final FirebaseFirestore db;

  CloudFirestoreService(this.db);

  Future<String> add(Map<String, dynamic> data) async {
    final document = await db.collection('user').add(
      data,
    );
    return document.id;
  }
}
