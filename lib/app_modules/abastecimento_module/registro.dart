import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/stores/abastecimento_registro_store.dart';
import 'package:todomobx/stores/base_store.dart';
import 'package:todomobx/stores/cadastro_1_store.dart';
import 'package:todomobx/widgets/custom_text_field.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Registro extends StatefulWidget {
  @override
  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  Cadastro1Store cadastro1store;
  AbastecimentoRegistroStore abastecimentoRegistroStore = new AbastecimentoRegistroStore();

  BaseStore baseStore;
  File foto;
  String path = "";
  TextEditingController data = new TextEditingController();
  final f = new DateFormat('dd-MM-yyyy');

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cadastro1store = Provider.of<Cadastro1Store>(context);
    baseStore = Provider.of<BaseStore>(context);
    data.text = f.format(abastecimentoRegistroStore.data).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          '  Abastecimento',
          style: TextStyle(
              color: Color.fromARGB(255, 137, 202, 204),
              fontSize: MediaQuery.of(context).size.width * 0.05,
              decoration: TextDecoration.none),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('  Cavalo',
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
            'CNPJ do posto',
            style: TextStyle(
                color: Color.fromARGB(255, 117, 117, 117),
                fontSize: MediaQuery.of(context).size.width * 0.035,
                decoration: TextDecoration.none),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),

          child: CustomTextField(
            formatter: new MaskTextInputFormatter(
                mask: 'XX. XXX. XXX/XXXX-XX', filter: {"X": RegExp(r'[0-9]')}),
            color: Color.fromARGB(255, 137, 202, 204),
            onChanged: abastecimentoRegistroStore.setCnpjPosto,
            textInputType: TextInputType.number,
            enabled: true,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
          child: Text(
            'Nome do posto',
            style: TextStyle(
                color: Color.fromARGB(255, 117, 117, 117),
                fontSize: MediaQuery.of(context).size.width * 0.035,
                decoration: TextDecoration.none),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomTextField(
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
            'Data',
            style: TextStyle(
                color: Color.fromARGB(255, 117, 117, 117),
                fontSize: MediaQuery.of(context).size.width * 0.035,
                decoration: TextDecoration.none),
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Stack(
              children: [
                CustomTextField(
                  color: Color.fromARGB(255, 137, 202, 204),
                  controller: data,
                  enabled: false,
                ),
                Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: (IconButton(
                    icon: Icon(
                      Icons.calendar_today,
                      color: Color.fromARGB(255, 25, 153, 158),
                    ),
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2018),
                        lastDate: DateTime(2050)
                      ).then((value){
                          abastecimentoRegistroStore.setData(value);
                          setState(() {
                            data.text = f.format(value).toString();
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
            'Odômetro (KM)',
            style: TextStyle(
                color: Color.fromARGB(255, 117, 117, 117),
                fontSize: MediaQuery.of(context).size.width * 0.035,
                decoration: TextDecoration.none),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomTextField(
            color: Color.fromARGB(255, 137, 202, 204),
            onChanged: abastecimentoRegistroStore.setOdometro,
            textInputType: TextInputType.number,
            enabled: true,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
          child: Text(
            'Quantidade (Litros)',
            style: TextStyle(
                color: Color.fromARGB(255, 117, 117, 117),
                fontSize: MediaQuery.of(context).size.width * 0.035,
                decoration: TextDecoration.none),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomTextField(
            color: Color.fromARGB(255, 137, 202, 204),
            hint: "00.00",
            onChanged: abastecimentoRegistroStore.setLitros,
            textInputType: TextInputType.number,
            enabled: true,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
          child: Text(
            "Valor total R\$",
            style: TextStyle(
                color: Color.fromARGB(255, 117, 117, 117),
                fontSize: MediaQuery.of(context).size.width * 0.035,
                decoration: TextDecoration.none),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomTextField(
            color: Color.fromARGB(255, 137, 202, 204),
            onChanged: abastecimentoRegistroStore.setValor,
            textInputType: TextInputType.number,
            enabled: true,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
          child: Text(
            'Nota fiscal',
            style: TextStyle(
                color: Color.fromARGB(255, 117, 117, 117),
                fontSize: MediaQuery.of(context).size.width * 0.035,
                decoration: TextDecoration.none),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomTextField(
            color: Color.fromARGB(255, 137, 202, 204),
            onChanged: abastecimentoRegistroStore.setNf,
            textInputType: TextInputType.number,
            enabled: true,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
          child: Text(
            "Completou o tanque?",
            style: TextStyle(
                color: Color.fromARGB(255, 117, 117, 117),
                fontSize: MediaQuery.of(context).size.width * 0.035,
                decoration: TextDecoration.none),
          ),
        ),
        Row(
          children: [
            Observer(
              builder: (_) {
                return GestureDetector(
                  onTap: () {
                    abastecimentoRegistroStore.setTanqueCheio(true);
                  },
                  child: Container(
                      margin: EdgeInsets.only(top:18, left: 18, right: 18),
                      child: Row(
                        children: [
                          Text(
                            'Sim ',
                            style: TextStyle(
                                fontSize: 16,
                                color: abastecimentoRegistroStore.tanqueCheio
                                    ? Color.fromARGB(255, 25, 153, 158)
                                    : Color.fromARGB(255, 204, 204, 204)),
                          ),
                          Icon(
                            Icons.check,
                            size: 18,
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
                      margin: EdgeInsets.only(top:18, left: 18, right: 18),
                      child: Row(
                        children: [
                          Text(
                            'Não ',
                            style: TextStyle(
                                fontSize: 16,
                                color: !abastecimentoRegistroStore.tanqueCheio
                                    ? Color.fromARGB(255, 25, 153, 158)
                                    : Color.fromARGB(255, 204, 204, 204)),
                          ),
                          Icon(
                            Icons.clear,
                            size: 18,
                            color: !abastecimentoRegistroStore.tanqueCheio
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
                      margin: EdgeInsets.only(top:18, left: 18, right: 18),
                      child: Row(
                        children: [
                          Text(
                            'Média: ',
                            style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 25, 153, 158)),
                          ),
                          Text(
                            (abastecimentoRegistroStore.litros != 0
                                    ? ((abastecimentoRegistroStore.odometro - baseStore.odometro) /
                                            abastecimentoRegistroStore.litros)
                                        .toStringAsFixed(2)
                                    : "0") +
                                "km/L",
                            style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 25, 153, 158)),
                          ),
                        ],
                      )),
                );
              },
            ),

          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.8),
          child:  IconButton(
            icon: Icon(Icons.camera_alt, size: MediaQuery.of(context).size.width*0.15,color: Color.fromARGB(255, 164, 164, 164),),
            onPressed: () async {
              await ImagePicker().getImage(source: ImageSource.camera).then((image) {
                setState(() {
                  foto = File(image.path);
                });
              });
            },
          ),
        ),
        SizedBox(
          height: 15,
        ),

        Center(
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),),//, side: BorderSide(color: Color.fromARGB(255, 25, 153, 158))),
            onPressed:abastecimentoRegistroStore.isFormValid? () async {
              final firestore = FirebaseFirestore.instance;

              firestore
                  .collection('Companies')
                  .doc(baseStore.cnpj.replaceAll('.', "").replaceAll("-", ""))
                  .collection("Horses")
                  .doc(cadastro1store.placaCavalo)
                  .update({'odometer': abastecimentoRegistroStore.odometro});
              if (foto != null) {
                StorageReference storageReference = FirebaseStorage.instance.ref().child('invoices/${Path.basename(foto.path)}');
                StorageUploadTask uploadTask = storageReference.putFile(foto);
                await uploadTask.onComplete;
                await storageReference.getDownloadURL().then((fileURL) {
                  setState(() {
                    path = fileURL;
                  });
                  print(path);
                });
              }
              var id = await firestore
                  .collection('Companies')
                  .doc(baseStore.cnpj.replaceAll('.', "").replaceAll("-", ""))
                  .collection("Supplies")
                  .add({
                'licensePlate': cadastro1store.placaCavalo,
                'gasStationName': abastecimentoRegistroStore.posto,
                'gasStationCnpj': abastecimentoRegistroStore.cnpjPosto,
                'odometerOld': baseStore.odometro,
                'odometerNew': abastecimentoRegistroStore.odometro,
                'amount': abastecimentoRegistroStore.litros,
                'totalPrice': abastecimentoRegistroStore.valor,
                'invoice': abastecimentoRegistroStore.nf,
                'fullTank': abastecimentoRegistroStore.tanqueCheio,
                'date': Timestamp.fromMillisecondsSinceEpoch(abastecimentoRegistroStore.data.millisecondsSinceEpoch),
                'driverCpf': baseStore.cpf,
                'invoicePhoto': path
              });
              if ((abastecimentoRegistroStore.odometro - baseStore.odometro) / abastecimentoRegistroStore.litros <
                      (baseStore.mediaProposta - 1.0) ||
                  (abastecimentoRegistroStore.odometro - baseStore.odometro) / abastecimentoRegistroStore.litros >
                      (baseStore.mediaProposta + 1.0)) {
                firestore.collection('Drivers').doc(baseStore.cpf).collection("Warnings").add({
                  'text': "Erro no abastecimento",
                  'date': Timestamp.fromMillisecondsSinceEpoch(abastecimentoRegistroStore.data.millisecondsSinceEpoch),
                  'supply': id,
                });
              }
              baseStore.odometro = abastecimentoRegistroStore.odometro;
            }:(){},
            child: Container(
                width: 220,
                height: 60,
                child: Center(
                  child: Text(
                    "Registrar",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                )),
            color: abastecimentoRegistroStore.isFormValid?Color.fromARGB(255, 137, 202, 204):Colors.grey,
          ),
        ),
        SizedBox(height:10),
      ],
    );
  }
}
