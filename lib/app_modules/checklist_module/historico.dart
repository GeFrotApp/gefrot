import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/stores/base_store.dart';
import 'package:todomobx/stores/home_store.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class CheckListHistorico extends StatefulWidget {
  @override
  _CheckListHistoricoState createState() => _CheckListHistoricoState();
}

class _CheckListHistoricoState extends State<CheckListHistorico> {
  var enDatesFuture = initializeDateFormatting('pt_BR', null);
  var formatter = DateFormat.yMMMMEEEEd('pt_BR').add_Hm();
  var hora = new DateTime.now().hour;
  HomeStore homeStore;
  BaseStore baseStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    homeStore = Provider.of<HomeStore>(context);
    baseStore = Provider.of<BaseStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:Container(
          color: Colors.white,
          height: 400,
          child:
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('motoristas').doc(baseStore.cpf.toString()).collection('CheckLists').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return new Text('Loading...');
              return new ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return new GestureDetector(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.09,
                      width: MediaQuery.of(context).size.height,


                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                      ),
                      child: Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(document['Name'], style: TextStyle(fontSize: 25, color: Color.fromARGB(255, 163, 203, 215)),textAlign: TextAlign.start,),
                              Text(formatter.format(DateTime.fromMicrosecondsSinceEpoch(document['Date'].microsecondsSinceEpoch+75600000000)), style: TextStyle(color: Colors.grey),),
                            ],
                          ),
                        ],


                      ),
                    ),
                  );
                }).toList(),
              );
            },
          )


      ) ,
    );
  }
}
