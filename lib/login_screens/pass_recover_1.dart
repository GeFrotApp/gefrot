import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/login_screens/login_screen.dart';
import 'package:todomobx/stores/login_store.dart';
import 'package:todomobx/stores/pass_recover_store.dart';
import 'package:todomobx/widgets/aviso.dart';
import 'package:todomobx/widgets/custom_background.dart';
import 'package:todomobx/widgets/custom_icon_button.dart';
import 'package:todomobx/widgets/custom_pass_text_field.dart';
import 'package:todomobx/widgets/custom_text_field.dart';

class PassRecover1 extends StatefulWidget {
  @override
  _PassRecover1State createState() => _PassRecover1State();
}

class _PassRecover1State extends State<PassRecover1> {
  TextEditingController cpfController = new TextEditingController();
  PassRecoverStore passRecoverStore = new PassRecoverStore();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      header: "Redefinir sua senha",
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width,
          child: loading
              ? Center(
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Center(
                    child: Container(
                      width:MediaQuery.of(context).size.width*0.2,
                      height:MediaQuery.of(context).size.width*0.2,
                      child: CircularProgressIndicator(
                          strokeWidth: 10,
                          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                          backgroundColor: Color.fromARGB(255, 137, 202, 204)),
                    ),
                  )
              ))
              :Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), border: Border.all(color: Color.fromARGB(255, 140, 140, 140))),
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_outlined,
                        size: MediaQuery.of(context).size.width * 0.05,
                        color: Color.fromARGB(255, 120, 120, 120),
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
                  "Redefina sua senha",
                  style: TextStyle(
                      color: Color.fromARGB(255, 137, 202, 204),
                      fontSize: MediaQuery.of(context).size.width * 0.073,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Digite aqui seu CPF",
                  style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 11, 78, 78)),
                ),
              ),
              CustomTextField(
                hint: '___.___.___-__',
                controller: cpfController,
                textInputType: TextInputType.number,
                formatter: new MaskTextInputFormatter(mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')}),
                onChanged: passRecoverStore.checkCpf,
                enabled: true,
              ),
              const SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Escolha uma senha *",
                  style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 11, 78, 78)),
                ),
              ),
              Observer(builder: (_) {
                return CustomPassTextField(
                  formatter: new MaskTextInputFormatter(mask: '################', filter: {"#": RegExp(r'[0-9a-zA-Z]')}),
                  hint: 'Senha *',
                  onChanged: passRecoverStore.setPass,
                  enabled: true,
                  obscure: !passRecoverStore.passVisible,
                  suffix: CustomIconButton(
                    radius: 32,
                    iconData: passRecoverStore.passVisible ? Icons.visibility : Icons.visibility_off,
                    onTap: passRecoverStore.turnVisible,
                  ),
                );
              }),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Entre 4 e 16 caracteres, números e letras",
                  style: TextStyle(fontSize: 10, color: Color.fromARGB(255, 11, 78, 78)),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Confirme sua senha *",
                  style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 11, 78, 78)),
                ),
              ),
              Observer(
                builder: (_) {
                  return CustomPassTextField(
                    formatter: new MaskTextInputFormatter(mask: '################', filter: {"#": RegExp(r'[0-9a-zA-Z]')}),
                    hint: 'Confirmação da senha',
                    onChanged: passRecoverStore.setConfirmPass,
                    enabled: true,
                    obscure: !passRecoverStore.passVisible,
                    suffix: CustomIconButton(
                      radius: 32,
                      iconData: passRecoverStore.passVisible ? Icons.visibility : Icons.visibility_off,
                      onTap: passRecoverStore.turnVisible,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Observer(
                builder: (_) {
                  return Container(
                      height: MediaQuery.of(context).size.height * 0.065,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: RaisedButton(
                        disabledColor: Color.fromARGB(255, 210, 210, 210),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                          Text(
                            'Redefinir',
                            style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.056,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ]),
                        color: Color.fromARGB(255, 137, 202, 204),
                        onPressed: passRecoverStore.isFormValid
                            ? () async {
                          print(sha256.convert(utf8.encode(passRecoverStore.pass)));
                                setState(() {
                                  loading = !loading;
                                });
                                var document = FirebaseFirestore.instance.collection('Drivers').doc(passRecoverStore.cpf.replaceAll('.', '').replaceAll('-', ''));
                                var cnpj = (await document.get()).data()["cnpj"];
                                FirebaseFirestore.instance.collection('Companies').doc(cnpj).collection("Warnings").add({
                                  "date": Timestamp.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch),
                                  "type": "passRecover",
                                  "driverCPF": cpfController.text.replaceAll('.', '').replaceAll('-', ''),
                                  "driverNewPass":sha256.convert(utf8.encode(passRecoverStore.pass)).toString()
                                });
                                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                                  return Aviso("Senha redefinida!");
                                }));
                                await Future.delayed(const Duration(seconds: 2), () => "2");
                                setState(() {
                                  loading = !loading;
                                });
                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (context){
                                    return LoginScreen();
                                  }
                                ));
                              }
                            : null,
                      ));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
