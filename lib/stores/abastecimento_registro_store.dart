import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'abastecimento_registro_store.g.dart';

class AbastecimentoRegistroStore = _AbastecimentoRegistroStore with _$AbastecimentoRegistroStore;

abstract class _AbastecimentoRegistroStore with Store{

  var base;
  var cadastro;
  var first = false;
  var last = true;
  var idAbsNew;
  @observable
  var posto = "";

  @observable
  var cnpjPosto="";

  @observable
  TextEditingController nomePostoController = new TextEditingController();

  @observable
  var data = DateTime.now();

  @action
  Future<void> setData(value)async{
    data = value;
    var fb =FirebaseFirestore.instance;
    var absOld = (await fb.collection('Companies').doc(base.cnpj).collection("Supplies").where("licensePlate", isEqualTo: cadastro.placaCavalo).where("date", isLessThan: Timestamp.fromMillisecondsSinceEpoch(data.millisecondsSinceEpoch)).orderBy("date", descending: true).limit(1).get()).docs;
    var absNew = (await fb.collection('Companies').doc(base.cnpj).collection("Supplies").where("licensePlate", isEqualTo: cadastro.placaCavalo).where("date", isGreaterThan: Timestamp.fromMillisecondsSinceEpoch(data.millisecondsSinceEpoch)).orderBy("date", descending: false).limit(1).get()).docs;
    if(absOld.length == 0){
      first = true;
      odometroOld = base.odometro;
    }else{
      first = false;
      odometroOld = absOld.last.data()['odometerNew'];
    }
    if(absNew.length == 1){
      last = false;
      idAbsNew = absNew.last.id;
    }else{
      last = true;
    }
  }

  @action
  void setPosto(value)=>posto = value;

  @computed
  bool get isFormValid=>(cnpjPosto.length==0||cnpjPosto.length==14)&&posto.length>5&&odometro!=0&&litros!=0&&valor!=0;

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
        posto = response.data['nome'];
      }


    }
  }

  @observable
  var odometro = 0.0;

  @action
  void setOdometro(value)=>odometro = double.parse(value.toString().replaceAll(",", "."));

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
  var odometroOld = 0.0;



}