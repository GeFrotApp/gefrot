import "dart:ui";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:intl/date_symbol_data_local.dart";
import "package:intl/intl.dart";
import "package:provider/provider.dart";
import "package:todomobx/stores/abastecimento_base_store.dart";
import "package:todomobx/stores/base_store.dart";

class Historico extends StatefulWidget {
  @override
  _HistoricoState createState() => _HistoricoState();
}

class _HistoricoState extends State<Historico> {
  late BaseStore baseStore;
  var enDatesFuture = initializeDateFormatting("pt_BR", null);
  var formatter = DateFormat.yMMMMd("pt_BR");
  var hora = new DateTime.now().hour;
  late AbastecimentoBaseStore abastecimentoBaseStore;

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
            style: TextStyle(color: Color.fromARGB(255, 137, 202, 204), fontSize: MediaQuery.of(context).size.width * 0.05, fontWeight: FontWeight.bold)),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.015,
        ),
        Flexible(
          child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Companies")
                    .doc(baseStore.cnpj)
                    .collection("Supplies")
                    .where("driverCPF", isEqualTo: baseStore.cpf)
                    .orderBy("date", descending: true)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return new Text("Loading...");
                  }
                  return new ListView(
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      return new GestureDetector(
                        onTap: () {
                          abastecimentoBaseStore.documento = document.id;
                          abastecimentoBaseStore.data = document["date"];
                          abastecimentoBaseStore.setPosto(document["gasStationName"]);
                          abastecimentoBaseStore.setCnpjPosto(document["gasStationCnpj"]);
                          abastecimentoBaseStore.setLitros(document["amount"]);
                          abastecimentoBaseStore.setNewOdometro(document["odometerNew"]);
                          abastecimentoBaseStore.setOldOdometro(document["odometerOld"]);
                          abastecimentoBaseStore.setNf(document["invoice"]);
                          abastecimentoBaseStore.setValor(document["totalPrice"]);
                          abastecimentoBaseStore.invoicePhoto = (document["invoicePhoto"]);
                          abastecimentoBaseStore.setTanqueCheio(document["fullTank"]);
                          abastecimentoBaseStore.setPlacaCavalo(document["licensePlate"]);
                          abastecimentoBaseStore.setCombustivel(document["fuel"]);

                          abastecimentoBaseStore.setIndex(3, context, true);
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
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.52,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "  " +
                                          (document["gasStationName"].length > 10
                                              ? document["gasStationName"].substring(0, 10) + "..."
                                              : document["gasStationName"]),
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 84, 84, 84),
                                        fontSize: MediaQuery.of(context).size.width * 0.05,
                                      ),
                                    ),
                                    Text(
                                      "   " + formatter.format(DateTime.fromMicrosecondsSinceEpoch(document["date"].microsecondsSinceEpoch)),
                                      style: TextStyle(color: Color.fromARGB(255, 164, 164, 164)),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.28,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Valor tt",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 84, 84, 84),
                                        fontSize: MediaQuery.of(context).size.width * 0.05,
                                      ),
                                    ),
                                    Text(
                                      "R\$" + document["totalPrice"].toStringAsFixed(2).replaceAll(".", ","),
                                      style: TextStyle(color: Color.fromARGB(255, 164, 164, 164)),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Média",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 84, 84, 84),
                                        fontSize: MediaQuery.of(context).size.width * 0.05,
                                      ),
                                    ),
                                    Text(
                                      document["first"]||!document['fullTank'] ? "N/A" : document["average"].toStringAsFixed(2).replaceAll(".", ",") + "Km/l",
                                      style: TextStyle(
                                          color: document["first"]||!document['fullTank']
                                              ? Color.fromARGB(255, 120, 120, 120)
                                              : document["average"] >= baseStore.mediaProposta
                                                  ? Color.fromARGB(255, 163, 247, 127)
                                                  : Color.fromARGB(255, 255, 155, 155)),
                                    ),
                                  ],
                                ),
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
