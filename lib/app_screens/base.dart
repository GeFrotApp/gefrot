import "package:badges/badges.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter_mobx/flutter_mobx.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:provider/provider.dart";
import "package:todomobx/app_screens/warnings.dart";
import "package:todomobx/stores/base_store.dart";
import "package:todomobx/stores/cadastro_1_store.dart";
import "package:todomobx/widgets/base_top.dart";

import "caminhao.dart";
import "config.dart";
import "home.dart";

class Base extends StatefulWidget {
  @override
  _BaseState createState() => _BaseState();
}

class _BaseState extends State<Base> {
  int selectedIndex = 0;
  final widgetOptions = [Home(), Warnings(), Caminhao(), Config()];
  var hora = new DateTime.now().hour;
  late BaseStore baseStore;
  late Cadastro1Store cadastro1Store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    baseStore = Provider.of<BaseStore>(context);
    cadastro1Store = Provider.of<Cadastro1Store>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 230, 230, 230),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          fixedColor: Color.fromARGB(255, 137, 202, 204),
          onTap: onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 25,
              ),
              title: Text("Home", textScaleFactor: 1, style: TextStyle(fontSize: 20)),
            ),
            BottomNavigationBarItem(
              icon: Observer(
                builder: (context) {
                  return baseStore.warnings > 0
                      ? Badge(
                          badgeColor: Color.fromARGB(255, 255, 165, 165),
                          badgeContent: Text(
                            baseStore.warnings.toString(),
                            textScaleFactor: 1,
                            style: TextStyle(color: Colors.white),
                          ),
                          child: Icon(
                            Icons.warning_rounded,
                            size: 25,
                          ),
                        )
                      : Icon(
                          Icons.warning_rounded,
                          size: 25,
                        );
                },
              ),
              title: Text(
                "Avisos",
                textScaleFactor: 1,
                style: TextStyle(fontSize: 20),
              ),
            ),
            BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.truckMoving,
                size: 25,
              ),
              title: Text("Caminhão", textScaleFactor: 1, style: TextStyle(fontSize: 20)),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 25,
              ),
              title: Text(
                "Config",
                textScaleFactor: 1,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
        body: SafeArea(
            child: Column(
          children: [
            BaseTop(),
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
