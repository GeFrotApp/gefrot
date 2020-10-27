import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/app_screens/base.dart';
import 'package:todomobx/stores/base_store.dart';
import 'package:todomobx/stores/cadastro_1_store.dart';
import 'package:todomobx/stores/login_store.dart';
import 'package:todomobx/widgets/custom_background.dart';
import 'package:todomobx/widgets/custom_text_field.dart';

import 'cadastro_2.dart';

class Cadastro1 extends StatefulWidget {
  @override
  _Cadastro1State createState() => _Cadastro1State();
}

class _Cadastro1State extends State<Cadastro1> {
  var remember = false;
  Cadastro1Store cadastro1Store;
  BaseStore baseStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cadastro1Store = Provider.of<Cadastro1Store>(context);
    baseStore = Provider.of<BaseStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(header: "Equipamentos", children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.06,
          width: MediaQuery.of(context).size.height * 0.06,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color.fromARGB(255, 140, 140, 140))),
          child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color.fromARGB(255, 170, 170, 170),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Veículo da jornada",
          style: TextStyle(
              color: Color.fromARGB(255, 137, 202, 204),
              fontSize: MediaQuery.of(context).size.width*0.073,
              fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(
        height: 40,
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Placa do cavalo *",
          style:
              TextStyle(fontSize: 20, color: Color.fromARGB(255, 11, 78, 78)),
        ),
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: CustomTextField(
          hint: 'Digite a placa',
          formatter: new MaskTextInputFormatter(
              mask: '###-####', filter: {"#": RegExp(r'[0-9a-zA-Z]')}),
          onChanged: cadastro1Store.setPlacaCavalo,
          enabled: true,
        ),
      ),
      const SizedBox(
        height: 16,
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Placa da carreta 1",
          style:
              TextStyle(fontSize: 20, color: Color.fromARGB(255, 11, 78, 78)),
        ),
      ),
      CustomTextField(
        hint: 'Digite a placa',
        formatter: new MaskTextInputFormatter(
            mask: '###-####', filter: {"#": RegExp(r'[0-9a-zA-Z]')}),
        onChanged: cadastro1Store.setPlacaCarreta1,
        enabled: true,
      ),
      const SizedBox(
        height: 16,
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Placa da carreta 2",
          style:
              TextStyle(fontSize: 20, color: Color.fromARGB(255, 11, 78, 78)),
        ),
      ),
      CustomTextField(
        hint: 'Digite a placa',
        formatter: new MaskTextInputFormatter(
            mask: '###-####', filter: {"#": RegExp(r'[0-9a-zA-Z]')}),
        onChanged: cadastro1Store.setPlacaCarreta2,
        enabled: true,
      ),
      const SizedBox(
        height: 16,
      ),
      Observer(
        builder: (_) {
          return SizedBox(
            height: 44,
            width: MediaQuery.of(context).size.width*0.35,
            child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(children: <Widget>[
                  Text(
                    'Entrar',
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.061),
                  ),
                  Icon(
                    Icons.exit_to_app,
                    size: MediaQuery.of(context).size.width*0.083,
                  )
                ]),
                color: cadastro1Store.isFormValid
                    ? Color.fromARGB(255, 25, 153, 158)
                    : Colors.grey,
                textColor: Colors.white,
                onPressed: cadastro1Store.isFormValid
                    ? () async{

                        final firestore = FirebaseFirestore.instance;
                        var document = await firestore.collection("Companies").doc(baseStore.cnpj).collection("Horses").doc(cadastro1Store.placaCavalo).get();
                        var cavaloExists = document.data()?.isNotEmpty;
                        var carreta1Exists = true;
                        var carreta2Exists = true;
                        if(cadastro1Store.placaCarreta1.length == 8){
                          var x = await firestore.collection("Companies").doc(baseStore.cnpj).collection("Trailers").doc(cadastro1Store.placaCarreta1).get();
                            carreta1Exists = x.data()?.isNotEmpty;

                        }
                        if(cadastro1Store.placaCarreta2.length == 8){
                          var x = await firestore.collection("Companies").doc(baseStore.cnpj).collection("Trailers").doc(cadastro1Store.placaCarreta2).get();
                          carreta2Exists = x.data()?.isNotEmpty;
                        }
                        print(cavaloExists);
                        if(cavaloExists!=null && carreta1Exists!= null && carreta2Exists !=null){
                          baseStore.odometro = document.data()['odometer'].toDouble();
                          baseStore.mediaProposta = document.data()['average'].toDouble();
                          print(baseStore.odometro.toString());
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Base()));
                          firestore
                              .collection('Drivers')
                              .doc(baseStore.cpf
                              .replaceAll('.', "")
                              .replaceAll("-", "")).update({
                            'horse': cadastro1Store.placaCavalo,
                            'trailer1': cadastro1Store.placaCarreta1,
                            'trailer2': cadastro1Store.placaCarreta2,
                          });
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Base()));
                          print(cadastro1Store.placaCarreta2);
                        }else if(cavaloExists==null){
                          baseStore.showMyDialog(context, "O cavalo não está cadastrado");
                        }else if(carreta1Exists==null){
                          baseStore.showMyDialog(context, "A carreta 1 não está cadastrada");
                        }else if(carreta2Exists==null){
                          baseStore.showMyDialog(context, "A carreta 2 não está cadastrada");
                        }


                      }
                    : null),
          );
        },
      ),
    ]);
  }
}
