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

class CheckListSelecao extends StatefulWidget {
  @override
  _CheckListSelecaoState createState() => _CheckListSelecaoState();
}

class _CheckListSelecaoState extends State<CheckListSelecao> {
  var enDatesFuture = initializeDateFormatting('pt_BR', null);
  var formatter = DateFormat.yMMMMEEEEd('pt_BR').add_Hm();
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
        margin: EdgeInsets.only(top: 15),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child:
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.05,
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey, width: 0.7))),
              child: Text("  Meus Check-Lists", textScaleFactor: 1,
                  style: TextStyle(
                    color: Color.fromARGB(255, 137, 202, 204),
                    fontSize: MediaQuery
                        .of(context)
                        .size
                        .width * 0.05,
                  )),
            ),
            Expanded(
              child: Container(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('Companies').doc(baseStore.cnpj)
                      .collection('CheckListModels')
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) return new Text('Loading...');
                    return new ListView(
                      children: snapshot.data.docs.map((DocumentSnapshot document) {
                        return GestureDetector(
                          onTap: () async {
                            var ok = false;
                            print("oi");

                            checklistItemStore.setItemCode(document.id);
                            checklistItemStore.noteText = document['noteText'];
                            print(document.id);
                            print(document.data());
                            checklistItemStore.itemArray = document['items'];
                            checklistItemStore.selectionArray = new ObservableMap<dynamic, dynamic>();
                            checklistItemStore.actionArray = new ObservableMap<dynamic, dynamic>();
                            checklistItemStore.inputArray = new ObservableMap<dynamic, dynamic>();
                            checklistItemStore.model = document.data();
                            checklistItemStore.documentId = null;
                            if (checklistItemStore.noteText != "") {
                              await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Aviso'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            Text(checklistItemStore.noteText),
                                            TextField(
                                              onChanged: (value) {
                                                checklistItemStore.note = value;
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('OK'),
                                          onPressed: () {
                                            ok = true;
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            }
                            else{
                              ok=true;
                            }

                            if(ok==true){
                            checklistBaseStore.setIndex(2);
                            }
                          },
                          child: Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.15,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.7,


                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Color.fromARGB(255, 210, 210, 210))),
                              color: Colors.white,
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 0.04, right: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 0.04),
                                      child: Text(document['name'], textScaleFactor: 1, style: TextStyle(
                                          fontSize: 25, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 120, 120, 120)),
                                        textAlign: TextAlign.start,),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 0.04),
                                      child: Text(document['frequencyText'], textScaleFactor: 1,
                                        style: TextStyle(
                                            fontSize: 18, fontWeight: FontWeight.w400, color: Color.fromARGB(255, 120, 120, 120)),
                                        textAlign: TextAlign.start,),
                                    ),

                                  ],
                                ),
                              ],


                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            )
          ],
        )


    );
  }
}
