import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/stores/base_store.dart';
import 'package:todomobx/stores/home_store.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Warnings extends StatefulWidget {
  @override
  _WarningsState createState() => _WarningsState();
}

class _WarningsState extends State<Warnings> {
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
              stream: Firestore.instance.collection('motoristas').document(baseStore.cpf.toString()).collection('avisos').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return new Text('Loading...');
                return new ListView(
                  children: snapshot.data.documents.map((DocumentSnapshot document) {
                    return new Container(
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
                              Text(document['texto'], style: TextStyle(fontSize: 25, color: Color.fromARGB(255, 163, 203, 215)),textAlign: TextAlign.start,),
                              Text(formatter.format(DateTime.fromMicrosecondsSinceEpoch(document['data'].microsecondsSinceEpoch+75600000000)), style: TextStyle(color: Colors.grey),),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 30, top: MediaQuery.of(context).size.height * 0.02,),
                                height: MediaQuery.of(context).size.height * 0.05,
                                width: MediaQuery.of(context).size.height * 0.05,
                                child: Stack(
                                  children: [
                                    RaisedButton(
                                        color: Color.fromARGB(255, 137, 202, 204),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(9.0),
                                        ),

                                        onPressed: (){},

                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Icon(Icons.edit, color: Colors.white, size: MediaQuery.of(context).size.height * 0.045,),
                                    )
                                  ],
                                )
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 30, top: MediaQuery.of(context).size.height * 0.02,),

                                height: MediaQuery.of(context).size.height * 0.05,
                                width: MediaQuery.of(context).size.height * 0.05,
                                  child: Stack(
                                    children: [
                                      RaisedButton(
                                        color: Color.fromARGB(255, 146, 245, 105),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(9.0),
                                        ),

                                        onPressed: (){
                                          print('oi');
                                        },

                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Icon(Icons.check, color: Colors.white, size: MediaQuery.of(context).size.height * 0.045,),
                                      )
                                    ],
                                  )
                              ),


                            ],
                          )
                        ],


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
