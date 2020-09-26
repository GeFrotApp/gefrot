import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/stores/cadastro_1_store.dart';
import 'package:todomobx/stores/cadastro_2_store.dart';
import 'package:todomobx/stores/cadastro_3_store.dart';
import 'package:todomobx/widgets/custom_background.dart';
import 'package:todomobx/widgets/custom_text_field.dart';

import 'login_screen.dart';

class Cadastro3 extends StatefulWidget {
  @override
  _Cadastro3State createState() => _Cadastro3State();
}

class _Cadastro3State extends State<Cadastro3> {
  var remember = false;
  Cadastro3Store cadastro3Store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cadastro3Store = Provider.of<Cadastro3Store>(context);
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(header: "Cadastro do motorista", children: [
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
          "Vincule sua conta a uma transportadora",
          style: TextStyle(
              fontSize: 25, color: Color.fromARGB(255, 137, 202, 204)),
        ),
      ),
      SizedBox(
        height: 30,
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Transportadora (CNPJ) *",
          style:
              TextStyle(fontSize: 20, color: Color.fromARGB(255, 11, 78, 78)),
        ),
      ),
      CustomTextField(
        hint: 'Digite o CNPJ',
        textInputType: TextInputType.number,
        formatter: new MaskTextInputFormatter(
            mask: 'XX. XXX. XXX/XXXX-XX', filter: {"X": RegExp(r'[0-9]')}),
        onChanged: (value) async {
          cadastro3Store.setCnpj(value);
          if (cadastro3Store.cnpj.length == 20) {
            final firestore = Firestore.instance;
            var x = await firestore
                .collection('Companies')
                .document(cadastro3Store.cnpj
                    .replaceAll('.', "")
                    .replaceAll(" ", "")
                    .replaceAll("/", "")
                    .replaceAll("-", ""))
                .get();
            if (x.data != null) {
              cadastro3Store.setNomeEmpresa(x.data['name']);
            } else {
              cadastro3Store.setNomeEmpresa("Empresa não cadastrada");
            }
          } else {
            cadastro3Store.setNomeEmpresa("");
          }
        },
        enabled: true,
      ),
      Observer(
        builder: (_) {
          return cadastro3Store.nomeEmpresa == ""
              ? Text("")
              : Text(
                  cadastro3Store.nomeEmpresa,
                  style: TextStyle(
                      color:
                          cadastro3Store.nomeEmpresa != "Empresa não cadastrada"
                              ? Colors.lightGreen
                              : Colors.red),
                );
        },
      ),
      const SizedBox(
        height: 50,
      ),
      Observer(
        builder: (_) {
          return SizedBox(
            height: 44,
            width: 180,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                'Cadastrar',
                style: TextStyle(fontSize: 25),
              ),
              color: cadastro3Store.isFormValid
                  ? Color.fromARGB(255, 25, 153, 158)
                  : Colors.grey,
              textColor: Colors.white,
              onPressed: () async {
                var cadastro1Store =
                    Provider.of<Cadastro1Store>(context, listen: false);
                var cadastro2Store =
                    Provider.of<Cadastro2Store>(context, listen: false);
                final firestore = Firestore.instance;
                firestore
                    .collection('Drivers')
                    .document(cadastro2Store.cpf
                        .replaceAll('.', "")
                        .replaceAll("-", ""))
                    .setData({
                  'name': cadastro2Store.nome.toLowerCase(),
                  'password': cadastro2Store.pass,
                  'phone': cadastro2Store.telefone,
                  'email': cadastro2Store.email,
                  'cnpj': cadastro3Store.cnpj
                    ..replaceAll('.', "")
                        .replaceAll(" ", "")
                        .replaceAll("/", "")
                        .replaceAll("-", ""),
                  'cnhDueDate': cadastro2Store.dataCNH,
                  'companyApproval': 0
                });
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (_) {
                  return LoginScreen();
                }));
              },
            ),
          );
        },
      ),
      const SizedBox(
        height: 50,
      ),
    ]);
  }
}
