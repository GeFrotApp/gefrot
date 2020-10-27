import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'abastecimento_base_store.g.dart';

class AbastecimentoBaseStore = _AbastecimentoBaseStore with _$AbastecimentoBaseStore;

abstract class _AbastecimentoBaseStore with Store{

  var documento="";

  @observable
  var posto = "";

  @observable
  var cnpjPosto="";

  @observable
  TextEditingController nomePostoController = new TextEditingController();

  @observable
  var data;

  @action
  void setData(value)=>data = value;

  @action
  void setPosto(value)=>posto = value;

  @computed
  bool get isFormValid=>(cnpjPosto.length==0||cnpjPosto.length==14)&&posto.length>5&&odometroNew!=0&&litros!=0&&valor!=0;

  @action
  Future<void> setCnpjPosto(value)async{
    cnpjPosto = value.replaceAll('.', "")
        .replaceAll(" ", "")
        .replaceAll("/", "")
        .replaceAll("-", "");
    if(cnpjPosto.length==14){
      Response response = await Dio().get("https://www.receitaws.com.br/v1/cnpj/"+cnpjPosto);
      if(response.data['status']=="OK"){
        print(response.data['nome']);
        nomePostoController.text = response.data['nome'];
      }
    }
  }

  @observable
  var odometroNew = 0.0;

  @action
  void setNewOdometro(value)=>odometroNew = double.parse(value.toString().replaceAll(",", "."));

  @observable
  var odometroOld = 0.0;

  @action
  void setOldOdometro(value)=>odometroOld = double.parse(value.toString().replaceAll(",", "."));

  @observable
  var litros = 0.0;

  @action
  void setLitros(value)=>litros = double.parse(value.toString().replaceAll(",", "."));

  @observable
  var valor = 0.0;

  @action
  void setValor(value)=>valor = double.parse(value.toString().replaceAll(",", "."));

  @observable
  var nf = "";

  @action
  void setNf(value)=>nf = value;

  @observable
  var tanqueCheio = true;

  @action
  void setTanqueCheio(value)=>tanqueCheio=value;

  @observable
  var invoicePhoto;


  @observable
  var select = false;

  @observable
  int index = 0;

  @action
  void setIndex(value) => index = value;

  @action
  void turnSelect() => select = !select;
}