import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestoreService {
  final FirebaseFirestore? db;

  CloudFirestoreService({this.db});

  Future<String> add(Map<String, dynamic> data) async {
    final document = await db?.collection('products').add(
          data,
        );
    return document!.id;
  }

   Stream<QuerySnapshot<Map<String, dynamic>>> getProducts() {
    return db!.collection('products').snapshots();
  }
}
