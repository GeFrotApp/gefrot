import "dart:ui";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:provider/provider.dart";
import "package:todomobx/login_screens/pass_recover_1.dart";
import "package:todomobx/stores/base_store.dart";
import "package:todomobx/widgets/base_top.dart";
import "package:todomobx/widgets/config_top.dart";

class Seguranca extends StatefulWidget {
  @override
  _SegurancaState createState() => _SegurancaState();
}

class _SegurancaState extends State<Seguranca> {
  BaseStore baseStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    baseStore = Provider.of<BaseStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ConfigTop("Segurança",Expanded(child: Container(child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return PassRecover1();
                  }));
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
                      FaIcon(FontAwesomeIcons.key, color: Color.fromARGB(255, 137,202, 204),),
                      Text(
                        "  Modificar senha",
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
