import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/app_modules/abastecimento_module/abastecimento_base.dart';
import 'package:todomobx/app_modules/checklist_module/checklist_base.dart';
import 'package:todomobx/app_modules/diario_de_bordo_module/jornada_base.dart';
import 'package:todomobx/stores/base_store.dart';
import 'package:todomobx/stores/cadastro_1_store.dart';
import 'package:todomobx/stores/home_store.dart';

import 'media.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var hora = new DateTime.now().hour;
  HomeStore homeStore;
  BaseStore baseStore;
  Cadastro1Store cadastro1Store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    homeStore = Provider.of<HomeStore>(context);
    baseStore = Provider.of<BaseStore>(context);
    cadastro1Store = Provider.of<Cadastro1Store>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Observer(
        builder: (context){
          return Container(
            color: Colors.white,
            child: baseStore.loading
                ? Center(
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.width * 0.2,
                        child: CircularProgressIndicator(
                            strokeWidth: 10,
                            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                            backgroundColor: Color.fromARGB(255, 137, 202, 204)),
                      ),
                    )))
                :Column(children: [
              Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              Container(
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  height: MediaQuery.of(context).size.width * 0.4,
                                  child: RaisedButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => AbastecimentoBase()));
                                    },
                                    elevation: 10,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        side: BorderSide(color: Color.fromARGB(255, 204, 204, 204))),
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Text(
                                            'Abastecimento',textScaleFactor: 1,
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context).size.width * 0.04,
                                                fontWeight: FontWeight.w400,
                                                color: Color.fromARGB(255, 117, 117, 117)),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.bottomCenter,
                                          child: FaIcon(
                                            FontAwesomeIcons.gasPump,
                                            size: MediaQuery.of(context).size.width * 0.097,
                                            color: Color.fromARGB(255, 240, 240, 139),
                                          ),
                                          margin: EdgeInsets.all(15),
                                        )
                                      ],
                                    ),
                                  )),
                              Container(
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  height: MediaQuery.of(context).size.width * 0.4,
                                  child: RaisedButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChecklistBase()));
                                    },
                                    elevation: 10,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        side: BorderSide(color: Color.fromARGB(255, 204, 204, 204))),
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Text(
                                            'Check list',textScaleFactor: 1,
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context).size.width * 0.04,
                                                fontWeight: FontWeight.w400,
                                                color: Color.fromARGB(255, 117, 117, 117)),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.bottomCenter,
                                          child: Icon(
                                            Icons.format_list_bulleted,
                                            size: MediaQuery.of(context).size.width * 0.121,
                                            color: Color.fromARGB(255, 179, 232, 207),
                                          ),
                                          margin: EdgeInsets.all(15),
                                        )
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //     Container(
                          //         width: MediaQuery.of(context).size.width * 0.4,
                          //         height: MediaQuery.of(context).size.width * 0.4,
                          //         child: RaisedButton(
                          //           onPressed: () {
                          //             Navigator.push(context, MaterialPageRoute(builder: (context) => JornadaBase()));
                          //           },
                          //           elevation: 10,
                          //           color: Colors.white,
                          //           shape: RoundedRectangleBorder(
                          //               borderRadius: BorderRadius.circular(15),
                          //               side: BorderSide(color: Color.fromARGB(255, 204, 204, 204))),
                          //           child: Stack(
                          //             children: [
                          //               Center(
                          //                   child: Column(
                          //                 crossAxisAlignment: CrossAxisAlignment.center,
                          //                 mainAxisAlignment: MainAxisAlignment.center,
                          //                 children: [
                          //                   Text(
                          //                     'Diário de ',textScaleFactor: 1,
                          //                     style: TextStyle(
                          //                         fontSize: MediaQuery.of(context).size.width * 0.04,
                          //                         fontWeight: FontWeight.w400,
                          //                         color: Color.fromARGB(255, 120, 120, 120)),
                          //                   ),
                          //                   Text(
                          //                     'bordo',textScaleFactor: 1,
                          //                     style: TextStyle(
                          //                         fontSize: MediaQuery.of(context).size.width * 0.04,
                          //                         fontWeight: FontWeight.w400,
                          //                         color: Color.fromARGB(255, 120, 120, 120)),
                          //                   ),
                          //                 ],
                          //               )),
                          //               Container(
                          //                 alignment: Alignment.bottomCenter,
                          //                 child: Icon(
                          //                   Icons.access_time,
                          //                   size: MediaQuery.of(context).size.width * 0.097,
                          //                   color: Color.fromARGB(255, 196, 212, 255),
                          //                 ),
                          //                 margin: EdgeInsets.all(15),
                          //               )
                          //             ],
                          //           ),
                          //         )),
                          //     Container(
                          //         width: MediaQuery.of(context).size.width * 0.4,
                          //         height: MediaQuery.of(context).size.width * 0.4,
                          //         child: RaisedButton(
                          //           onPressed: () {},
                          //           elevation: 10,
                          //           color: Colors.white,
                          //           shape: RoundedRectangleBorder(
                          //               borderRadius: BorderRadius.circular(15),
                          //               side: BorderSide(color: Color.fromARGB(255, 204, 204, 204))),
                          //           child: Stack(
                          //             children: [
                          //               Center(
                          //                 child: Text(
                          //                   'Multas',textScaleFactor: 1,
                          //                   style: TextStyle(
                          //                       fontSize: MediaQuery.of(context).size.width * 0.04,
                          //                       fontWeight: FontWeight.w400,
                          //                       color: Color.fromARGB(255, 120, 120, 120)),
                          //                 ),
                          //               ),
                          //               Container(
                          //                 alignment: Alignment.bottomCenter,
                          //                 child: Icon(
                          //                   Icons.sim_card_alert,
                          //                   size: MediaQuery.of(context).size.width * 0.121,
                          //                   color: Color.fromARGB(255, 255, 204, 116),
                          //                 ),
                          //                 margin: EdgeInsets.all(15),
                          //               )
                          //             ],
                          //           ),
                          //         )),
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: 30,
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Container(
                              //     width: MediaQuery.of(context).size.width * 0.4,
                              //     height: MediaQuery.of(context).size.width * 0.4,
                              //     child: RaisedButton(
                              //       onPressed: () {},
                              //       elevation: 10,
                              //       color: Colors.white,
                              //       shape: RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(15),
                              //           side: BorderSide(color: Color.fromARGB(255, 204, 204, 204))),
                              //       child: Stack(
                              //         children: [
                              //           Center(
                              //               child: Column(
                              //             crossAxisAlignment: CrossAxisAlignment.center,
                              //             mainAxisAlignment: MainAxisAlignment.center,
                              //             children: [
                              //               Text(
                              //                 'Não ',textScaleFactor: 1,
                              //                 style: TextStyle(
                              //                     fontSize: MediaQuery.of(context).size.width * 0.04,
                              //                     fontWeight: FontWeight.w400,
                              //                     color: Color.fromARGB(255, 120, 120, 120)),
                              //               ),
                              //               Text(
                              //                 'conformidades',textScaleFactor: 1,
                              //                 style: TextStyle(
                              //                     fontSize: MediaQuery.of(context).size.width * 0.04,
                              //                     fontWeight: FontWeight.w400,
                              //                     color: Color.fromARGB(255, 120, 120, 120)),
                              //               ),
                              //             ],
                              //           )),
                              //           Container(
                              //             alignment: Alignment.bottomCenter,
                              //             child: FaIcon(
                              //               FontAwesomeIcons.exclamationCircle,
                              //               size: MediaQuery.of(context).size.width * 0.085,
                              //               color: Color.fromARGB(255, 255, 165, 165),
                              //             ),
                              //             margin: EdgeInsets.all(15),
                              //           )
                              //         ],
                              //       ),
                              //     )),
                              Container(
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  height: MediaQuery.of(context).size.width * 0.4,
                                  child: RaisedButton(
                                    onPressed: () async {
                                      baseStore.turnLoading();
                                      var average = (await FirebaseFirestore.instance
                                          .collection('Drivers')
                                          .doc(baseStore.cpf)
                                          .collection('Averages')
                                          .doc(cadastro1Store.placaCavalo)
                                          .get());
                                      print(baseStore.cpf);
                                      var proposedAverage = 0.0;
                                      var currentAverage = 0.0;
                                      if (average.exists) {
                                        proposedAverage = average.data()['proposedAverage'];
                                        currentAverage = average.data()['average'];
                                      }
                                      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                                        return Media(proposedAverage, currentAverage);
                                      }));
                                      baseStore.turnLoading();
                                    },
                                    elevation: 10,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        side: BorderSide(color: Color.fromARGB(255, 204, 204, 204))),
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Text(
                                            'Médias',textScaleFactor: 1,
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context).size.width * 0.04,
                                                fontWeight: FontWeight.w400,
                                                color: Color.fromARGB(255, 117, 117, 117)),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.bottomCenter,
                                          child: Icon(
                                            Icons.graphic_eq,
                                            size: MediaQuery.of(context).size.width * 0.085,
                                            color: Color.fromARGB(255, 254, 182, 241),
                                          ),
                                          margin: EdgeInsets.all(15),
                                        )
                                      ],
                                    ),
                                  )),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: MediaQuery.of(context).size.width * 0.4,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ))
            ]),
          );
        },
      )
    );
  }
}
