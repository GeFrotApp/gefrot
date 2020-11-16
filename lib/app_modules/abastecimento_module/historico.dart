import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/stores/abastecimento_base_store.dart';
import 'package:todomobx/stores/base_store.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Historico extends StatefulWidget {
  @override
  _HistoricoState createState() => _HistoricoState();
}

class _HistoricoState extends State<Historico> {
  BaseStore baseStore;
  var enDatesFuture = initializeDateFormatting('pt_BR', null);
  var formatter = DateFormat.yMMMMEEEEd('pt_BR').add_Hm();
  var hora = new DateTime.now().hour;
  AbastecimentoBaseStore abastecimentoBaseStore;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    baseStore = Provider.of<BaseStore>(context);
    abastecimentoBaseStore = Provider.of<AbastecimentoBaseStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("  Histórico de abastecimento",
            style: TextStyle(
                color: Color.fromARGB(255, 137, 202, 204),
                fontSize: MediaQuery.of(context).size.width * 0.05,
                fontWeight: FontWeight.bold)),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Flexible(
          child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Companies')
                    .doc(baseStore.cnpj)
                    .collection('Supplies')
                    .where("driverCPF", isEqualTo: baseStore.cpf)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return new Text('Loading...');
                  return new ListView(
                    children: snapshot.data.docs.map((DocumentSnapshot document) {
                      return new GestureDetector(
                        onTap: () {
                          abastecimentoBaseStore.documento = document.id;
                          abastecimentoBaseStore.data = document.data()["date"];
                          abastecimentoBaseStore.setPosto(document.data()['gasStationName']);
                          abastecimentoBaseStore.setCnpjPosto(document.data()['gasStationCnpj']);
                          abastecimentoBaseStore.setLitros(document.data()['amount']);
                          abastecimentoBaseStore.setNewOdometro(document.data()['odometerNew']);
                          abastecimentoBaseStore.setOldOdometro(document.data()['odometerOld']);
                          abastecimentoBaseStore.setNf(document.data()['invoice']);
                          abastecimentoBaseStore.setValor(document.data()['totalPrice']);
                          abastecimentoBaseStore.invoicePhoto=(document.data()['invoicePhoto']);
                          abastecimentoBaseStore.setTanqueCheio(document.data()['fullTank']);

                          abastecimentoBaseStore.setIndex(3);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(width: 1, color: Color.fromARGB(255, 210, 210, 210)),
                              bottom: BorderSide(width: 1, color: Color.fromARGB(255, 210, 210, 210)),
                            ),
                            color: Colors.white,
                          ),
                          child: Stack(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "  " + document['gasStationName'],
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 84, 84, 84),
                                      fontSize: MediaQuery.of(context).size.width * 0.05,
                                    ),
                                  ),
                                  Text(
                                    "   " +
                                        formatter.format(DateTime.fromMicrosecondsSinceEpoch(
                                            document['date'].microsecondsSinceEpoch + 75600000000)),
                                    style: TextStyle(color: Color.fromARGB(255, 164, 164, 164)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              )),
        )
      ],
    );
  }
}
