import "dart:ui";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:provider/provider.dart";
import "package:todomobx/stores/base_store.dart";
import "package:todomobx/widgets/base_top.dart";
import "package:todomobx/widgets/config_top.dart";

class ContaEmpresa extends StatefulWidget {
  @override
  _ContaEmpresaState createState() => _ContaEmpresaState();
}

class _ContaEmpresaState extends State<ContaEmpresa> {
  BaseStore baseStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    baseStore = Provider.of<BaseStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ConfigTop("Conta - Empresa",Expanded(child: Container(child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.15,
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromARGB(255, 210, 210, 210)))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Empresa",
                      textScaleFactor: 1,
                      style:
                      TextStyle(color: Color.fromARGB(250, 120, 120, 120), fontSize: MediaQuery.of(context).size.width * 0.045),
                    ),
                    Text(baseStore.nomeEmpresa,
                        textScaleFactor: 1,
                        style: TextStyle(
                            color: Color.fromARGB(250, 120, 120, 120), fontSize: MediaQuery.of(context).size.width * 0.030))
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.15,
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromARGB(255, 210, 210, 210)))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "CNPJ",
                      textScaleFactor: 1,
                      style:
                      TextStyle(color: Color.fromARGB(250, 120, 120, 120), fontSize: MediaQuery.of(context).size.width * 0.045),
                    ),
                    Text(baseStore.cnpj.substring(0,2)+". "+ baseStore.cnpj.substring(2,5)+". "+baseStore.cnpj.substring(5,8)+"/"+baseStore.cnpj.substring(8,12)+"-"+baseStore.cnpj.substring(12,14),
                        textScaleFactor: 1,
                        style: TextStyle(
                            color: Color.fromARGB(250, 120, 120, 120), fontSize: MediaQuery.of(context).size.width * 0.030))
                  ],
                ),
              ),
              Container(
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
                      "  Políticas da empresa",
                      textScaleFactor: 1,
                      style:
                      TextStyle(color: Color.fromARGB(250, 120, 120, 120), fontSize: MediaQuery.of(context).size.width * 0.045),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),),)));
  }
}
