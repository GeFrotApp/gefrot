import "package:flutter/material.dart";
import "package:flutter_mobx/flutter_mobx.dart";
import "package:provider/provider.dart";
import "package:todomobx/stores/base_store.dart";
import "package:todomobx/stores/cadastro_1_store.dart";

class BaseTop extends StatefulWidget {
  @override
  _BaseTopState createState() => _BaseTopState();
}

class _BaseTopState extends State<BaseTop> {
  int selectedIndex = 0;
  var hora = new DateTime.now().hour;
  BaseStore baseStore;
  Cadastro1Store cadastro1Store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    baseStore = Provider.of<BaseStore>(context);
    cadastro1Store = Provider.of<Cadastro1Store>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 35,
            decoration: BoxDecoration(color: Color.fromARGB(255, 87, 181, 184)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  height: MediaQuery.of(context).size.width * 0.056,
                ),
                Row(
                  children: [
                    hora > 12
                        ? hora > 18
                            ? Text(
                                "Boa noite, " + baseStore.nome,
                                textScaleFactor: 1,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(context).size.width * 0.049,
                                ),
                              )
                            : Text(
                                "Boa tarde, " + baseStore.nome,
                                textScaleFactor: 1,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(context).size.width * 0.049,
                                ),
                              )
                        : Text(
                            "Bom dia, " + baseStore.nome,
                            textScaleFactor: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width * 0.049,
                            ),
                          ),
                    Icon(
                      Icons.account_circle,
                      color: Colors.white,
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 60,
            decoration: BoxDecoration(color: Colors.white),
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Observer(
                        builder: (_) {
                          return Row(
                            children: [
                              Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width * 0.42,
                                child: Column(
                                  children: [
                                    Text(
                                      "Veículo",
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 120, 120, 120),
                                          fontSize: MediaQuery.of(context).size.width * 0.05),
                                    ),
                                    Container(
                                        height: 30,
                                        width: MediaQuery.of(context).size.width * 0.28,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(color: Color.fromARGB(255, 110, 110, 110)),
                                            borderRadius: BorderRadius.circular(10)),
                                        child: Center(
                                          child: Observer(
                                            builder: (_) {
                                              return Text(cadastro1Store.placaCavalo,
                                                  textScaleFactor: 1,
                                                  style: TextStyle(
                                                      color: Color.fromARGB(255, 120, 120, 120),
                                                      fontSize: MediaQuery.of(context).size.width * 0.05));
                                            },
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              Text(
                                "|",
                                textScaleFactor: 1,
                                style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.height * 0.07,
                                    color: Color.fromARGB(255, 120, 120, 120),
                                    fontWeight: FontWeight.w100),
                              ),
                              Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width * 0.42,
                                child: Column(
                                  children: [
                                    Text(
                                      "Equipamento",
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 120, 120, 120),
                                          fontSize: MediaQuery.of(context).size.width * 0.05),
                                    ),
                                    Container(
                                        height: 30,
                                        width: MediaQuery.of(context).size.width * 0.28,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(color: Color.fromARGB(255, 110, 110, 110)),
                                            borderRadius: BorderRadius.circular(10)),
                                        child: Center(
                                          child: Observer(
                                            builder: (_) {
                                              return Text(cadastro1Store.placaCarreta1,
                                                  textScaleFactor: 1,
                                                  style: TextStyle(
                                                      color: Color.fromARGB(255, 120, 120, 120),
                                                      fontSize: MediaQuery.of(context).size.width * 0.05));
                                            },
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              Text(
                                "|",
                                textScaleFactor: 1,
                                style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.height * 0.07,
                                    color: Color.fromARGB(255, 120, 120, 120),
                                    fontWeight: FontWeight.w100),
                              ),
                              cadastro1Store.numCarretas > 1
                                  ? Container(
                                      height: 60,
                                      width: MediaQuery.of(context).size.width * 0.42,
                                      child: Column(
                                        children: [
                                          Text(
                                              "Equipamento",
                                            textScaleFactor: 1,
                                            style: TextStyle(
                                                color: Color.fromARGB(255, 120, 120, 120),
                                                fontSize: MediaQuery.of(context).size.width * 0.05),
                                          ),
                                          Container(
                                              height: 30,
                                              width: MediaQuery.of(context).size.width * 0.28,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(color: Color.fromARGB(255, 110, 110, 110)),
                                                  borderRadius: BorderRadius.circular(10)),
                                              child: Center(
                                                child: Observer(
                                                  builder: (_) {
                                                    return Text(cadastro1Store.placaCarreta2,
                                                        textScaleFactor: 1,
                                                        style: TextStyle(
                                                            color: Color.fromARGB(255, 120, 120, 120),
                                                            fontSize: MediaQuery.of(context).size.width * 0.05));
                                                  },
                                                ),
                                              )),
                                        ],
                                      ),
                                    )
                                  : Container(),
                              cadastro1Store.numCarretas > 1
                                  ? Text(
                                      "|",
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.height * 0.07,
                                          color: Color.fromARGB(255, 120, 120, 120),
                                          fontWeight: FontWeight.w100),
                                    )
                                  : Container(),
                              cadastro1Store.numCarretas > 2
                                  ? Container(
                                      height: 60,
                                      width: MediaQuery.of(context).size.width * 0.42,
                                      child: Column(
                                        children: [
                                          Text(
                                            "Equipamento",
                                            textScaleFactor: 1,
                                            style: TextStyle(
                                                color: Color.fromARGB(255, 120, 120, 120),
                                                fontSize: MediaQuery.of(context).size.width * 0.05),
                                          ),
                                          Container(
                                              height: 30,
                                              width: MediaQuery.of(context).size.width * 0.28,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(color: Color.fromARGB(255, 110, 110, 110)),
                                                  borderRadius: BorderRadius.circular(10)),
                                              child: Center(
                                                child: Observer(
                                                  builder: (_) {
                                                    return Text(cadastro1Store.placaCarreta3,
                                                        textScaleFactor: 1,
                                                        style: TextStyle(
                                                            color: Color.fromARGB(255, 120, 120, 120),
                                                            fontSize: MediaQuery.of(context).size.width * 0.05));
                                                  },
                                                ),
                                              )),
                                        ],
                                      ),
                                    )
                                  : Container(),
                              cadastro1Store.numCarretas > 2
                                  ? Text(
                                      "|",
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.height * 0.07,
                                          color: Color.fromARGB(255, 120, 120, 120),
                                          fontWeight: FontWeight.w100),
                                    )
                                  : Container(),
                            ],
                          );
                        },
                      )),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: IconButton(
                    icon: Icon(
                      Icons.edit,
                      size: MediaQuery.of(context).size.width * 0.06,
                    ),
                    onPressed: () {
                      setState(() {
                        selectedIndex = 2;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
