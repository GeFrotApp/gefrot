import 'package:cloud_firestore/cloud_firestore.dart';

class Logger {
  firebaseLog(e, {data}) {
    var firebase = FirebaseFirestore.instance;
    var dataToSave = {"timestamp": DateTime.now(), "error": e.toString()};
    if (data != null) {
      dataToSave.addAll(data);
    }
    firebase.collection("Logs").add(dataToSave);
  }
}
