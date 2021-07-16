import "dart:ui";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:todomobx/stores/base_store.dart";
import "package:todomobx/widgets/base_top.dart";

// ignore: must_be_immutable
class ConfigTop extends StatefulWidget {
  ConfigTop(text, children){
    this.text = text;
    this.children = children;
  }
  var text;
  var children;

  @override
  _ConfigTopState createState() => _ConfigTopState(text, children);
}

class _ConfigTopState extends State<ConfigTop> {
  _ConfigTopState(text, children){
    this.text = text;
    this.children = children;
  }
  var text;
  var children;
  BaseStore baseStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    baseStore = Provider.of<BaseStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Color.fromARGB(255, 230, 230, 230),
          child: SafeArea(
            child: Column(children: [
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
                          borderRadius: BorderRadius.circular(10), border: Border.all(color: Color.fromARGB(255, 140, 140, 140))),
                      child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_outlined,
                            color: Color.fromARGB(255, 120, 120, 120),
                            size: MediaQuery.of(context).size.width * 0.05,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ),
                    Text(
                      "  "+text,
                      textScaleFactor: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.025,
                          color: Color.fromARGB(255, 100, 100, 100)),
                    ),


                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                          decoration:
                          BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromARGB(255, 210, 210, 210)))),
                          child: Row(
                            children: [
                              Icon(
                                Icons.account_circle,
                                size: MediaQuery.of(context).size.width * 0.15,
                                color: Color.fromARGB(255, 137, 202, 204),
                              ),
                              Text(
                                "    " + baseStore.nome,textScaleFactor: 1,
                                style: TextStyle(
                                    color: Color.fromARGB(250, 120, 120, 120),
                                    fontSize: MediaQuery.of(context).size.width * 0.05),
                              )
                            ],
                          )),children
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}
