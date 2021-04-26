import 'dart:collection';

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
                            checklistItemStore.arrHead = [];
                            checklistItemStore.arrTail = [];
                            var currentHead;
                            var currentTail;
                            var lastItem;
                            checklistItemStore.setItemCode(document.id);
                            checklistItemStore.isEdit = false;

                            var temp = Map<String, dynamic>.from(document['items']);
                            checklistItemStore.itemArray = Map.fromEntries(temp.entries.toList()..sort((e1, e2) =>
                                int.parse(e1.value["number"].toString()).compareTo(int.parse(e2.value["number"].toString()))));
                            checklistItemStore.itemArray.forEach((key, value) {

                              if(currentHead!=value['group']){
                                  currentHead=value['group'];
                                    if(lastItem!=null){
                                      checklistItemStore.arrTail.add(lastItem);
                                    }

                                  checklistItemStore.arrHead.add(value['number']);
                              }
                              print(value['group']);
                              lastItem=value['number'];
                              //checklistItemStore.arrTail.add(checklistItemStore.itemArray.last);
                              //print(key);
                            });
                            checklistItemStore.arrTail.add(lastItem);
                            print(checklistItemStore.arrHead);
                            print(checklistItemStore.arrTail);

                            // if(document.data().containsKey('groups')){
                            //   temp = checklistItemStore.itemArray;
                            //   checklistItemStore.itemArray = {};
                            //   print(document['groups']);is
                            //   var k=1;
                            //   for(var i=0;i<document['groups'].length;i++){
                            //     //print(document['groups'][i]);
                            //     for(var j =1; j<=temp.length;j++){
                            //       if(document['groups'][i]==temp["Item "+j.toString()]['group']){
                            //         print(document['groups'][i]);
                            //         checklistItemStore.itemArray["Item "+k.toString()]= temp["Item "+j.toString()];
                            //         k++;
                            //       }
                            //     }
                            //   }
                            // }
                            // //print(checklistItemStore.itemArray);
                            // print("------");
                            // for(var i =0; i<temp.length;i++){
                            //   print(checklistItemStore.itemArray.keys.elementAt(i));
                            // }
                            checklistItemStore.selectionArray = new ObservableMap<dynamic, dynamic>();
                            checklistItemStore.actionArray = new ObservableMap<dynamic, dynamic>();
                            checklistItemStore.inputArray = new ObservableMap<dynamic, dynamic>();
                            checklistItemStore.model = document.data();
                            checklistItemStore.noteText = document.data().containsKey('asksDict')?document['asksDict']:{};
                            checklistItemStore.signatureIsRequired = document.data().containsKey('signatureIsRequired')?document['signatureIsRequired']:false;
                            checklistItemStore.equipmentPlateIsRequired = document.data().containsKey('equipmentPlateIsRequired')?document['equipmentPlateIsRequired']:false;
                            checklistItemStore.locationIsRequired = document.data().containsKey('locationIsRequired')?document['locationIsRequired']:false;
                            checklistItemStore.note = {};
                            checklistItemStore.isEditable = true;

                            checklistItemStore.documentId = null;
                            if(checklistItemStore.noteText.values.length>0){
                              for(var question in checklistItemStore.noteText.values)  {
                                await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Pergunta'),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[
                                              Text(question.keys.elementAt(0)),
                                              TextField(
                                                onChanged: (value) {
                                                  checklistItemStore.note[question.keys.elementAt(0)] = value;
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
                            }else{
                              ok=true;
                            }



                            print(checklistItemStore.note);
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
