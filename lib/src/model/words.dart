import 'package:cloud_firestore/cloud_firestore.dart';

class words {
  final String palabra, desc, urlimagen, id;

  const words(this.palabra, this.desc, this.urlimagen, this.id);

  static words fromSnapshot(DocumentSnapshot snapshot) {
    return words(snapshot.get("Palabra"), snapshot.get("desc"),
        snapshot.get("urlimage"), snapshot.id);
  }
}
