import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/stores/cadastro_2_store.dart';
import 'package:todomobx/widgets/custom_background.dart';
import 'package:todomobx/widgets/custom_icon_button.dart';
import 'package:todomobx/widgets/custom_text_field.dart';

import 'cadastro_3.dart';

class Cadastro2 extends StatefulWidget {
  @override
  _Cadastro2State createState() => _Cadastro2State();
}

class _Cadastro2State extends State<Cadastro2> {
  var remember = false;
  Cadastro2Store cadastro2Store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cadastro2Store = Provider.of<Cadastro2Store>(context);
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
        header: "Cadastro de motorista",
        image: "img5.jpeg",
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.height * 0.06,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: Color.fromARGB(255, 140, 140, 140))),
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_outlined,
                    size: MediaQuery.of(context).size.width*0.05,
                    color: Color.fromARGB(255, 170, 170, 170),
                  ),
                  onPressed: () {

                    Navigator.of(context).pop();
                  }),
            ),
          ),
          SizedBox(height: 20,),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Suas informações",style: TextStyle(color: Color.fromARGB(255, 137, 202, 204), fontSize: MediaQuery.of(context).size.width*0.073, fontWeight: FontWeight.bold),),
          ),
          SizedBox(height: 40,),

          CustomTextField(
            hint: 'Digite seu nome ',
            textInputType: TextInputType.emailAddress,
            onChanged: cadastro2Store.setNome,
            enabled: true,
          ),
          const SizedBox(
            height: 16,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "CPF *",
              style: TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 11, 78, 78)),
            ),
          ),
          CustomTextField(
            textInputType: TextInputType.number,
            hint: '___.___.___-__',
            formatter: new MaskTextInputFormatter(
                mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')}),
            onChanged: cadastro2Store.setCpf,
            enabled: true,
          ),
          const SizedBox(
            height: 16,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Telefone *",
              style: TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 11, 78, 78)),
            ),
          ),
          CustomTextField(
            textInputType: TextInputType.number,
            formatter: new MaskTextInputFormatter(
                mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')}),
            hint: '(##)#####.####',
            onChanged: cadastro2Store.setTelefone,
            enabled: true,
          ),
          const SizedBox(
            height: 16,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Email",
              style: TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 11, 78, 78)),
            ),
          ),
          CustomTextField(
            hint: 'Digite seu email',
            onChanged: cadastro2Store.setEmail,
            enabled: true,
          ),
          const SizedBox(
            height: 16,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Vencimento CNH",
              style: TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 11, 78, 78)),
            ),
          ),
          CustomTextField(
            textInputType: TextInputType.number,
            formatter: new MaskTextInputFormatter(
                mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')}),
            hint: '##/##/####',
            onChanged: cadastro2Store.setDataCNH,
            enabled: true,
          ),
          const SizedBox(
            height: 16,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Escolha uma senha",
              style: TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 11, 78, 78)),
            ),
          ),
          Observer(builder: (_) {
            return CustomTextField(
              formatter: new MaskTextInputFormatter(
                  mask: '################',
                  filter: {"#": RegExp(r'[0-9a-zA-Z]')}),
              hint: 'Senha *',
              onChanged: cadastro2Store.setPass,
              enabled: true,
              obscure: !cadastro2Store.passVisible,
              suffix: CustomIconButton(
                radius: 32,
                iconData: cadastro2Store.passVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                onTap: cadastro2Store.turnVisible,
              ),
            );
          }),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Entre 8 e 16 caracteres, números e letras",
              style: TextStyle(
                  fontSize: 10, color: Color.fromARGB(255, 11, 78, 78)),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Repita a senha *",
              style: TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 11, 78, 78)),
            ),
          ),
          Observer(
            builder: (_) {
              return CustomTextField(
                formatter: new MaskTextInputFormatter(
                    mask: '################',
                    filter: {"#": RegExp(r'[0-9a-zA-Z]')}),
                hint: 'Senha',
                onChanged: cadastro2Store.setConfirmPass,
                enabled: true,
                obscure: !cadastro2Store.passVisible,
                suffix: CustomIconButton(
                  radius: 32,
                  iconData: cadastro2Store.passVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  onTap: cadastro2Store.turnVisible,
                ),
              );
            },
          ),
          const SizedBox(
            height: 16,
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
                  child: Row(children: <Widget>[
                    Text(
                      'Continuar',
                      style: TextStyle(fontSize: 25),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      size: 34,
                    )
                  ]),
                  color: cadastro2Store.isFormValid
                      ? Color.fromARGB(255, 25, 153, 158)
                      : Colors.grey,
                  textColor: Colors.white,
                  onPressed: () {
                    cadastro2Store.isFormValid
                        ? Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Cadastro3()))
                        // ignore: unnecessary_statements
                        : null;
                  },
                ),
              );
            },
          ),
        ]);
  }
}
