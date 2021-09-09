import "dart:io";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:flutter/material.dart";
import "package:flutter_mobx/flutter_mobx.dart";
import "package:image_picker/image_picker.dart";
import "package:intl/intl.dart";
import "package:mask_text_input_formatter/mask_text_input_formatter.dart";
import "package:path/path.dart" as Path;
import "package:provider/provider.dart";
import "package:todomobx/stores/abastecimento_base_store.dart";
import "package:todomobx/stores/abastecimento_registro_store.dart";
import "package:todomobx/stores/base_store.dart";
import "package:todomobx/stores/cadastro_1_store.dart";
import 'package:todomobx/utils/Logger.dart';
import "package:todomobx/widgets/aviso.dart";
import "package:todomobx/widgets/custom_text_field.dart";
import "package:todomobx/widgets/decimal.dart";

class Registro extends StatefulWidget {
  @override
  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  late Cadastro1Store cadastro1store;
  AbastecimentoRegistroStore abastecimentoRegistroStore = new AbastecimentoRegistroStore();
  late AbastecimentoBaseStore abastecimentoBaseStore;
  var pressed = false;
  late BaseStore baseStore;
  File foto = new File("");
  String path = "";
  var loading = false;
  TextEditingController data = new TextEditingController();
  TextEditingController valorLitro = new TextEditingController();
  final f = new DateFormat("dd-MM-yyyy");

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    abastecimentoRegistroStore.base = Provider.of<BaseStore>(context);
    abastecimentoRegistroStore.cadastro = Provider.of<Cadastro1Store>(context);
    cadastro1store = Provider.of<Cadastro1Store>(context);
    baseStore = Provider.of<BaseStore>(context);
    data.text = f.format(abastecimentoRegistroStore.data).toString();
    abastecimentoRegistroStore.odometroOld = baseStore.odometro;
    abastecimentoBaseStore = Provider.of<AbastecimentoBaseStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: Container(
            height: MediaQuery.of(context).size.width * 0.2,
            width: MediaQuery.of(context).size.width * 0.2,
            child: CircularProgressIndicator(
                strokeWidth: 10, valueColor: new AlwaysStoppedAnimation<Color>(Colors.white), backgroundColor: Color.fromARGB(255, 137, 202, 204)),
          ))
        : SingleChildScrollView(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "  Abastecimento",
                textScaleFactor: 1,
                style:
                    TextStyle(color: Color.fromARGB(255, 137, 202, 204), fontSize: MediaQuery.of(context).size.width * 0.05, decoration: TextDecoration.none),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("  Cavalo",
                            textScaleFactor: 1,
                            style: TextStyle(
                                color: Color.fromARGB(255, 117, 117, 117),
                                fontSize: MediaQuery.of(context).size.width * 0.035,
                                decoration: TextDecoration.none)),
                        Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.27,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 4,
                                  color: Color.fromARGB(255, 228, 228, 228),
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(5))),
                            child: Center(
                              child: Text(cadastro1store.placaCavalo,
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 137, 202, 204),
                                      fontSize: MediaQuery.of(context).size.width * 0.045,
                                      decoration: TextDecoration.none)),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
                child: Text(
                  "CNPJ do posto",
                  textScaleFactor: 1,
                  style: TextStyle(
                      color: Color.fromARGB(255, 117, 117, 117), fontSize: MediaQuery.of(context).size.width * 0.035, decoration: TextDecoration.none),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomTextField(
                  hint: "",
                  formatter: new MaskTextInputFormatter(mask: "XX. XXX. XXX/XXXX-XX", filter: {"X": RegExp(r"[0-9]")}),
                  color: Color.fromARGB(255, 137, 202, 204),
                  onChanged: (value) async {
                    await abastecimentoRegistroStore.setCnpjPosto(value);
                  },
                  textInputType: TextInputType.number,
                  enabled: true,
                  controller: TextEditingController(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
                child: Text(
                  "Nome do posto *",
                  textScaleFactor: 1,
                  style: TextStyle(
                      color: Color.fromARGB(255, 117, 117, 117), fontSize: MediaQuery.of(context).size.width * 0.035, decoration: TextDecoration.none),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomTextField(
                  formatter: new MaskTextInputFormatter(
                      mask: "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", filter: {"X": RegExp(r"[A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ ]")}),
                  hint: "",
                  controller: abastecimentoRegistroStore.nomePostoController,
                  color: Color.fromARGB(255, 137, 202, 204),
                  onChanged: abastecimentoRegistroStore.setPosto,
                  enabled: true,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
                child: Text(
                  "Data",
                  textScaleFactor: 1,
                  style: TextStyle(
                      color: Color.fromARGB(255, 117, 117, 117), fontSize: MediaQuery.of(context).size.width * 0.035, decoration: TextDecoration.none),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2018), lastDate: DateTime(2050)).then((value) {
                            abastecimentoRegistroStore.setData(value!.add(Duration(hours: 3)));
                            setState(() {
                              data.text = f.format(value.add(Duration(hours: 3))).toString();
                            });
                          });
                        },
                        child: CustomTextField(
                          hint: "",
                          color: Color.fromARGB(255, 137, 202, 204),
                          controller: data,
                          enabled: false,
                          onChanged: (value) {},
                          formatter:
                              new MaskTextInputFormatter(mask: "###############################################", filter: {"#": RegExp(r"[a-zA-Z0-9@. ]")}),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: (IconButton(
                          icon: Icon(
                            Icons.calendar_today,
                            color: Color.fromARGB(255, 25, 153, 158),
                          ),
                          onPressed: () {
                            showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2018), lastDate: DateTime(2050)).then((value) {
                              abastecimentoRegistroStore.setData(value!.add(Duration(hours: 3)));
                              setState(() {
                                data.text = f.format(value.add(Duration(hours: 3))).toString();
                              });
                            });
                          },
                        )),
                      )
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
                child: Text(
                  "Odômetro (KM) *",
                  textScaleFactor: 1,
                  style: TextStyle(
                      color: Color.fromARGB(255, 117, 117, 117), fontSize: MediaQuery.of(context).size.width * 0.035, decoration: TextDecoration.none),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomTextField(
                  formatter: DecimalTextInputFormatter(),
                  hint: "",
                  color: Color.fromARGB(255, 137, 202, 204),
                  onChanged: abastecimentoRegistroStore.setOdometro,
                  textInputType: TextInputType.numberWithOptions(decimal: true, signed: false),
                  enabled: true,
                  controller: TextEditingController(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
                child: Text(
                  "Tipo de combustível *",
                  textScaleFactor: 1,
                  style: TextStyle(
                      color: Color.fromARGB(255, 117, 117, 117), fontSize: MediaQuery.of(context).size.width * 0.035, decoration: TextDecoration.none),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle, color: Colors.white, borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.grey)),
                child: Observer(builder: (_) {
                  return DropdownButton(
                    isExpanded: true,
                    underline: Container(),
                    onChanged: abastecimentoRegistroStore.setCombustivel,
                    value: abastecimentoRegistroStore.combustivel,
                    items: [
                      DropdownMenuItem(
                        child: Text(
                          "Selecione um combustível",
                          textScaleFactor: 1,
                          style: TextStyle(color: Color.fromARGB(255, 137, 202, 204)),
                        ),
                        value: "",
                      ),
                      DropdownMenuItem(
                        child: Text(
                          "DIESEL S-10",
                          textScaleFactor: 1,
                          style: TextStyle(color: Color.fromARGB(255, 137, 202, 204)),
                        ),
                        value: "DIESEL S-10",
                      ),
                      DropdownMenuItem(
                        child: Text(
                          "DIESEL S-500",
                          textScaleFactor: 1,
                          style: TextStyle(color: Color.fromARGB(255, 137, 202, 204)),
                        ),
                        value: "DIESEL S-500",
                      ),
                    ],
                  );
                }),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
                child: Text(
                  "Quantidade (Litros) *",
                  textScaleFactor: 1,
                  style: TextStyle(
                      color: Color.fromARGB(255, 117, 117, 117), fontSize: MediaQuery.of(context).size.width * 0.035, decoration: TextDecoration.none),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomTextField(
                  formatter: DecimalTextInputFormatter(),
                  hint: "",
                  color: Color.fromARGB(255, 137, 202, 204),
                  onChanged: abastecimentoRegistroStore.setLitros,
                  textInputType: TextInputType.numberWithOptions(decimal: true, signed: false),
                  enabled: true, controller: TextEditingController(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
                child: Text(
                  "Valor total R\$ *",
                  textScaleFactor: 1,
                  style: TextStyle(
                      color: Color.fromARGB(255, 117, 117, 117), fontSize: MediaQuery.of(context).size.width * 0.035, decoration: TextDecoration.none),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomTextField(controller: TextEditingController(),
                  hint: "",
                  formatter: DecimalTextInputFormatter(),
                  color: Color.fromARGB(255, 137, 202, 204),
                  onChanged: (valor) {
                    abastecimentoRegistroStore.setValor(valor);
                    if (abastecimentoRegistroStore.valor != 0 && abastecimentoRegistroStore.litros != 0) {
                      valorLitro.text = (abastecimentoRegistroStore.valor / abastecimentoRegistroStore.litros).toStringAsFixed(2);
                    }
                  },
                  textInputType: TextInputType.numberWithOptions(decimal: true, signed: false),
                  enabled: true,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
                child: Text(
                  "Valor por litro *",
                  textScaleFactor: 1,
                  style: TextStyle(
                      color: Color.fromARGB(255, 117, 117, 117), fontSize: MediaQuery.of(context).size.width * 0.035, decoration: TextDecoration.none),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomTextField(
                  hint: "",
                  color: Color.fromARGB(255, 137, 202, 204),
                  controller: valorLitro,
                  textInputType: TextInputType.numberWithOptions(decimal: true, signed: false),
                  enabled: false,
                  formatter: new MaskTextInputFormatter(mask: "###############################################", filter: {"#": RegExp(r"[a-zA-Z0-9@. ]")}),
                  onChanged: (value) {},
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
                child: Text(
                  "Nota fiscal",
                  textScaleFactor: 1,
                  style: TextStyle(
                      color: Color.fromARGB(255, 117, 117, 117), fontSize: MediaQuery.of(context).size.width * 0.035, decoration: TextDecoration.none),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomTextField(controller: TextEditingController(),
                  hint: "",
                  color: Color.fromARGB(255, 137, 202, 204),
                  onChanged: abastecimentoRegistroStore.setNf,
                  textInputType: TextInputType.number,
                  enabled: true, formatter: new MaskTextInputFormatter(mask: "###############################################", filter: { "#": RegExp(r"[a-zA-Z0-9@. ]") }),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              baseStore.online
                  ? Center(
                      child: SizedBox(
                      width: double.infinity,
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          size: MediaQuery.of(context).size.width * 0.15,
                          color: foto.path != "" ? Color.fromARGB(255, 137, 202, 204) : Color.fromARGB(255, 164, 164, 164),
                        ),
                        onPressed: () async {
                          await ImagePicker().pickImage(source: ImageSource.camera, maxHeight: 600, maxWidth: 800, imageQuality: 75).then((image) {
                            setState(() {
                              foto = File(image!.path);
                            });
                          });
                        },
                      ),
                    ))
                  : Container(),
              SizedBox(
                height: 40,
              ),
              Observer(builder: (_context) {
                _context = context;
                return Center(
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ), //, side: BorderSide(color: Color.fromARGB(255, 25, 153, 158))),
                    onPressed: abastecimentoRegistroStore.isFormValid
                        ? () async {
                      try{
                        await showDialog(
                            context: _context,
                            builder: (context) {
                              return AlertDialog(
                                  title: Text(
                                    "Atenção",
                                    textScaleFactor: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                  content: Material(
                                      type: MaterialType.card,
                                      child: Container(
                                          height: MediaQuery.of(context).size.height * 0.25,
                                          width: MediaQuery.of(context).size.width * 0.9,
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
                                                child: Text(
                                                  "Completou o tanque?",
                                                  textScaleFactor: 1,
                                                  style: TextStyle(
                                                      color: Color.fromARGB(255, 117, 117, 117),
                                                      fontSize: MediaQuery.of(context).size.width * 0.035,
                                                      decoration: TextDecoration.none),
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Observer(
                                                        builder: (_) {
                                                          return GestureDetector(
                                                            onTap: () {
                                                              abastecimentoRegistroStore.setTanqueCheio(true);
                                                            },
                                                            child: Container(
                                                                margin: EdgeInsets.only(
                                                                    top: MediaQuery.of(context).size.width * 0.04,
                                                                    left: MediaQuery.of(context).size.width * 0.04),
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      "Sim ",
                                                                      textScaleFactor: 1,
                                                                      style: TextStyle(
                                                                          fontSize: MediaQuery.of(context).size.width * 0.04,
                                                                          color: abastecimentoRegistroStore.tanqueCheio
                                                                              ? Color.fromARGB(255, 25, 153, 158)
                                                                              : Color.fromARGB(255, 204, 204, 204)),
                                                                    ),
                                                                    Icon(
                                                                      Icons.check,
                                                                      size: MediaQuery.of(context).size.width * 0.045,
                                                                      color: abastecimentoRegistroStore.tanqueCheio
                                                                          ? Color.fromARGB(255, 25, 153, 158)
                                                                          : Color.fromARGB(255, 204, 204, 204),
                                                                    )
                                                                  ],
                                                                )),
                                                          );
                                                        },
                                                      ),
                                                      Observer(
                                                        builder: (_) {
                                                          return GestureDetector(
                                                            onTap: () {
                                                              abastecimentoRegistroStore.setTanqueCheio(false);
                                                            },
                                                            child: Container(
                                                                margin: EdgeInsets.only(
                                                                    top: MediaQuery.of(context).size.width * 0.04,
                                                                    left: MediaQuery.of(context).size.width * 0.04),
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      "Não ",
                                                                      textScaleFactor: 1,
                                                                      style: TextStyle(
                                                                          fontSize: MediaQuery.of(context).size.width * 0.04,
                                                                          color: !abastecimentoRegistroStore.tanqueCheio
                                                                              ? Color.fromARGB(255, 25, 153, 158)
                                                                              : Color.fromARGB(255, 204, 204, 204)),
                                                                    ),
                                                                    Icon(
                                                                      Icons.clear,
                                                                      size: MediaQuery.of(context).size.width * 0.045,
                                                                      color: !abastecimentoRegistroStore.tanqueCheio
                                                                          ? Color.fromARGB(255, 25, 153, 158)
                                                                          : Color.fromARGB(255, 204, 204, 204),
                                                                    )
                                                                  ],
                                                                )),
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  Observer(
                                                    builder: (_) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          abastecimentoRegistroStore.setTanqueCheio(false);
                                                        },
                                                        child: Container(
                                                            margin: EdgeInsets.only(
                                                                top: MediaQuery.of(context).size.width * 0.04,
                                                                left: MediaQuery.of(context).size.width * 0.04),
                                                            child: Row(
                                                              children: [
                                                                abastecimentoRegistroStore.tanqueCheio
                                                                    ? Text(
                                                                  "Média: ",
                                                                  textScaleFactor: 1,
                                                                  style: TextStyle(
                                                                      fontSize: MediaQuery.of(context).size.width * 0.04,
                                                                      color: Color.fromARGB(255, 25, 153, 158)),
                                                                )
                                                                    : Text(
                                                                  "",
                                                                  textScaleFactor: 1,
                                                                  style: TextStyle(
                                                                      fontSize: MediaQuery.of(context).size.width * 0.04,
                                                                      color: Color.fromARGB(255, 25, 153, 158)),
                                                                ),
                                                                abastecimentoRegistroStore.tanqueCheio
                                                                    ? Text(
                                                                  ((abastecimentoRegistroStore.litros != 0
                                                                      ? ((abastecimentoRegistroStore.odometro -
                                                                      abastecimentoRegistroStore.odometroOld) /
                                                                      (abastecimentoRegistroStore.litros +
                                                                          abastecimentoRegistroStore.litrosIntermediarios))
                                                                      .toStringAsFixed(2)
                                                                      : "0")
                                                                      .length >
                                                                      3
                                                                      ? (abastecimentoRegistroStore.litros != 0
                                                                      ? ((abastecimentoRegistroStore.odometro -
                                                                      abastecimentoRegistroStore.odometroOld) /
                                                                      (abastecimentoRegistroStore.litros +
                                                                          abastecimentoRegistroStore.litrosIntermediarios))
                                                                      .toStringAsFixed(2)
                                                                      : "0")
                                                                      .substring(0, 3)
                                                                      : (abastecimentoRegistroStore.litros != 0
                                                                      ? ((abastecimentoRegistroStore.odometro -
                                                                      abastecimentoRegistroStore.odometroOld) /
                                                                      (abastecimentoRegistroStore.litros +
                                                                          abastecimentoRegistroStore.litrosIntermediarios))
                                                                      .toStringAsFixed(2)
                                                                      : "0")) +
                                                                      "km/L",
                                                                  textScaleFactor: 1,
                                                                  style: TextStyle(
                                                                      fontSize: MediaQuery.of(context).size.width * 0.036,
                                                                      color: Color.fromARGB(255, 25, 153, 158)),
                                                                )
                                                                    : Container(),
                                                              ],
                                                            )),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context).size.height * 0.03,
                                              ),
                                              Center(
                                                  child: RaisedButton(
                                                    color: Color.fromARGB(255, 137, 202, 204),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(5),
                                                    ),
                                                    child: Container(
                                                        width: 320,
                                                        height: 60,
                                                        child: Center(
                                                          child: Text(
                                                            "Finalizar registro",
                                                            textScaleFactor: 1,
                                                            style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05, color: Colors.white),
                                                          ),
                                                        )),
                                                    onPressed: () {
                                                      pressed = true;
                                                      Navigator.of(context).pop();
                                                    },
                                                  )),
                                            ],
                                          ))));
                            }).then((val) async {
                          if (pressed) {
                            setState(() {
                              loading = !loading;
                            });
                            var firestore;
                            try {
                              final result = await InternetAddress.lookup("example.com");
                              if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                                firestore = FirebaseFirestore.instance;
                              }
                            } on SocketException catch (_) {
                              firestore = FirebaseFirestore.instance;
                              await firestore.disableNetwork();
                            }

                            await abastecimentoRegistroStore.setData(abastecimentoRegistroStore.data);
                            if (((abastecimentoRegistroStore.odometro - abastecimentoRegistroStore.odometroOld) /
                                (abastecimentoRegistroStore.litros + abastecimentoRegistroStore.litrosIntermediarios) >
                                (baseStore.mediaProposta + 2.5)) ||
                                ((abastecimentoRegistroStore.odometro - abastecimentoRegistroStore.odometroOld) /
                                    (abastecimentoRegistroStore.litros + abastecimentoRegistroStore.litrosIntermediarios) <
                                    (baseStore.mediaProposta - 1.5))) {
                              abastecimentoRegistroStore.first = true;
                            }
                            if (abastecimentoRegistroStore.last) {
                              firestore
                                  .collection("Companies")
                                  .doc(baseStore.cnpj.replaceAll(".", "").replaceAll("-", ""))
                                  .collection("Horses")
                                  .doc(cadastro1store.placaCavalo)
                                  .update({"odometer": abastecimentoRegistroStore.odometro});
                            }
                            if (foto.path != "") {
                              var storageReference = FirebaseStorage.instance.ref().child("invoices/${Path.basename(foto.path)}");
                              var uploadTask = storageReference.putFile(foto);
                              await uploadTask.whenComplete(() => null);
                              await storageReference.getDownloadURL().then((fileURL) {
                                setState(() {
                                  path = fileURL;
                                });
                              });
                            }
                            var id = baseStore.getRandomString(20) + baseStore.cpf + DateTime.now().toString();
                            firestore
                                .collection("Companies")
                                .doc(baseStore.cnpj.replaceAll(".", "").replaceAll("-", ""))
                                .collection("Supplies")
                                .doc(id)
                                .set({
                              "licensePlate": cadastro1store.placaCavalo,
                              "gasStationName": abastecimentoRegistroStore.posto,
                              "gasStationCnpj": abastecimentoRegistroStore.cnpjPosto,
                              "odometerOld": abastecimentoRegistroStore.last ? baseStore.odometro : abastecimentoRegistroStore.odometroOld,
                              "odometerNew": abastecimentoRegistroStore.odometro,
                              "amount": abastecimentoRegistroStore.litros,
                              "totalPrice": abastecimentoRegistroStore.valor,
                              "invoice": abastecimentoRegistroStore.nf,
                              "fullTank": abastecimentoRegistroStore.tanqueCheio,
                              "date": Timestamp.fromMillisecondsSinceEpoch(abastecimentoRegistroStore.data.millisecondsSinceEpoch),
                              "driverCPF": baseStore.cpf,
                              "invoicePhoto": path,
                              "fuel": abastecimentoRegistroStore.combustivel,
                              "driverName": baseStore.nome,
                              "first": abastecimentoRegistroStore.first,
                              "isCounted": true,
                              "average": (abastecimentoRegistroStore.odometro - abastecimentoRegistroStore.odometroOld) /
                                  (abastecimentoRegistroStore.litros + abastecimentoRegistroStore.litrosIntermediarios)
                            });
                            firestore.collection("Companies").doc(baseStore.cnpj).update({"numberOfSupplies": FieldValue.increment(1)});

                            if ((abastecimentoRegistroStore.odometro - baseStore.odometro) /
                                (abastecimentoRegistroStore.litros + abastecimentoRegistroStore.litrosIntermediarios) <
                                (baseStore.mediaProposta - 1.5) ||
                                (abastecimentoRegistroStore.odometro - baseStore.odometro) /
                                    (abastecimentoRegistroStore.litros + abastecimentoRegistroStore.litrosIntermediarios) >
                                    (baseStore.mediaProposta + 2.5)) {
                              if (abastecimentoRegistroStore.tanqueCheio) {
                                firestore.collection("Companies").doc(baseStore.cnpj).collection("Warnings").add({
                                  "driverCPF": baseStore.cpf,
                                  "text": "Erro no abastecimento",
                                  "date": Timestamp.fromMillisecondsSinceEpoch(abastecimentoRegistroStore.data.millisecondsSinceEpoch),
                                  "supply": firestore.collection("Companies").doc(baseStore.cnpj).collection("Supplies").doc(id),
                                  "checked": false,
                                  "type": "supply"
                                });
                                baseStore.setWarnings(1);
                              }
                            } else {
                              if (!abastecimentoRegistroStore.first) {
                                if (abastecimentoRegistroStore.tanqueCheio) {
                                  var averages =
                                  await firestore.collection("Drivers").doc(baseStore.cpf).collection("Averages").doc(cadastro1store.placaCavalo).get();
                                  if (averages.exists) {
                                    var data = averages.data();
                                    firestore.collection("Drivers").doc(baseStore.cpf).collection("Averages").doc(cadastro1store.placaCavalo).update({
                                      "distance": data["distance"] + abastecimentoRegistroStore.odometro - abastecimentoRegistroStore.odometroOld,
                                      "liters": abastecimentoRegistroStore.litros + data["liters"] + abastecimentoRegistroStore.litrosIntermediarios,
                                      "average": (data["distance"] + abastecimentoRegistroStore.odometro - abastecimentoRegistroStore.odometroOld) /
                                          (abastecimentoRegistroStore.litros + data["liters"] + abastecimentoRegistroStore.litrosIntermediarios),
                                      "lastSupply": Timestamp.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch)
                                    });
                                  } else {
                                    firestore.collection("Drivers").doc(baseStore.cpf).collection("Averages").doc(cadastro1store.placaCavalo).set({
                                      "proposedAverage": baseStore.mediaProposta,
                                      "distance": abastecimentoRegistroStore.odometro - abastecimentoRegistroStore.odometroOld,
                                      "liters": (abastecimentoRegistroStore.litros + abastecimentoRegistroStore.litrosIntermediarios),
                                      "average": (abastecimentoRegistroStore.odometro - abastecimentoRegistroStore.odometroOld) /
                                          (abastecimentoRegistroStore.litros + abastecimentoRegistroStore.litrosIntermediarios),
                                      "lastSupply": Timestamp.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch)
                                    });
                                  }
                                }
                              }
                            }
                            if (abastecimentoRegistroStore.last) {
                              baseStore.odometro = abastecimentoRegistroStore.odometro;
                            } else {
                              firestore
                                  .collection("Companies")
                                  .doc(baseStore.cnpj.replaceAll(".", "").replaceAll("-", ""))
                                  .collection("Supplies")
                                  .doc(abastecimentoRegistroStore.idAbsNew)
                                  .update({"odometerOld": abastecimentoRegistroStore.odometro});
                            }

                            setState(() {
                              loading = !loading;
                            });
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return Aviso("Abastecimento registrado!");
                            }));
                            await Future.delayed(const Duration(seconds: 2), () => "2");
                            abastecimentoBaseStore.setIndex(0, context, false);
                            Navigator.of(context).pop();
                          }
                        });
                      }
                      catch(e, stacktrace){
                        Logger logger = new Logger();
                        logger.firebaseLog(e,stacktrace,data: {"Motorista":baseStore.cpf, "Cavalo":cadastro1store.placaCarreta1});
                      }
                          }
                        : () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      title: Text(
                                        "Atenção",
                                        textAlign: TextAlign.center,
                                      ),
                                      content: Material(
                                          type: MaterialType.card,
                                          child: Container(
                                            height: MediaQuery.of(context).size.height * 0.2,
                                            width: MediaQuery.of(context).size.width * 0.9,
                                            child: Text(
                                              "Inserir as informações obrigatórias (campos com *)",
                                              textScaleFactor: 1,
                                              style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05),
                                            ),
                                          )));
                                });
                          },
                    child: Container(
                        width: 220,
                        height: 60,
                        child: Center(
                          child: Text(
                            "Registrar",
                            textScaleFactor: 1,
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                        )),
                    color: abastecimentoRegistroStore.isFormValid ? Color.fromARGB(255, 137, 202, 204) : Colors.grey,
                  ),
                );
              }),
              SizedBox(height: 10),
            ],
          ));
  }
}
