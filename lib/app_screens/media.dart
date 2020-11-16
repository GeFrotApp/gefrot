import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/app_modules/abastecimento_module/abastecimento_base.dart';
import 'package:todomobx/app_screens/warnings.dart';
import 'package:todomobx/stores/abastecimento_base_store.dart';
import 'package:todomobx/stores/base_store.dart';
import 'package:todomobx/stores/home_store.dart';
import 'package:todomobx/widgets/base_top.dart';

import 'home.dart';

class Media extends StatefulWidget {
  @override
  Media(proposedAverage, currentAverage){
    this.proposedAverage = proposedAverage;
    this.currentAverage = currentAverage;
  }
  var proposedAverage;
  var currentAverage;
  _MediaState createState() => _MediaState(proposedAverage,currentAverage);
}

class _MediaState extends State<Media> {
  _MediaState(proposedAverage, currentAverage){
    this.proposedAverage = proposedAverage;
    this.currentAverage = currentAverage;
  }
  var proposedAverage;
  var currentAverage;

  BaseStore baseStore;
  var hora = new DateTime.now().hour;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    baseStore = Provider.of<BaseStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 230, 230, 230),
        child: SafeArea(
            child: Column(
          children: [
            BaseTop(),
            Container(
              padding: EdgeInsets.only(left: 5),
              height: MediaQuery.of(context).size.height * 0.07,
              color: Colors.white,
              child: Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), border: Border.all(color: Color.fromARGB(255, 140, 140, 140))),
                    child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_outlined,
                          color: Color.fromARGB(255, 170, 170, 170),
                          size: MediaQuery.of(context).size.width * 0.05,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ),
                  Text(
                    "  Médias",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height * 0.025,
                        color: Color.fromARGB(255, 100, 100, 100)),
                  ),
                  Icon(
                    Icons.graphic_eq,
                    size: MediaQuery.of(context).size.height * 0.035,
                    color: Color.fromARGB(255, 254, 182, 241),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01),
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.485,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text("Média atual"),
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.1, top: MediaQuery.of(context).size.width * 0.01),
                      ),
                      Container(
                        child: Text(
                          currentAverage.toStringAsFixed(3),
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.122, color: Color.fromARGB(255, 255, 145, 145)),
                        ),
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                      ),
                      Container(
                        child: Text(
                          "Km/L",
                          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03),
                        ),
                        margin: EdgeInsets.only(bottom: 1, left: MediaQuery.of(context).size.width * 0.36),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.01),
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.485,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text("Média Proposta"),
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1, top: 5),
                      ),
                      Container(
                        child: Text(
                            proposedAverage.toStringAsFixed(3),
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.122, color: currentAverage<proposedAverage?Color.fromARGB(255, 191, 191, 191):Colors.green),
                        ),
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                      ),
                      Container(
                        child: Text("Km/L", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03)),
                        margin: EdgeInsets.only(bottom: 1.5, left: MediaQuery.of(context).size.width * 0.36),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(
                child: Container(
                    margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                    width: MediaQuery.of(context).size.width * 0.98,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 20, top: 10),
                          child: (Text(
                            "Histórico",
                            style:
                                TextStyle(fontSize: 20, color: Color.fromARGB(255, 137, 202, 204), fontWeight: FontWeight.bold),
                          )),
                        ),
                        Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width,
                          color: Color.fromARGB(255, 230, 230, 230),
                        ),
                        Flexible(
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              color: Colors.white,
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('Drivers')
                                    .doc(baseStore.cpf)
                                    .collection('Averages')
                                    .snapshots(),
                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) return new Text('Loading...');
                                  return new ListView(
                                    children: snapshot.data.docs.map((DocumentSnapshot document) {
                                      return new Container(
                                          height: MediaQuery.of(context).size.height * 0.1,
                                          width: MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02, right: MediaQuery.of(context).size.width*0.02),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(width: 1, color: Color.fromARGB(255, 210, 210, 210)),
                                              bottom: BorderSide(width: 1, color: Color.fromARGB(255, 210, 210, 210)),
                                            ),
                                            color: Colors.white,
                                          ),

                                          child:  Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Placa",
                                                    style: TextStyle(
                                                      color: Color.fromARGB(255, 84, 84, 84),
                                                      fontSize: MediaQuery.of(context).size.width * 0.04,
                                                    ),
                                                  ),
                                                  Text(
                                                    document.id,
                                                    style: TextStyle(color: Color.fromARGB(255, 164, 164, 164)),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Sua média",
                                                    style: TextStyle(
                                                      color: Color.fromARGB(255, 84, 84, 84),
                                                      fontSize: MediaQuery.of(context).size.width * 0.04,
                                                    ),
                                                  ),
                                                  Text(
                                                    document['average'].toStringAsFixed(2),
                                                    style: TextStyle(color: Color.fromARGB(255, 164, 164, 164)),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Média proposta",
                                                    style: TextStyle(
                                                      color: Color.fromARGB(255, 84, 84, 84),
                                                      fontSize: MediaQuery.of(context).size.width * 0.04,
                                                    ),
                                                  ),
                                                  Text(
                                                    document['proposedAverage'].toStringAsFixed(2),
                                                    style: TextStyle(color: Color.fromARGB(255, 164, 164, 164)),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),

                                        );
                                    }).toList(),
                                  );
                                },
                              )),
                        ),

                      ],
                    )))
          ],
        )),
      ),
    );
  }
}
