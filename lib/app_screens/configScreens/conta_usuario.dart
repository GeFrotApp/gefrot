import "dart:ui";
import "package:flutter/material.dart";
import "package:flutter_mobx/flutter_mobx.dart";
import "package:mask_text_input_formatter/mask_text_input_formatter.dart";
import "package:provider/provider.dart";
import "package:todomobx/stores/base_store.dart";
import "package:todomobx/stores/config_store.dart";
import "package:todomobx/widgets/base_top.dart";
import "package:todomobx/widgets/config_top.dart";
import "package:todomobx/widgets/custom_text_field.dart";

class ContaUsuario extends StatefulWidget {
  @override
  _ContaUsuarioState createState() => _ContaUsuarioState();
}

class _ContaUsuarioState extends State<ContaUsuario> {
  BaseStore baseStore;
  ConfigStore configStore = new ConfigStore();
  TextEditingController nome;
  TextEditingController telefone;
  TextEditingController email;
  TextEditingController vencimento;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    baseStore = Provider.of<BaseStore>(context);
    nome = new TextEditingController(text: baseStore.nome);
    telefone = new TextEditingController(text: baseStore.telefone);
    email = new TextEditingController(text: baseStore.email);
    vencimento = new TextEditingController(text: baseStore.vencimentoCNH);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: ConfigTop(
            "Conta - Usuário",
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.15,
                          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                          decoration:
                              BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromARGB(255, 210, 210, 210)))),
                          child: Observer(
                            builder: (context) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Nome",
                                        textScaleFactor: 1,
                                        style: TextStyle(
                                            color: Color.fromARGB(250, 120, 120, 120),
                                            fontSize: MediaQuery.of(context).size.width * 0.045),
                                      ),
                                      configStore.editNome
                                          ? Flexible(child: Container(
                                        width: MediaQuery.of(context).size.width * 0.6,
                                        child: CustomTextField(
                                          controller: nome,
                                          onChanged: (value) {
                                            nome.text = value;
                                          },
                                        ),
                                      ))
                                          : Text(baseStore.nome,
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  color: Color.fromARGB(250, 120, 120, 120),
                                                  fontSize: MediaQuery.of(context).size.width * 0.030))
                                    ],
                                  ),
                                  configStore.editNome
                                      ? Row(
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.clear),
                                              onPressed: () {
                                                configStore.turnEditNome();
                                              },
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.check),
                                              onPressed: () async {
                                                await configStore.setNome(baseStore.cpf, nome.text);
                                                baseStore.setNome(nome.text);
                                                configStore.turnEditNome();
                                              },
                                            )
                                          ],
                                        )
                                      : IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: () {
                                            configStore.turnEditNome();
                                          },
                                        )
                                ],
                              );
                            },
                          )),
                      Observer(
                        builder: (context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.15,
                            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                            decoration:
                                BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromARGB(255, 210, 210, 210)))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Telefone",
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          color: Color.fromARGB(250, 120, 120, 120),
                                          fontSize: MediaQuery.of(context).size.width * 0.045),
                                    ),
                                    configStore.editPhone
                                        ? Flexible(child:Container(
                                      width: MediaQuery.of(context).size.width * 0.6,
                                      child: CustomTextField(
                                        textInputType: TextInputType.number,
                                        formatter: new MaskTextInputFormatter(
                                            mask: "(##) #####-####", filter: {"#": RegExp(r"[0-9]")}),
                                        hint: "(__)-_____-____",
                                        controller: telefone,
                                        onChanged: (value) {
                                          telefone.text = value;
                                        },
                                      ),
                                    ))
                                        : Text(baseStore.telefone,
                                        textScaleFactor: 1,
                                        style: TextStyle(
                                            color: Color.fromARGB(250, 120, 120, 120),
                                            fontSize: MediaQuery.of(context).size.width * 0.030))
                                  ],
                                ),
                                configStore.editPhone
                                    ? Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.clear),
                                      onPressed: () {
                                        configStore.turnEditPhone();
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.check),
                                      onPressed: () async {
                                        await configStore.setPhone(baseStore.cpf, telefone.text);
                                        baseStore.setTelefone(telefone.text);
                                        configStore.turnEditPhone();
                                      },
                                    )
                                  ],
                                )
                                    : IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    configStore.turnEditPhone();
                                  },
                                )

                              ],
                            )
                          );
                        },
                      ),
                      Observer(
                        builder: (context) {
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.15,
                              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                              decoration:
                              BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromARGB(255, 210, 210, 210)))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Email",
                                        textScaleFactor: 1,
                                        style: TextStyle(
                                            color: Color.fromARGB(250, 120, 120, 120),
                                            fontSize: MediaQuery.of(context).size.width * 0.045),
                                      ),
                                      configStore.editEmail
                                          ? Flexible(child:Container(
                                        width: MediaQuery.of(context).size.width * 0.6,
                                        child: CustomTextField(
                                          controller: email,
                                          onChanged: (value) {
                                            email.text = value;
                                          },
                                        ),
                                      ))
                                          : Text(baseStore.email,
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              color: Color.fromARGB(250, 120, 120, 120),
                                              fontSize: MediaQuery.of(context).size.width * 0.030))
                                    ],
                                  ),
                                  configStore.editEmail
                                      ? Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.clear),
                                        onPressed: () {
                                          configStore.turnEditMail();
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.check),
                                        onPressed: () async {
                                          await configStore.setMail(baseStore.cpf, email.text);
                                          baseStore.setEmail(email.text);
                                          configStore.turnEditMail();
                                        },
                                      )
                                    ],
                                  )
                                      : IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      configStore.turnEditMail();
                                    },
                                  )

                                ],
                              )
                          );
                        },
                      ),
                      Observer(
                        builder: (context) {
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.15,
                              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                              decoration:
                              BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromARGB(255, 210, 210, 210)))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Vencimento CNH",
                                        textScaleFactor: 1,
                                        style: TextStyle(
                                            color: Color.fromARGB(250, 120, 120, 120),
                                            fontSize: MediaQuery.of(context).size.width * 0.045),
                                      ),
                                      configStore.editCnh
                                          ? Flexible(child:Container(
                                        width: MediaQuery.of(context).size.width * 0.6,
                                        child: CustomTextField(
                                          textInputType: TextInputType.number,
                                          formatter: new MaskTextInputFormatter(
                                              mask: "##/##/####", filter: {"#": RegExp(r"[0-9]")}),
                                          hint: "dd/mm/aaaa",
                                          controller: vencimento,
                                          onChanged: (value) {
                                            vencimento.text = value;
                                          },
                                        ),
                                      ))
                                          : Text(baseStore.vencimentoCNH,
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              color: Color.fromARGB(250, 120, 120, 120),
                                              fontSize: MediaQuery.of(context).size.width * 0.030))
                                    ],
                                  ),
                                  configStore.editCnh
                                      ? Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.clear),
                                        onPressed: () {
                                          configStore.turnEditCnh();
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.check),
                                        onPressed: () async {
                                          await configStore.setCnh(baseStore.cpf, vencimento.text);
                                          baseStore.setCNH(vencimento.text);
                                          configStore.turnEditCnh();
                                        },
                                      )
                                    ],
                                  )
                                      : IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      configStore.turnEditCnh();
                                    },
                                  )

                                ],
                              )
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
