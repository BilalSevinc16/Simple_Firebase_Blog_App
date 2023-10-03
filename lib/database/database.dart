import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Database {
  //Data insertion method
  Future<void> addData(blogData) async {
    FirebaseFirestore.instance
        .collection("Posts")
        .add(blogData)
        .catchError((error) {
      Fluttertoast.showToast(msg: "Error: $error");
    });
  }
}
