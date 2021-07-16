import 'package:cloud_firestore/cloud_firestore.dart';

class Logger {
  firebaseLog(e, {data}) {
    var firebase = FirebaseFirestore.instance;
    var data = {"timestamp": DateTime.now(), "error":e.toString()};
    if(data!=null){
      data.addAll(data);
    }
    firebase.collection("Logs").add(data);
  }
}
