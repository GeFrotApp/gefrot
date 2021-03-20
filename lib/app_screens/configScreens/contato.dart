import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/stores/base_store.dart';
import 'package:todomobx/widgets/base_top.dart';
import 'package:todomobx/widgets/config_top.dart';

class Contato extends StatefulWidget {
  @override
  _ContatoState createState() => _ContatoState();
}

class _ContatoState extends State<Contato> {
  BaseStore baseStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    baseStore = Provider.of<BaseStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ConfigTop(
            "Fale conosco",
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.15,
                        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromARGB(255, 210, 210, 210)))),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.email,color: Color.fromARGB(255, 137,202, 204)),
                            Text(
                              "  gefrot@gmail.br",
                              textScaleFactor: 1,
                              style: TextStyle(
                                  color: Color.fromARGB(250, 137, 202, 204), fontSize: MediaQuery.of(context).size.width * 0.045),
                            )

                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          FlutterOpenWhatsapp.sendSingleMessage("+5541998186112", "");
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.15,
                          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromARGB(255, 210, 210, 210)))),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.whatsapp,
                                color: Color.fromARGB(255, 137, 202, 204),
                              ),
                              Text(
                                "  Fale conosco pelo whatsapp",
                                textScaleFactor: 1,
                                style: TextStyle(
                                    color: Color.fromARGB(250, 120, 120, 120), fontSize: MediaQuery.of(context).size.width * 0.045),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}
