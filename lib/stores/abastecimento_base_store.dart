import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:mobx/mobx.dart";

part "abastecimento_base_store.g.dart";

class AbastecimentoBaseStore = _AbastecimentoBaseStore with _$AbastecimentoBaseStore;

abstract class _AbastecimentoBaseStore with Store {
  var documento = "";

  @observable
  var posto = "";

  @observable
  var cnpjPosto = "";

  @observable
  var placaCavalo = "";

  @observable
  TextEditingController nomePostoController = new TextEditingController();

  @observable
  var data;

  @action
  void setData(value) => data = value;

  @action
  void setPosto(value) => posto = value;

  @action
  void setPlacaCavalo(value) => placaCavalo = value;

  @computed
  bool get isFormValid => (cnpjPosto.length == 0 || cnpjPosto.length == 14) && posto.length > 5 && odometroNew != 0 && litros != 0 && valor != 0;

  @action
  Future<void> setCnpjPosto(value) async {
    cnpjPosto = value.replaceAll(".", "").replaceAll(" ", "").replaceAll("/", "").replaceAll("-", "");
    if (cnpjPosto.length == 14) {
      Response response = await Dio().get("https://www.receitaws.com.br/v1/cnpj/" + cnpjPosto);
      if (response.data["status"] == "OK") {
        nomePostoController.text = response.data["nome"];
      }
    }
  }

  @observable
  var odometroNew = 0.0;

  @action
  void setNewOdometro(value) => odometroNew = double.parse(value.toString().replaceAll(",", "."));

  @observable
  var odometroOld = 0.0;

  @action
  void setOldOdometro(value) => odometroOld = double.parse(value.toString().replaceAll(",", "."));

  @observable
  var litros = 0.0;

  @action
  void setLitros(value) => litros = double.parse(value.toString().replaceAll(",", "."));

  @observable
  var valor = 0.0;

  @action
  void setValor(value) => valor = double.parse(value.toString().replaceAll(",", "."));

  @observable
  var nf = "";

  @action
  void setNf(value) => nf = value;

  @observable
  var tanqueCheio = true;

  @action
  void setTanqueCheio(value) => tanqueCheio = value;

  @observable
  var invoicePhoto;

  @observable
  var select = false;

  @observable
  int index = 0;

  @action
  Future<void> setIndex(value, context, checkRegistro) async {
    if (index == 1 && checkRegistro) {
      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Alerta"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text("As informações do registro serão perdidas. Tem certeza?"),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Container(
                    height: MediaQuery.of(context).size.width * 0.09,
                    width: MediaQuery.of(context).size.width * 0.15,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Color.fromARGB(255, 255, 165, 165)),
                    child: Center(
                      child: Text(
                        "Não",
                        textScaleFactor: 1,
                        style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045, color: Colors.white),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Container(
                    height: MediaQuery.of(context).size.width * 0.09,
                    width: MediaQuery.of(context).size.width * 0.15,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Color.fromARGB(255, 137, 202, 204)),
                    child: Center(
                      child: Text(
                        "Sim",
                        textScaleFactor: 1,
                        style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045, color: Colors.white),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    index = value;
                  },
                ),
              ],
            );
          });
    } else {
      index = value;
    }
  }

  @action
  void turnSelect() => select = !select;

  @observable
  var combustivel = "";

  @action
  setCombustivel(value) => combustivel = value;
}
