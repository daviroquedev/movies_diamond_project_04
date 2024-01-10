import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  final user = <String, dynamic>{
    "first": "Ada",
    "last": "Lovelace",
    "born": 1815
  };

  try {
    final db = FirebaseFirestore.instance;
    final docRef = await db.collection("users").add(user);
    print('DocumentSnapshot added with ID: ${docRef.id}');
  } catch (e) {
    print('Error adding user: $e');
  }
}
