import "package:flutter/material.dart";
import "package:intl/date_symbol_data_local.dart";
import "package:intl/intl.dart";
import "package:mobx/mobx.dart";
import "package:provider/provider.dart";
import "package:todomobx/stores/base_store.dart";
import "package:todomobx/stores/checklist_base_store.dart";
import "package:todomobx/stores/checklist_item_store.dart";
import "package:todomobx/stores/home_store.dart";

class CheckListHistorico extends StatefulWidget {
  @override
  _CheckListHistoricoState createState() => _CheckListHistoricoState();
}

class _CheckListHistoricoState extends State<CheckListHistorico> {
  var enDatesFuture = initializeDateFormatting("pt_BR", null);
  var formatter = DateFormat.yMd("pt_BR");
  var hora = new DateTime.now().hour;
  var filter = "";
  late HomeStore homeStore;
  late BaseStore baseStore;
  late ChecklistItemStore checklistItemStore;
  late ChecklistBaseStore checklistBaseStore;

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
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey, width: 0.7))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("  Histórico  ",
                      style: TextStyle(
                        color: Color.fromARGB(255, 137, 202, 204),
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                      )),
                  Container(
                    child: Expanded(
                      child: TextField(
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05, color: Colors.grey, height: MediaQuery.of(context).size.height * 0.0017),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            size: MediaQuery.of(context).size.height * 0.02,
                            color: Color.fromARGB(255, 137, 202, 204),
                          ),
                          border: InputBorder.none,
                        ),
                        onChanged: (text) {
                          setState(() {
                            filter = text.toUpperCase();
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: FutureBuilder<List>(
                  future: checklistItemStore.getAllChecklists(baseStore.cnpj, baseStore.cpf),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) return new Text("Loading...");
                    return new ListView(
                      children: snapshot.data!.map<Widget>((document) {
                        return document["model"]["name"].toString().toUpperCase().contains(filter)
                            ? GestureDetector(
                                onTap: () {
                                  checklistItemStore.arrHead = [];
                                  checklistItemStore.arrTail = [];
                                  var currentHead;
                                  var lastItem;
                                  try{
                                    checklistItemStore.setItemCode(document.id);
                                  }
                                  catch(e){
                                    checklistItemStore.setItemCode("");
                                  }
                                  checklistItemStore.isEdit = false;

                                  var temp = Map<String, dynamic>.from(document["model"]["items"]);
                                  checklistItemStore.itemArray = Map.fromEntries(temp.entries.toList()
                                    ..sort((e1, e2) => int.parse(e1.value["number"].toString()).compareTo(int.parse(e2.value["number"].toString()))));
                                  checklistItemStore.itemArray.forEach((key, value) {
                                    if (currentHead != value["group"]) {
                                      currentHead = value["group"];
                                      if (lastItem != null) {
                                        checklistItemStore.arrTail.add(lastItem);
                                      }

                                      checklistItemStore.arrHead.add(value["number"]);
                                    }
                                    lastItem = value["number"];
                                    //checklistItemStore.arrTail.add(checklistItemStore.itemArray.last);
                                  });
                                  checklistItemStore.arrTail.add(lastItem);
                                  temp = document["model"]["items"];


                                  checklistItemStore.isEdit = true;
                                  checklistItemStore.selection = document["selection"];
                                  checklistItemStore.selectionArray = new ObservableMap<dynamic, dynamic>();
                                  checklistItemStore.actionArray = new ObservableMap<dynamic, dynamic>();
                                  checklistItemStore.inputArray = new ObservableMap<dynamic, dynamic>();
                                  try{
                                    checklistItemStore.documentId = document.id;
                                  }
                                  catch(e){
                                    checklistItemStore.documentId = "";
                                  }
                                  checklistItemStore.isEditable = document["model"].containsKey("isEditable") ? document["model"]["isEditable"] : false;
                                  for (var key in document["selection"].keys) {
                                    checklistItemStore.setSelection(key, document["selection"][key]["selectedButton"]);
                                    checklistItemStore.setAction(
                                        key, checklistItemStore.itemArray[key]["buttons"][checklistItemStore.selectionArray[key]]["extern_actions"]);
                                  }
                                  checklistBaseStore.setIndex(4);
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Color.fromARGB(255, 210, 210, 210))),
                                      color: Colors.white,
                                    ),
                                    child: Container(
                                        height: MediaQuery.of(context).size.height * 0.07,
                                        margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.01),
                                        child: Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [

                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context).size.width * 0.04, right: MediaQuery.of(context).size.width * 0.04),
                                                child: Text(
                                                  (document["model"]["name"].length > 15
                                                      ? document["model"]["name"].substring(0, 15) + "..."
                                                      : document["model"]["name"]),
                                                  style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04, fontWeight: FontWeight.w500, color: Color.fromARGB(255, 120, 120, 120)),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              Container(
                                                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04),
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Container(decoration: BoxDecoration(
                                                          color: document.runtimeType.toString() == "_InternalLinkedHashMap<String, dynamic>"?Colors.redAccent:Colors.green,
                                                          borderRadius: BorderRadius.circular(100000)
                                                      ),height: MediaQuery.of(context).size.height*0.03,width: MediaQuery.of(context).size.height*0.03,),
                                                      Text(
                                                        "   "+document["horse"]+"   ",
                                                        style: TextStyle(color: Color.fromARGB(255, 110, 110, 110), fontSize: MediaQuery.of(context).size.width*0.04),
                                                      ),
                                                      Text(
                                                        formatter.format(DateTime.fromMicrosecondsSinceEpoch(document["date"].microsecondsSinceEpoch)),
                                                        style: TextStyle(color: Color.fromARGB(255, 25, 153, 158), fontSize: MediaQuery.of(context).size.width*0.03),
                                                      ),
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        ))),
                              )
                            : Container();
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
