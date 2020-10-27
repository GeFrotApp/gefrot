import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/app_modules/abastecimento_module/abastecimento_base.dart';
import 'package:todomobx/stores/abastecimento_base_store.dart';
import 'package:todomobx/stores/base_store.dart';
import 'package:todomobx/stores/home_store.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:todomobx/widgets/base_top.dart';

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
  AbastecimentoBaseStore abastecimentoBaseStore;

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
                    Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10), border: Border.all(color: Color.fromARGB(255, 140, 140, 140))),
                      child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_outlined,
                            size: MediaQuery.of(context).size.width*0.05,
                            color: Color.fromARGB(255, 170, 170, 170),
                          ),
                          onPressed: () {}),
                    ),
                    Text(
                      "  Avisos  ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.025,
                          color: Color.fromARGB(255, 100, 100, 100)),
                    ),
                    Icon(Icons.warning,
                        size: MediaQuery.of(context).size.height * 0.035, color: Color.fromARGB(255, 25, 153, 158)),
                  ],
                ),
              ),
              Container(
                height: 5,
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.55,
                  color: Colors.white,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Drivers')
                        .doc(baseStore.cpf.toString())
                        .collection('Warnings')
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData)
                        return new Container(
                          padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.024),
                          width: MediaQuery.of(context).size.width,
                          child: Text('Loading...'),
                        );
                      return new ListView(
                        children: snapshot.data.docs.map((DocumentSnapshot document) {
                          return new Container(
                            padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.012),
                            height: MediaQuery.of(context).size.height * 0.09,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(color: Colors.grey),
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
                                      document['text'],
                                      style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.048, color: Color.fromARGB(255, 84, 84, 84)),
                                      textAlign: TextAlign.start,
                                    ),
                                    Text(
                                      "  " +
                                          formatter.format(DateTime.fromMicrosecondsSinceEpoch(
                                              document['date'].microsecondsSinceEpoch + 75600000000)),
                                      style: TextStyle(color: Colors.grey, fontSize: MediaQuery.of(context).size.width*0.035),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () async{
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
                                        abastecimentoBaseStore.invoicePhoto=(document2.data()['invoicePhoto']);
                                        abastecimentoBaseStore.setTanqueCheio(document2.data()['fullTank']);

                                        abastecimentoBaseStore.setIndex(3);
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => AbastecimentoBase()));
                                      },
                                      child: Container(
                                          margin: EdgeInsets.only(
                                            right: MediaQuery.of(context).size.width*0.072,
                                            top: MediaQuery.of(context).size.height * 0.02,
                                          ),
                                          height: MediaQuery.of(context).size.height * 0.035,
                                          width: MediaQuery.of(context).size.height * 0.035,
                                          decoration: BoxDecoration(
                                              color: Color.fromARGB(255, 137, 202, 204),
                                              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width*0.024),
                                              border: Border.all(color: Color.fromARGB(255, 25, 153, 158), width: 1)),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                              size: MediaQuery.of(context).size.height * 0.030,
                                            ),
                                          )),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        print("Oi");
                                      },
                                      child: Container(
                                          margin: EdgeInsets.only(
                                            right: MediaQuery.of(context).size.width*0.072,
                                            top: MediaQuery.of(context).size.height * 0.02,
                                          ),
                                          height: MediaQuery.of(context).size.height * 0.035,
                                          width: MediaQuery.of(context).size.height * 0.035,
                                          decoration: BoxDecoration(
                                              color: Color.fromARGB(255, 156, 255, 115),
                                              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width*0.024),
                                              border: Border.all(color: Color.fromARGB(255, 118, 255, 62), width: 1)),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: MediaQuery.of(context).size.height * 0.030,
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
            ],
          ),
        ),
      ),
    );
  }
}
