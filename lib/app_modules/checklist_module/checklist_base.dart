import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/app_modules/checklist_module/checklist_item.dart';
import 'package:todomobx/app_modules/checklist_module/checklist_selecao.dart';
import 'package:todomobx/app_modules/checklist_module/historico.dart';
import 'package:todomobx/app_modules/checklist_module/registro.dart';
import 'package:todomobx/stores/abastecimento_base_store.dart';
import 'package:todomobx/stores/checklist_base_store.dart';
import 'package:todomobx/widgets/base_top.dart';

class ChecklistBase extends StatefulWidget {
  @override
  _ChecklistBaseState createState() => _ChecklistBaseState();
}

class _ChecklistBaseState extends State<ChecklistBase> {
  ChecklistBaseStore checklistBaseStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    checklistBaseStore = Provider.of<ChecklistBaseStore>(context);

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
                              Icons.arrow_back_ios,
                              color: Color.fromARGB(255, 170, 170, 170),
                            ),
                            onPressed: () {
                              checklistBaseStore.index == 0
                                  ? Navigator.of(context).pop()
                                  : checklistBaseStore.setIndex(checklistBaseStore.index - 1);
                            }),
                      ),
                      Text(
                        "  Check-List  ",
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
                  height: 5,
                ),
                Observer(
                  builder: (_) {
                    return Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.width * 0.01),

                          width: MediaQuery.of(context).size.width ,
                          decoration: BoxDecoration(
                              color: checklistBaseStore.index==3?Color.fromARGB(255, 230, 230, 230):Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: checklistBaseStore.index == 0
                              ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width:
                                MediaQuery.of(context).size.width * 0.85,
                                height:
                                MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9
                                  ),
                                ),
                                child: RaisedButton(
                                  elevation: 10,
                                  color: Colors.white,
                                  onPressed: () {
                                    checklistBaseStore.setIndex(1);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Checklists", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 108, 190, 193)),),
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
                                    checklistBaseStore.setIndex(2);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Histórico de", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 108, 190, 193)),),
                                      Text("Checklists",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold, color: Color.fromARGB(255, 108, 190, 193)),)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                              : checklistBaseStore.index == 1?
                               CheckListSelecao()

                              : checklistBaseStore.index == 2?SingleChildScrollView(
                            child: CheckListHistorico(),
                          ):checklistBaseStore.index == 3?ChecklistItem():Container(),
                        ));
                  },
                )
              ],
            ),
          ),
        ));
  }
}
