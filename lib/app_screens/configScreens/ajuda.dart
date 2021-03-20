import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/stores/base_store.dart';
import 'package:todomobx/widgets/base_top.dart';
import 'package:todomobx/widgets/config_top.dart';

import 'contato.dart';

class Ajuda extends StatefulWidget {
  @override
  _AjudaState createState() => _AjudaState();
}

class _AjudaState extends State<Ajuda> {
  BaseStore baseStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    baseStore = Provider.of<BaseStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ConfigTop("Ajuda",Expanded(child: Container(child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context){
                      return Contato();
                    }
                  ));
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
                      Icon(Icons.people, color: Color.fromARGB(255, 137,202, 204),),
                      Text(
                        "  Fale conosco",
                        textScaleFactor: 1,
                        style:
                        TextStyle(color: Color.fromARGB(250, 120, 120, 120), fontSize: MediaQuery.of(context).size.width * 0.045),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  baseStore.showTerms(context);
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
                      FaIcon(FontAwesomeIcons.book, color: Color.fromARGB(255, 137,202, 204),),
                      Text(
                        "  Termos e política de privacidade",
                        textScaleFactor: 1,
                        style:
                        TextStyle(color: Color.fromARGB(250, 120, 120, 120), fontSize: MediaQuery.of(context).size.width * 0.045),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),),)));
  }
}
