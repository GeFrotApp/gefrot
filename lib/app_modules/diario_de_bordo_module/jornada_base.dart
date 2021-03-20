import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/app_modules/checklist_module/checklist_historico.dart';
import 'package:todomobx/app_modules/checklist_module/checklist_item.dart';
import 'package:todomobx/app_modules/diario_de_bordo_module/selecao.dart';
import 'package:todomobx/stores/jornada_base_store.dart';
import 'package:todomobx/widgets/base_top.dart';

class JornadaBase extends StatefulWidget {
  @override
  _JornadaBaseState createState() => _JornadaBaseState();
}

class _JornadaBaseState extends State<JornadaBase> {
  JornadaBaseStore jornadaBaseStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    jornadaBaseStore = Provider.of<JornadaBaseStore>(context);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                        child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios_outlined,
                              color: Color.fromARGB(255, 120, 120, 120),
                              size: MediaQuery.of(context).size.width*0.05,
                            ),
                            onPressed: () {
                              jornadaBaseStore.index == 0
                                  ? Navigator.of(context).pop()
                                  : jornadaBaseStore.index==2||jornadaBaseStore.index==4?jornadaBaseStore.setIndex(jornadaBaseStore.index-1):jornadaBaseStore.setIndex(0);

                              }
                            ),
                      ),
                      Text(
                        "  Diário de bordo  ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                            MediaQuery.of(context).size.height * 0.025,
                            color: Color.fromARGB(255, 100, 100, 100)),
                      ),
                      Icon(Icons.format_list_bulleted,
                          size: MediaQuery.of(context).size.height * 0.035,
                          color: Color.fromARGB(255, 179, 232, 207)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Observer(
                  builder: (_) {
                    return Expanded(
                        child: Container(

                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.width * 0.01),

                          width: MediaQuery.of(context).size.width ,
                          decoration: BoxDecoration(
                              color: jornadaBaseStore.index==1?Color.fromARGB(255, 230, 230, 230):Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: jornadaBaseStore.index == 0
                              ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width:
                                MediaQuery.of(context).size.width * 0.95,
                                height:
                                MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9
                                  ),
                                ),
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                  ),
                                  elevation: 5,
                                  color: Colors.white,
                                  onPressed: () {
                                    jornadaBaseStore.setIndex(1);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Jornada", style: TextStyle(fontSize: 30, color: Color.fromARGB(255, 137, 202, 204)),),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width:
                                MediaQuery.of(context).size.width * 0.95,
                                height:
                                MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                  ),
                                  elevation: 5,
                                  color: Colors.white,
                                  onPressed: () {
                                    jornadaBaseStore.setIndex(3);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Histórico de", style: TextStyle(fontSize: 30, color: Color.fromARGB(255, 137, 202, 204)),),
                                      Text("Jornadas",style: TextStyle(fontSize: 30, color: Color.fromARGB(255, 137, 202, 204)),)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                              : jornadaBaseStore.index == 1?
                               Jornada()

                              : jornadaBaseStore.index == 2?
                          ChecklistItem()
                          :jornadaBaseStore.index == 3?CheckListHistorico():ChecklistItem(),
                        ));
                  },
                )
              ],
            ),
          ),
        ));
  }
}
