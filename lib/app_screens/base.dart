import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/app_screens/warnings.dart';
import 'package:todomobx/login_screens/cadastro_1.dart';
import 'package:todomobx/stores/base_store.dart';
import 'package:todomobx/stores/cadastro_1_store.dart';
import 'package:todomobx/stores/home_store.dart';

import 'caminhao.dart';
import 'home.dart';

class Base extends StatefulWidget {
  @override
  _BaseState createState() => _BaseState();
}

class _BaseState extends State<Base> {
  int selectedIndex = 0;
  final widgetOptions = [
    Home(),
    Warnings(),
    Caminhao()

  ];
  var hora = new DateTime.now().hour;
  BaseStore baseStore;
  Cadastro1Store cadastro1Store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    baseStore = Provider.of<BaseStore>(context);
    cadastro1Store = Provider.of<Cadastro1Store>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          fixedColor: Color.fromARGB(255, 25, 153, 158),
          onTap: onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home,),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.warning),
              title: Text('Avisos'),
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.truckMoving),
              title: Text('Caminhão'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('Config'),
            ),
          ],
        ),
        body: SafeArea(
            child: Column(
              children: [
                Container(
                  height: 35,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 87, 181, 184)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(" |", style: TextStyle(
                              fontSize: 23, color: Colors.white),),
                          Text("GetFrot", style: TextStyle(fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),),
                          Text("|", style: TextStyle(
                              fontSize: 23, color: Colors.white),),
                        ],
                      ),
                      Row(
                        children: [
                          hora > 12
                              ? hora > 18
                              ? Text(
                            "Boa noite, " + baseStore.nome,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          )
                              : Text(
                            "Boa tarde, " + baseStore.nome,
                            style: TextStyle(
                                color: Colors.white, fontSize: 20),
                          )
                              : Text(
                            "Bom dia, " + baseStore.nome,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Icon(Icons.account_circle, color: Colors.white,)
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: 60,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.42,
                        child: Column(
                          children: [
                            Text(
                              'Cavalo',
                              style: TextStyle(color: Color.fromARGB(
                                  255, 170, 170, 170), fontSize:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .width *
                                  0.05),
                            ),
                            Container(
                                height: 30,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.28,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Color.fromARGB(
                                        255, 110, 110, 110)),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Observer(
                                    builder: (_) {
                                      return Text(cadastro1Store.placaCavalo,
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 170, 170, 170),
                                              fontSize:
                                              MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width *
                                                  0.05));
                                    },
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Text("|", style: TextStyle(fontSize: MediaQuery
                          .of(context)
                          .size
                          .height *
                          0.07,
                          color: Color.fromARGB(255, 170, 170, 170),
                          fontWeight: FontWeight.w100),),
                      Container(
                        height: 60,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.42,
                        child: Column(
                          children: [
                            Text(
                              'Carreta',
                              style: TextStyle(color: Color.fromARGB(
                                  255, 170, 170, 170), fontSize:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .width *
                                  0.05),
                            ),
                            Container(
                                height: 30,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.28,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Color.fromARGB(
                                        255, 110, 110, 110)),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Observer(
                                    builder: (_) {
                                      return Text(cadastro1Store.placaCarreta1,
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 170, 170, 170),
                                              fontSize:
                                              MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width *
                                                  0.05));
                                    },
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Text("|", style: TextStyle(fontSize: MediaQuery
                          .of(context)
                          .size
                          .height *
                          0.07,
                          color: Color.fromARGB(255, 170, 170, 170),
                          fontWeight: FontWeight.w100),),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.1,
                        child: IconButton(
                          icon: Icon(Icons.edit, size: MediaQuery
                              .of(context)
                              .size
                              .width * 0.06,),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 10,
                  decoration: BoxDecoration(color: Color.fromARGB(255,230,230,230)),
                ),
                Container(
                ),
                widgetOptions.elementAt(selectedIndex),

              ],
            )));
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }



}