import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  Future queryData(String querystring) async {
    return FirebaseFirestore.instance
        .collection("Palabras")
        .where("Palabra", isEqualTo: querystring)
        .get();
  }
}
