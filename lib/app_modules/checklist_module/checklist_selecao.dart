import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/stores/base_store.dart';
import 'package:todomobx/stores/checklist_base_store.dart';
import 'package:todomobx/stores/checklist_item_store.dart';
import 'package:todomobx/stores/home_store.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

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
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('empresas').doc(baseStore.cnpj).collection('CheckListModel').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return new Text('Loading...');
                return new ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return GestureDetector(
                      onTap: (){print("oi");
                      checklistItemStore.setItemCode( document.id);
                      print(document.id);
                      checklistItemStore.itemArray = document.data()['Fields'];
                      checklistItemStore.selectionArray = ObservableList();
                      checklistItemStore.selectionArray = { for (var v in document.data()['Fields']) v: 0 };
                      checklistItemStore.setSelection("check1", 0);
                      checklistBaseStore.setIndex(3);

                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.width*0.7,


                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color:Color.fromARGB(255, 210, 210, 210))),
                          color: Colors.white,
                        ),
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("  "+document['Name'], style: TextStyle(fontSize: 25, fontWeight:FontWeight.bold,color: Color.fromARGB(255, 163, 203, 215)),textAlign: TextAlign.start,),
                                Text("   "+document['Description'], style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 170, 170, 170)),textAlign: TextAlign.start,),
                              ],
                            ),
                          ],


                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            )



    );
  }
}
