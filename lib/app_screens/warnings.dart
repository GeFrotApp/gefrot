import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/app_modules/abastecimento_module/abastecimento_base.dart';
import 'package:todomobx/stores/abastecimento_base_store.dart';
import 'package:todomobx/stores/base_store.dart';
import 'package:todomobx/stores/home_store.dart';

class Warnings extends StatefulWidget {
  @override
  _WarningsState createState() => _WarningsState();
}

class _WarningsState extends State<Warnings> {
  var enDatesFuture = initializeDateFormatting('pt_BR', null);
  List<String> warnings = ["supply"];
  var formatter = DateFormat.yMMMMEEEEd('pt_BR').add_Hm();
  var hora = new DateTime.now().hour;
  HomeStore homeStore;
  BaseStore baseStore;
  AbastecimentoBaseStore abastecimentoBaseStore;
  var fb = FirebaseFirestore.instance;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    homeStore = Provider.of<HomeStore>(context);
    baseStore = Provider.of<BaseStore>(context);
    abastecimentoBaseStore = Provider.of<AbastecimentoBaseStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 5),
                height: MediaQuery.of(context).size.height * 0.07,
                color: Colors.white,
                child: Row(
                  children: [
                    Text(
                      "  Avisos  ",
                      textScaleFactor: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.025,
                          color: Color.fromARGB(255, 100, 100, 100)),
                    ),
                    Icon(Icons.warning_rounded,
                        size: MediaQuery.of(context).size.height * 0.035, color: Color.fromARGB(255, 137, 202, 204)),
                  ],
                ),
              ),
              Container(
                height: 10,
                decoration: BoxDecoration(color: Color.fromARGB(255, 230, 230, 230)),
              ),
              Expanded(
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.55,
                    color: Colors.white,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: fb
                          .collection('Companies')
                          .doc(baseStore.cnpj.toString())
                          .collection('Warnings')
                          .where("type", whereIn: warnings)
                          .where("checked", isEqualTo: false)
                          .where("driverCPF", isEqualTo: baseStore.cpf)
                          .orderBy("date", descending: true)
                          .snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData)
                          return new Container(
                            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.024),
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              'Loading...',
                              textScaleFactor: 1,
                            ),
                          );
                        return new ListView(
                          children: snapshot.data.docs.map((DocumentSnapshot document) {
                            return new Container(
                              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.012),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                border: Border(
                                  //top: BorderSide(color: Colors.grey),
                                  bottom: BorderSide(color: Colors.grey, width: 1),
                                ),
                                color: Colors.white,
                              ),
                              child: Stack(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        document['text'],
                                        textScaleFactor: 1,
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context).size.width * 0.048,
                                            color: Color.fromARGB(255, 84, 84, 84)),
                                        textAlign: TextAlign.start,
                                      ),
                                      Text(
                                        "  " +
                                            formatter.format(
                                                DateTime.fromMicrosecondsSinceEpoch(document['date'].microsecondsSinceEpoch)),
                                        textScaleFactor: 1,
                                        style: TextStyle(color: Colors.grey, fontSize: MediaQuery.of(context).size.width * 0.035),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          var firestore;
                                          try {
                                            final result = await InternetAddress.lookup('example.com');
                                            if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {}
                                          } on SocketException catch (_) {
                                            await fb.disableNetwork();
                                          }
                                          var document2 = await document.data()['supply'].get();
                                          print(document2.data());
                                          abastecimentoBaseStore.documento = document2.id;
                                          abastecimentoBaseStore.data = document2.data()["date"];
                                          abastecimentoBaseStore.setPosto(document2.data()['gasStationName']);
                                          abastecimentoBaseStore.setCnpjPosto(document2.data()['gasStationCnpj']);
                                          abastecimentoBaseStore.setLitros(document2.data()['amount']);
                                          abastecimentoBaseStore.setNewOdometro(document2.data()['odometerNew']);
                                          abastecimentoBaseStore.setOldOdometro(document2.data()['odometerOld']);
                                          abastecimentoBaseStore.setNf(document2.data()['invoice']);
                                          abastecimentoBaseStore.setValor(document2.data()['totalPrice']);
                                          abastecimentoBaseStore.invoicePhoto = (document2.data()['invoicePhoto']);
                                          abastecimentoBaseStore.setTanqueCheio(document2.data()['fullTank']);

                                          abastecimentoBaseStore.setIndex(3, context, true);
                                          FirebaseFirestore.instance
                                              .collection('Companies')
                                              .doc(baseStore.cnpj)
                                              .collection('Warnings')
                                              .doc(document.id)
                                              .update({"checked": true});
                                          baseStore.setWarnings(-1);
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => AbastecimentoBase()));
                                        },
                                        child: Container(
                                            height: MediaQuery.of(context).size.height * 0.05,
                                            margin: EdgeInsets.only(
                                              right: MediaQuery.of(context).size.width * 0.01,
                                            ),
                                            decoration: BoxDecoration(
                                                border: Border(left: BorderSide(color: Color.fromARGB(255, 210, 210, 210)))),
                                            padding: EdgeInsets.only(
                                              left: MediaQuery.of(context).size.width * 0.02,
                                            ),
                                            width: MediaQuery.of(context).size.height * 0.05,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Icon(
                                                Icons.edit,
                                                color: Color.fromARGB(255, 210, 210, 210),
                                                size: MediaQuery.of(context).size.height * 0.030,
                                              ),
                                            )),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          FirebaseFirestore.instance
                                              .collection('Companies')
                                              .doc(baseStore.cnpj)
                                              .collection('Warnings')
                                              .doc(document.id)
                                              .update({"checked": true});
                                          baseStore.setWarnings(-1);
                                        },
                                        child: Container(
                                            height: MediaQuery.of(context).size.height * 0.05,
                                            margin: EdgeInsets.only(
                                              right: MediaQuery.of(context).size.width * 0.02,
                                              left: MediaQuery.of(context).size.width * 0.02,
                                            ),
                                            decoration: BoxDecoration(
                                                border: Border(left: BorderSide(color: Color.fromARGB(255, 210, 210, 210)))),
                                            padding: EdgeInsets.only(
                                              left: MediaQuery.of(context).size.width * 0.01,
                                            ),
                                            width: MediaQuery.of(context).size.height * 0.05,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Icon(
                                                Icons.check,
                                                color: Color.fromARGB(255, 210, 210, 210),
                                                size: MediaQuery.of(context).size.height * 0.040,
                                              ),
                                            )),
                                      )
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
          ),
        ),
      ),
    );
  }
}
