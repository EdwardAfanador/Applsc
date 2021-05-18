import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lsc/src/model/words.dart';

class wordrepository {
  final DatabaseReference = FirebaseFirestore.instance;

  Stream<List<words>> getwords() {
    return DatabaseReference.collection("Palabras")
        .orderBy("Palabra")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => words.fromSnapshot(doc)).toList();
    });
  }
}
