import "package:flutter/material.dart";

class Aviso extends StatelessWidget {
  Aviso(aviso) {
    this.aviso = aviso;
  }

  var aviso;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Color.fromARGB(255, 137, 202, 204),
          child: Stack(
            children: [
              SafeArea(
                child: Image.asset(
                  "assets/images/logo.png",
                ),
              ),
              Center(
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.16,
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 137, 202, 204),
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        aviso,
                        style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.07),
                        textAlign: TextAlign.center,
                      ),
                    )),
              ),
              aviso == "Usuário cadastrado!" || aviso == "Senha redefinida!"
                  ? Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.58,
                        ),
                        Container(
                            height: MediaQuery.of(context).size.height * 0.42,
                            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05),
                            child: Text(
                              "* Aguarde a liberação do gestor para realizar o login",
                              style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.05),
                            ))
                      ],
                    )
                  : Container()
            ],
          )),
    );
  }
}
