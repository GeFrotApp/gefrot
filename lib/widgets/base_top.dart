import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/stores/base_store.dart';
import 'package:todomobx/stores/cadastro_1_store.dart';

class BaseTop extends StatefulWidget {
  @override
  _BaseTopState createState() => _BaseTopState();
}

class _BaseTopState extends State<BaseTop> {
  int selectedIndex = 0;
  var hora = new DateTime.now().hour;
  BaseStore baseStore;
  Cadastro1Store cadastro1store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    baseStore = Provider.of<BaseStore>(context);
    cadastro1store = Provider.of<Cadastro1Store>(context);

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 35,
            decoration:
            BoxDecoration(color: Color.fromARGB(255, 87, 181, 184)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      " |",
                      style: TextStyle(fontSize: 23, color: Colors.white),
                    ),
                    Text(
                      "GetFrot",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "|",
                      style: TextStyle(fontSize: 23, color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    hora > 12
                        ? hora > 18
                        ? Text(
                      "Boa noite, " + baseStore.nome,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    )
                        : Text(
                      "Boa tarde, " + baseStore.nome,
                      style: TextStyle(
                          color: Colors.white, fontSize: 20),
                    )
                        : Text(
                      "Bom dia, " + baseStore.nome,
                      style:
                      TextStyle(color: Colors.white, fontSize: 20),
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
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.42,
                  child: Column(
                    children: [
                      Text(
                        'Cavalo',
                        style: TextStyle(
                            color: Color.fromARGB(255, 170, 170, 170),
                            fontSize:
                            MediaQuery.of(context).size.width * 0.05),
                      ),
                      Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width * 0.28,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Color.fromARGB(255, 110, 110, 110)),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(cadastro1store.placaCavalo,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 170, 170, 170),
                                    fontSize:
                                    MediaQuery.of(context).size.width *
                                        0.05)),
                          )),
                    ],
                  ),
                ),
                Text(
                  "|",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.07,
                      color: Color.fromARGB(255, 170, 170, 170),
                      fontWeight: FontWeight.w100),
                ),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.42,
                  child: Column(
                    children: [
                      Text(
                        'Carreta',
                        style: TextStyle(
                            color: Color.fromARGB(255, 170, 170, 170),
                            fontSize:
                            MediaQuery.of(context).size.width * 0.05),
                      ),
                      Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width * 0.28,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Color.fromARGB(255, 110, 110, 110)),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(cadastro1store.placaCarreta1,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 170, 170, 170),
                                    fontSize:
                                    MediaQuery.of(context).size.width *
                                        0.05)),
                          )),
                    ],
                  ),
                ),
                Text(
                  "|",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.07,
                      color: Color.fromARGB(255, 170, 170, 170),
                      fontWeight: FontWeight.w100),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: IconButton(
                    icon: Icon(
                      Icons.edit,
                      size: MediaQuery.of(context).size.width * 0.06,
                    ),
                  ),
                )
              ],
            ),
          ),




          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
