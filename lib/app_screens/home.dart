import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/app_modules/abastecimento_module/abastecimento_base.dart';
import 'package:todomobx/app_modules/checklist_module/checklist_base.dart';
import 'package:todomobx/stores/base_store.dart';
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    homeStore = Provider.of<HomeStore>(context);
    baseStore = Provider.of<BaseStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: Column(children: [
          true?Container():Container(
            height: MediaQuery.of(context).size.height * 0.30,
            width: MediaQuery.of(context).size.width * 0.99,
            margin: EdgeInsets.only(bottom: 2, right: 2),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              margin: EdgeInsets.all(15),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    elevation: 5,
                    child: Observer(
                      builder: (_) {
                        return RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          color: baseStore.jornada
                              ? Color.fromARGB(255, 187, 242, 164)
                              : Color.fromARGB(255, 253, 149, 149),
                          onPressed: baseStore.turnJornada,
                          child: Text(
                            baseStore.jornada
                                ? "Encerrar jornada"
                                : "Iniciar Jornada",
                            style: TextStyle(color: Colors.white, fontSize: 35),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 600,
              decoration: BoxDecoration(color: Colors.white,),
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChecklistBase()));
                            },
                            elevation: 10,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(
                                    color: Color.fromARGB(255, 204, 204, 204))),
                            child: Stack(
                              children: [
                                Center(
                                  child: Text(
                                    'Check list',
                                    style: TextStyle(
                                        fontSize: 21,
                                        color:
                                            Color.fromARGB(255, 170, 170, 170)),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  child: Icon(
                                    Icons.format_list_bulleted,
                                    size: 50,
                                    color: Color.fromARGB(255, 179, 232, 207),
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AbastecimentoBase()));
                            },
                            elevation: 10,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(
                                    color: Color.fromARGB(255, 204, 204, 204))),
                            child: Stack(
                              children: [
                                Center(
                                  child: Text(
                                    'Abastecimento',
                                    style: TextStyle(
                                        fontSize: 19,
                                        color:
                                            Color.fromARGB(255, 170, 170, 170)),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  child: FaIcon(
                                    FontAwesomeIcons.gasPump,
                                    size: 40,
                                    color: Color.fromARGB(255, 240, 240, 139),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.width * 0.4,
                          child: RaisedButton(
                            onPressed: () {},
                            elevation: 10,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(
                                    color: Color.fromARGB(255, 204, 204, 204))),
                            child: Stack(
                              children: [
                                Center(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Diário de ',
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Color.fromARGB(
                                              255, 170,170,170)),
                                    ),
                                    Text(
                                      'bordo',
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Color.fromARGB(
                                              255, 170, 170, 170)),
                                    ),
                                  ],
                                )),
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  child: Icon(
                                    Icons.access_time,
                                    size: 40,
                                    color: Color.fromARGB(255, 196, 212, 255),
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
                            onPressed: () {},
                            elevation: 10,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(
                                    color: Color.fromARGB(255, 204, 204, 204))),
                            child: Stack(
                              children: [
                                Center(
                                  child: Text(
                                    'Multas',
                                    style: TextStyle(
                                        fontSize: 25,
                                        color:
                                            Color.fromARGB(255, 170, 170, 170)),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  child: Icon(
                                    Icons.sim_card_alert,
                                    size: 50,
                                    color: Color.fromARGB(255, 255, 204, 116),
                                  ),
                                  margin: EdgeInsets.all(15),
                                )
                              ],
                            ),
                          )),
                    ],
                  ),
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
                            onPressed: () {},
                            elevation: 10,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(
                                    color: Color.fromARGB(255, 204, 204, 204))),
                            child: Stack(
                              children: [
                                Center(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Não ',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Color.fromARGB(
                                              255, 170, 170, 170)),
                                    ),
                                    Text(
                                      'conformidades',
                                      style: TextStyle(
                                          fontSize: 19,
                                          color: Color.fromARGB(
                                              255, 170, 170, 170)),
                                    ),
                                  ],
                                )),
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  child: FaIcon(
                                    FontAwesomeIcons.exclamationCircle,
                                    size: 35,
                                    color: Color.fromARGB(255, 255, 165, 165),
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
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_){
                                    return Media();
                                  }
                                )
                              );
                            },
                            elevation: 10,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(
                                    color: Color.fromARGB(255, 204, 204, 204))),
                            child: Stack(
                          children: [
                          Center(
                          child: Text(
                            'Médias',
                            style: TextStyle(
                                fontSize: 25,
                                color:
                                Color.fromARGB(255, 170, 170, 170)),
                          ),
                      ),
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  child: Icon(
                                    Icons.graphic_eq,
                                    size: 35,
                                    color: Color.fromARGB(255, 254, 182, 241),
                                  ),
                                  margin: EdgeInsets.all(15),
                                )
                              ],
                            ),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ))
        ]),
      ),
    );
  }
}
