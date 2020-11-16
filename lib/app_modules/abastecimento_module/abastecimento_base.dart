import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/app_modules/abastecimento_module/documento.dart';
import 'package:todomobx/app_modules/abastecimento_module/historico.dart';
import 'package:todomobx/app_modules/abastecimento_module/registro.dart';
import 'package:todomobx/stores/abastecimento_base_store.dart';
import 'package:todomobx/widgets/base_top.dart';

class AbastecimentoBase extends StatefulWidget {
  @override
  _AbastecimentoBaseState createState() => _AbastecimentoBaseState();
}

class _AbastecimentoBaseState extends State<AbastecimentoBase> {
  AbastecimentoBaseStore abastecimentoBaseStore;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    abastecimentoBaseStore = Provider.of<AbastecimentoBaseStore>(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          color: Color.fromARGB(255, 230, 230, 230),
          child: SafeArea(
            child: Column(
              children: [
                BaseTop(),
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
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Color.fromARGB(255, 140, 140, 140))),
                        child: Center(
                          child: IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios_rounded,
                                color: Color.fromARGB(255, 170, 170, 170),
                                  size: MediaQuery.of(context).size.width*0.05,
                              ),
                              onPressed: () {
                                abastecimentoBaseStore.index == 0
                                    ? Navigator.of(context).pop()
                                    : abastecimentoBaseStore.setIndex(0);
                              }),
                        )
                      ),
                      Text(
                        "  Abastecimento  ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.025,
                            color: Color.fromARGB(255, 100, 100, 100)),
                      ),
                      FaIcon(FontAwesomeIcons.gasPump,
                          size: MediaQuery.of(context).size.height * 0.035,
                          color: Color.fromARGB(255, 230, 230, 59)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Observer(
                  builder: (_) {
                    return Expanded(
                        child: Container(
                      margin: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.01),
                      width: MediaQuery.of(context).size.width * 0.98,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: abastecimentoBaseStore.index == 0
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  height:
                                      MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: RaisedButton(
                                    elevation: 10,
                                    color: Colors.white,
                                    onPressed: () {
                                      abastecimentoBaseStore.setIndex(1);
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Registrar", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 108, 190, 193)),),
                                        Text("Abastecimento",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold, color: Color.fromARGB(255, 108, 190, 193)),)
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  height:
                                      MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: RaisedButton(
                                    elevation: 10,
                                    color: Colors.white,
                                    onPressed: () {
                                      abastecimentoBaseStore.setIndex(2);
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Histórico de", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 108, 190, 193)),),
                                        Text("Abastecimentos",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold, color: Color.fromARGB(255, 108, 190, 193)),)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : abastecimentoBaseStore.index == 1
                              ? SingleChildScrollView(
                        child: Registro(),
                      )
                              : abastecimentoBaseStore.index ==2?Container(child: Historico(),):Documento(),
                    ));
                  },
                )
              ],
            ),
          ),
        ));
  }
}
