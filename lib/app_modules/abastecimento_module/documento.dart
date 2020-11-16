import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/stores/abastecimento_base_store.dart';
import 'package:todomobx/stores/abastecimento_registro_store.dart';
import 'package:todomobx/stores/base_store.dart';
import 'package:todomobx/stores/cadastro_1_store.dart';
import 'package:todomobx/widgets/custom_text_field.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:io';

class Documento extends StatefulWidget {
  @override
  _DocumentoState createState() => _DocumentoState();
}

class _DocumentoState extends State<Documento> {
  var enDatesFuture = initializeDateFormatting('pt_BR', null);
  var formatter = DateFormat.yMMMMEEEEd('pt_BR').add_Hm();
  var hora = new DateTime.now().hour;
  File foto;
  String path = "";
  TextEditingController data = new TextEditingController();
  final f = new DateFormat('dd-MM-yyyy');
  Cadastro1Store cadastro1store;
  AbastecimentoBaseStore abastecimentoBaseStore;
  BaseStore baseStore;
  TextEditingController posto = new TextEditingController();
  TextEditingController odometro = new TextEditingController();
  TextEditingController litros = new TextEditingController();
  TextEditingController valor = new TextEditingController();
  TextEditingController nf = new TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cadastro1store = Provider.of<Cadastro1Store>(context);
    baseStore = Provider.of<BaseStore>(context);
    abastecimentoBaseStore = Provider.of<AbastecimentoBaseStore>(context);
    abastecimentoBaseStore.nomePostoController.text = abastecimentoBaseStore.posto;
    odometro.text = abastecimentoBaseStore.odometroNew.toString();
    litros.text = abastecimentoBaseStore.litros.toString();
    valor.text = abastecimentoBaseStore.valor.toString();
    nf.text = abastecimentoBaseStore.nf;
    data.text = f
        .format(DateTime.fromMicrosecondsSinceEpoch(abastecimentoBaseStore.data.microsecondsSinceEpoch + 75600000000))
        .toString();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              "Abastecimento " +
                  formatter.format(
                      DateTime.fromMicrosecondsSinceEpoch(abastecimentoBaseStore.data.microsecondsSinceEpoch + 75600000000)),
              style: TextStyle(color: Color.fromARGB(255, 137, 202, 204), fontSize: MediaQuery.of(context).size.width * 0.05),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
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
              ],
            ),
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
              hint: "",
              formatter: new MaskTextInputFormatter(
                  mask: 'XX. XXX. XXX/XXXX-XX', filter: {"X": RegExp(r'[0-9]')}),
              color: Color.fromARGB(255, 137, 202, 204),
              onChanged: abastecimentoBaseStore.setCnpjPosto,
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
              hint: "",
              controller: abastecimentoBaseStore.nomePostoController,
              color: Color.fromARGB(255, 137, 202, 204),
              onChanged: abastecimentoBaseStore.setPosto,
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
                    hint:"",
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
                                lastDate: DateTime(2050))
                            .then((value) {
                          abastecimentoBaseStore.setData(value);
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
              hint: "",
              color: Color.fromARGB(255, 137, 202, 204),
              controller: odometro,
              onChanged: (value) {
                abastecimentoBaseStore.setNewOdometro(value);
              },
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
              controller: litros,
              hint: "00.00",
              onChanged: (value) {
                abastecimentoBaseStore.setLitros(value);
              },
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
              hint: "",
              color: Color.fromARGB(255, 137, 202, 204),
              controller: valor,
              onChanged: (value) {
                abastecimentoBaseStore.setValor(value);
              },
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
              hint:"",
              color: Color.fromARGB(255, 137, 202, 204),
              controller: nf,
              onChanged: (value) {
                abastecimentoBaseStore.setNf(value);
              },
              textInputType: TextInputType.number,
              enabled: true,
            ),
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
                      abastecimentoBaseStore.setTanqueCheio(true);
                    },
                    child: Container(
                        margin: EdgeInsets.only(top:18, left: 18, right: 18),
                        child: Row(
                          children: [
                            Text(
                              'Sim ',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: abastecimentoBaseStore.tanqueCheio
                                      ? Color.fromARGB(255, 25, 153, 158)
                                      : Color.fromARGB(255, 204, 204, 204)),
                            ),
                            Icon(
                              Icons.check,
                              size: 18,
                              color: abastecimentoBaseStore.tanqueCheio
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
                      abastecimentoBaseStore.setTanqueCheio(false);
                    },
                    child: Container(
                        margin: EdgeInsets.only(top:18, left: 18, right: 18),
                        child: Row(
                          children: [
                            Text(
                              'Não ',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: !abastecimentoBaseStore.tanqueCheio
                                      ? Color.fromARGB(255, 25, 153, 158)
                                      : Color.fromARGB(255, 204, 204, 204)),
                            ),
                            Icon(
                              Icons.clear,
                              size: 18,
                              color: !abastecimentoBaseStore.tanqueCheio
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
                      abastecimentoBaseStore.setTanqueCheio(false);
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
                              (abastecimentoBaseStore.litros != 0
                                  ? ((abastecimentoBaseStore.odometroNew - abastecimentoBaseStore.odometroOld) /
                                  abastecimentoBaseStore.litros)
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
          SizedBox(
            height: 20,
          ),
          Center(
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),),//, side: BorderSide(color: Color.fromARGB(255, 25, 153, 158))),
              onPressed: () async {
                final firestore = FirebaseFirestore.instance;
                firestore
                    .collection('Companies')
                    .doc(baseStore.cnpj.replaceAll('.', "").replaceAll("-", ""))
                    .collection("Supplies")
                    .doc(abastecimentoBaseStore.documento)
                    .update({
                  'gasStationName': abastecimentoBaseStore.posto,
                  'gasStationCnpj': abastecimentoBaseStore.cnpjPosto,
                  'odometerNew': abastecimentoBaseStore.odometroNew,
                  'amount': abastecimentoBaseStore.litros,
                  'totalPrice': abastecimentoBaseStore.valor,
                  'invoice': abastecimentoBaseStore.nf,
                  'fullTank': abastecimentoBaseStore.tanqueCheio,
                  'invoicePhoto': path!=""?abastecimentoBaseStore.invoicePhoto:path
                });
                firestore
                    .collection('Companies')
                    .doc(baseStore.cnpj.replaceAll('.', "").replaceAll("-", ""))
                    .collection("Horses")
                    .doc(cadastro1store.placaCavalo)
                    .update({'odometer': abastecimentoBaseStore.odometroNew});
              },
              child: Container(
                  width: 220,
                  height: 60,
                  child: Center(
                    child: Text(
                      "Atualizar",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  )),
              color: Color.fromARGB(255, 137, 202, 204),
            ),
          ),
          SizedBox(height:10),
        ],
      ),
    );
  }
}
