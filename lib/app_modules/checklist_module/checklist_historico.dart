import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/stores/base_store.dart';
import 'package:todomobx/stores/checklist_base_store.dart';
import 'package:todomobx/stores/checklist_item_store.dart';
import 'package:todomobx/stores/home_store.dart';

class CheckListHistorico extends StatefulWidget {
  @override
  _CheckListHistoricoState createState() => _CheckListHistoricoState();
}

class _CheckListHistoricoState extends State<CheckListHistorico> {
  var enDatesFuture = initializeDateFormatting('pt_BR', null);
  var formatter = DateFormat.yMd('pt_BR');
  var hora = new DateTime.now().hour;
  HomeStore homeStore;
  BaseStore baseStore;
  ChecklistItemStore checklistItemStore;
  ChecklistBaseStore checklistBaseStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    homeStore = Provider.of<HomeStore>(context);
    baseStore = Provider.of<BaseStore>(context);
    checklistItemStore = Provider.of<ChecklistItemStore>(context);
    checklistBaseStore = Provider.of<ChecklistBaseStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.05,
              decoration: BoxDecoration(
                  border:Border(bottom: BorderSide(color: Colors.grey, width: 0.7))),
              child: Text("  Histórico de Check-Lists",
                  style: TextStyle(
                    color: Color.fromARGB(255, 137, 202, 204),
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                  )),
            ),
            Expanded(
              child: Container(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Companies')
                      .doc(baseStore.cnpj)
                      .collection('CheckLists')
                      .where("driverCPF", isEqualTo: baseStore.cpf)
                      .orderBy("date", descending: true)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) return new Text('Loading...');
                    return new ListView(

                      children: snapshot.data.docs.map((DocumentSnapshot document) {
                        return GestureDetector(
                          onTap: () {
                            print("oi");
                            checklistItemStore.setItemCode(document.id);
                            print(document.id);
                            print(document.data());
                            var temp = document['model']['items'];
                            checklistItemStore.itemArray = {};
                            for(var i =1; i<=temp.length;i++){
                              checklistItemStore.itemArray["Item "+i.toString()]= temp["Item "+i.toString()];
                            }
                            checklistItemStore.selection = document['selection'];
                            checklistItemStore.selectionArray = new ObservableMap<dynamic, dynamic>();
                            checklistItemStore.actionArray = new ObservableMap<dynamic, dynamic>();
                            checklistItemStore.inputArray = new ObservableMap<dynamic, dynamic>();
                            checklistItemStore.documentId = document.id;
                            for (var key in document['selection'].keys) {
                              print(document['selection'][key]['selectedButton']);
                              checklistItemStore.setSelection(key, document['selection'][key]['selectedButton']);
                              checklistItemStore.setAction(key,
                                  checklistItemStore.itemArray[key]['buttons'][checklistItemStore.selectionArray[key]]['extern_actions']);
                            }
                            checklistBaseStore.setIndex(4);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Color.fromARGB(255, 210, 210, 210))),
                                color: Colors.white,
                              ),
                              child: Container(
                                  height: MediaQuery.of(context).size.height*0.15,
                                  margin: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width*0.01),
                                  child: Container(
                                    child: Stack(
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context).size.width * 0.04,
                                                  right: MediaQuery.of(context).size.width * 0.04),
                                              child: Text(
                                                (document['model']['name'].length>28?document['model']['name'].substring(0,28)+"...":document['model']['name'])
                                                ,
                                                style: TextStyle(
                                                    fontSize: 25, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 120, 120, 120)),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                            Container(
                                                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04),
                                                child: Text(
                                                  formatter.format(DateTime.fromMicrosecondsSinceEpoch(document['date'].microsecondsSinceEpoch)
                                                      ),
                                                  style: TextStyle(color: Color.fromARGB(255, 164, 164, 164)),
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                              )
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            )
          ],
        ));
  }
}
