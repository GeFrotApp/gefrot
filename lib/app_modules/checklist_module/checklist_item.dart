import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/stores/checklist_base_store.dart';
import 'package:todomobx/stores/checklist_item_store.dart';

class ChecklistItem extends StatefulWidget {
  @override
  _ChecklistItemState createState() => _ChecklistItemState();
}

class _ChecklistItemState extends State<ChecklistItem> {
  ChecklistItemStore checklistItemStore;
  ChecklistBaseStore checklistBaseStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    checklistItemStore = Provider.of<ChecklistItemStore>(context);
    checklistBaseStore = Provider.of<ChecklistBaseStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 230, 230, 230),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: checklistItemStore.itemArray.length,
          itemBuilder: (context, index) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.20,
              child: Card(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "   " + checklistItemStore.itemArray[index],
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.035,
                        color: Color.fromARGB(255, 170, 170, 170)),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.035,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Observer(
                        builder: (_){
                          return GestureDetector(
                            onTap: () {
                              checklistItemStore.setSelection(
                                  checklistItemStore.itemArray[index], 1);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.27,
                              height: MediaQuery.of(context).size.height * 0.065,
                              decoration: BoxDecoration(
                                  color: checklistItemStore.selectionArray[
                                  checklistItemStore
                                      .itemArray[index]] ==
                                      1
                                      ? Color.fromARGB(255, 146, 245, 105)
                                      : Color.fromARGB(255, 204, 204, 204),
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          );
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          checklistItemStore.setSelection(
                              checklistItemStore.itemArray[index], 2);
                          print("oi");
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.27,
                          height: MediaQuery.of(context).size.height * 0.065,
                          decoration: BoxDecoration(
                              color: checklistItemStore.selectionArray[
                                          checklistItemStore
                                              .itemArray[index]] ==
                                      2
                                  ? Color.fromARGB(255, 244, 98, 98)
                                  : Color.fromARGB(255, 204, 204, 204),
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          checklistItemStore.setSelection(
                              checklistItemStore.itemArray[index], 3);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.27,
                          height: MediaQuery.of(context).size.height * 0.065,
                          decoration: BoxDecoration(
                              color: checklistItemStore.selectionArray[
                                          checklistItemStore
                                              .itemArray[index]] ==
                                      3
                                  ? Color.fromARGB(255, 246, 178, 60)
                                  : Color.fromARGB(255, 204, 204, 204),
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                    ],
                  )
                ],
              )),
            );
          }),
    );
  }
}
