import "dart:io";

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_mobx/flutter_mobx.dart";
import "package:provider/provider.dart";
import "package:todomobx/app_modules/checklist_module/checklist_historico.dart";
import "package:todomobx/app_modules/checklist_module/checklist_item.dart";
import "package:todomobx/app_modules/checklist_module/checklist_selecao.dart";
import "package:todomobx/stores/base_store.dart";
import "package:todomobx/stores/checklist_base_store.dart";
import "package:todomobx/widgets/base_top.dart";

class ChecklistBase extends StatefulWidget {
  @override
  _ChecklistBaseState createState() => _ChecklistBaseState();
}

class _ChecklistBaseState extends State<ChecklistBase> {
  late ChecklistBaseStore checklistBaseStore;
  late BaseStore baseStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    checklistBaseStore = Provider.of<ChecklistBaseStore>(context);
    baseStore = Provider.of<BaseStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          checklistBaseStore.setIndex(0);
          return true;
        },
        child: Scaffold(
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
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Color.fromARGB(255, 140, 140, 140))),
                            child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios_outlined,
                                  color: Color.fromARGB(255, 120, 120, 120),
                                  size: MediaQuery.of(context).size.width * 0.05,
                                ),
                                onPressed: () {
                                  checklistBaseStore.index == 0
                                      ? Navigator.of(context).pop()
                                      : checklistBaseStore.index == 2 || checklistBaseStore.index == 4
                                          ? checklistBaseStore.setIndex(checklistBaseStore.index - 1)
                                          : checklistBaseStore.setIndex(0);
                                }),
                          ),
                          Text(
                            "  Check-List  ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.height * 0.025, color: Color.fromARGB(255, 100, 100, 100)),
                          ),
                          Icon(Icons.format_list_bulleted, size: MediaQuery.of(context).size.height * 0.035, color: Color.fromARGB(255, 179, 232, 207)),
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
                          margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.01),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: checklistBaseStore.index == 3 ? Color.fromARGB(255, 230, 230, 230) : Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: checklistBaseStore.index == 0
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.95,
                                      height: MediaQuery.of(context).size.width * 0.3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(9),
                                      ),
                                      child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                        ),
                                        elevation: 5,
                                        color: Colors.white,
                                        onPressed: () async {
                                          checklistBaseStore.setIndex(1);
                                          try {
                                            final result = await InternetAddress.lookup("example.com");
                                            if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                                              baseStore.online = true;
                                              UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
                                            }
                                          } on SocketException catch (_) {
                                            baseStore.online = false;
                                          }
                                        },
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Check-lists",
                                              style: TextStyle(fontSize: 30, color: Color.fromARGB(255, 137, 202, 204)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.95,
                                      height: MediaQuery.of(context).size.width * 0.3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                        ),
                                        elevation: 5,
                                        color: Colors.white,
                                        onPressed: () async {
                                          try {
                                            final result = await InternetAddress.lookup("example.com");
                                            if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                                              baseStore.online = true;
                                              UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
                                            }
                                          } on SocketException catch (_) {
                                            baseStore.online = false;
                                          }
                                          checklistBaseStore.setIndex(3);
                                        },
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Histórico de",
                                              style: TextStyle(fontSize: 30, color: Color.fromARGB(255, 137, 202, 204)),
                                            ),
                                            Text(
                                              "Check-lists",
                                              style: TextStyle(fontSize: 30, color: Color.fromARGB(255, 137, 202, 204)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : checklistBaseStore.index == 1
                                  ? CheckListSelecao()
                                  : checklistBaseStore.index == 2
                                      ? ChecklistItem()
                                      : checklistBaseStore.index == 3
                                          ? CheckListHistorico()
                                          : ChecklistItem(),
                        ));
                      },
                    )
                  ],
                ),
              ),
            )));
  }
}
