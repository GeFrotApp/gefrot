import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:todomobx/app_screens/configScreens/seguranca.dart";
import "package:todomobx/main.dart";
import "package:todomobx/stores/base_store.dart";

import "configScreens/ajuda.dart";
import "configScreens/conta.dart";

class Config extends StatefulWidget {
  @override
  _ConfigState createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  late BaseStore baseStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    baseStore = Provider.of<BaseStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromARGB(255, 210, 210, 210)))),
                child: Row(
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: MediaQuery.of(context).size.width * 0.15,
                      color: Color.fromARGB(255, 137, 202, 204),
                    ),
                    Text(
                      "    " + baseStore.nome,
                      textScaleFactor: 1,
                      style: TextStyle(color: Color.fromARGB(250, 120, 120, 120), fontSize: MediaQuery.of(context).size.width * 0.05),
                    )
                  ],
                )),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return Conta();
                }));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.15,
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromARGB(255, 210, 210, 210)))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Conta",
                      textScaleFactor: 1,
                      style: TextStyle(color: Color.fromARGB(250, 120, 120, 120), fontSize: MediaQuery.of(context).size.width * 0.045),
                    ),
                    Text("Usuário, empresa",
                        textScaleFactor: 1, style: TextStyle(color: Color.fromARGB(250, 120, 120, 120), fontSize: MediaQuery.of(context).size.width * 0.030))
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return Seguranca();
                }));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.15,
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromARGB(255, 210, 210, 210)))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Segurança",
                      textScaleFactor: 1,
                      style: TextStyle(color: Color.fromARGB(250, 120, 120, 120), fontSize: MediaQuery.of(context).size.width * 0.045),
                    ),
                    Text("Senha, telefone",
                        textScaleFactor: 1, style: TextStyle(color: Color.fromARGB(250, 120, 120, 120), fontSize: MediaQuery.of(context).size.width * 0.030))
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return Ajuda();
                }));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.15,
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromARGB(255, 210, 210, 210)))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Ajuda",
                      textScaleFactor: 1,
                      style: TextStyle(color: Color.fromARGB(250, 120, 120, 120), fontSize: MediaQuery.of(context).size.width * 0.045),
                    ),
                    Text("Fale conosco, política de privacidade",
                        textScaleFactor: 1, style: TextStyle(color: Color.fromARGB(250, 120, 120, 120), fontSize: MediaQuery.of(context).size.width * 0.030))
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                RestartWidget.restartApp(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.15,
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromARGB(255, 210, 210, 210)))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Logout",
                      textScaleFactor: 1,
                      style: TextStyle(color: Color.fromARGB(250, 120, 120, 120), fontSize: MediaQuery.of(context).size.width * 0.045),
                    ),
                    Text("Desloga do aplicativo",
                        textScaleFactor: 1, style: TextStyle(color: Color.fromARGB(250, 120, 120, 120), fontSize: MediaQuery.of(context).size.width * 0.030))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
