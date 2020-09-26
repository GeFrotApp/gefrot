import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/stores/abastecimento_registro_store.dart';
import 'package:todomobx/stores/base_store.dart';
import 'package:todomobx/stores/cadastro_1_store.dart';
import 'package:todomobx/widgets/custom_text_field.dart';

class Registro extends StatefulWidget {
  @override
  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  Cadastro1Store cadastro1store;
  AbastecimentoRegistroStore abastecimentoRegistroStore = new AbastecimentoRegistroStore();
  BaseStore baseStore;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cadastro1store = Provider.of<Cadastro1Store>(context);
    baseStore = Provider.of<BaseStore>(context);

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
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text('Cavalo',
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
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child: Center(
                      child: Text(cadastro1store.placaCavalo,
                          style: TextStyle(
                              color: Color.fromARGB(255, 25, 153, 158),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.045,
                              decoration: TextDecoration.none)),
                    )),
              ],
            ),
            Column(
              children: [
                Text(
                  'Carreta 1',
                  style: TextStyle(
                      color: Color.fromARGB(255, 117, 117, 117),
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      decoration: TextDecoration.none),
                ),
                Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.27,
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 4,
                          color: Color.fromARGB(255, 228, 228, 228),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child: Center(
                      child: Text(cadastro1store.placaCarreta1,
                          style: TextStyle(
                              color: Color.fromARGB(255, 25, 153, 158),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.045,
                              decoration: TextDecoration.none)),
                    )),
              ],
            ),
            Column(
              children: [
                Text(
                  cadastro1store.placaCarreta2,
                  style: TextStyle(
                      color: Color.fromARGB(255, 117, 117, 117),
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      decoration: TextDecoration.none),
                ),
                Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.27,
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 4,
                          color: Color.fromARGB(255, 228, 228, 228),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child: Center(
                      child: Text(cadastro1store.placaCarreta2,
                          style: TextStyle(
                              color: Color.fromARGB(255, 25, 153, 158),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.045,
                              decoration: TextDecoration.none)),
                    )),
              ],
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
          child: Text(
            'Posto de combustível',
            style: TextStyle(
                color: Color.fromARGB(255, 117, 117, 117),
                fontSize: MediaQuery.of(context).size.width * 0.035,
                decoration: TextDecoration.none),
          ),
        ),
       Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomTextField(
            onChanged: abastecimentoRegistroStore.setPosto,
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
              builder: (_){
                return GestureDetector(
                  onTap: (){
                    abastecimentoRegistroStore.setTanqueCheio(true);
                  },
                  child: Container(
                      margin: EdgeInsets.all(18),
                      child:Row(
                        children: [
                          Text('Sim ', style: TextStyle(fontSize: 16, color: abastecimentoRegistroStore.tanqueCheio?Color.fromARGB(255, 25, 153, 158):Color.fromARGB(255, 204, 204, 204)),),
                          Icon(Icons.check, size: 18, color: abastecimentoRegistroStore.tanqueCheio?Color.fromARGB(255, 25, 153, 158):Color.fromARGB(255, 204, 204, 204),)
                        ],
                      )
                  ),
                );
              },
            ),
            Observer(
              builder: (_){
                return GestureDetector(
                  onTap: (){
                    abastecimentoRegistroStore.setTanqueCheio(false);
                  },
                  child: Container(
                      margin: EdgeInsets.all(18),
                      child:Row(
                        children: [
                          Text('Não ', style: TextStyle(fontSize: 16, color: !abastecimentoRegistroStore.tanqueCheio?Color.fromARGB(255, 25, 153, 158):Color.fromARGB(255, 204, 204, 204)),),
                          Icon(Icons.clear, size: 18, color: !abastecimentoRegistroStore.tanqueCheio?Color.fromARGB(255, 25, 153, 158):Color.fromARGB(255, 204, 204, 204),)
                        ],
                      )
                  ),
                );
              },
            ),
            Observer(
              builder: (_){
                return GestureDetector(
                  onTap: (){
                    abastecimentoRegistroStore.setTanqueCheio(false);
                  },
                  child: Container(
                      margin: EdgeInsets.all(18),
                      child:Row(
                        children: [
                          Text('Média: ', style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 25, 153, 158)),),
                          Text((abastecimentoRegistroStore.litros!=0?((abastecimentoRegistroStore.odometro-baseStore.odometro)/abastecimentoRegistroStore.litros).toStringAsFixed(2):"0")+"km/L", style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 25, 153, 158)),),
                        ],
                      )
                  ),
                );
              },
            ),
          ],
        ),
        Center(
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Color.fromARGB(255, 25, 153, 158))
            ),
            onPressed: () async {
              final firestore = Firestore.instance;
              baseStore.odometro = abastecimentoRegistroStore.odometro;
              firestore
                  .collection('Companies')
                  .document(baseStore.cnpj
                  .replaceAll('.', "")
                  .replaceAll("-", ""))
                  .collection("Supplies").add({
              'address': abastecimentoRegistroStore.posto,
              'distance': abastecimentoRegistroStore.odometro-baseStore.odometro,
              'quantity': abastecimentoRegistroStore.litros,
              'value': abastecimentoRegistroStore.valor,
              'invoice': abastecimentoRegistroStore.nf,
              'fulltank': abastecimentoRegistroStore.tanqueCheio,
              });
              firestore
                  .collection('Companies')
                  .document(baseStore.cnpj
                  .replaceAll('.', "")
                  .replaceAll("-", ""))
        .collection("Horses").document(cadastro1store.placaCavalo).updateData({
    'odometer':abastecimentoRegistroStore.odometro
              });},
            child: Container(
              width: 120,
              height: 40,

                child: Center(
                  child: Text("Registrar", style: TextStyle(fontSize: 25, color: Colors.white),),
                )
            ),
            color: Color.fromARGB(255, 137, 202, 204),
          ),
        )
      ],

    );
  }
}
