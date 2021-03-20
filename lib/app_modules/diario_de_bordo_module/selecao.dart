import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/app_modules/diario_de_bordo_module/jornada_base.dart';
import 'package:todomobx/stores/base_store.dart';
import 'package:todomobx/stores/checklist_base_store.dart';
import 'package:todomobx/stores/checklist_item_store.dart';
import 'package:todomobx/stores/home_store.dart';
import 'package:todomobx/stores/jornada_base_store.dart';
import 'package:todomobx/stores/jornada_store.dart';

class Jornada extends StatefulWidget {
  @override
  _JornadaState createState() => _JornadaState();
}

class _JornadaState extends State<Jornada> {
  var enDatesFuture = initializeDateFormatting('pt_BR', null);
  var formatter = DateFormat.yMMMMEEEEd('pt_BR').add_Hm();
  var hora = new DateTime.now().hour;
  HomeStore homeStore;
  BaseStore baseStore;
  JornadaBaseStore jornadaBaseStore;
  JornadaStore jornadaStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    homeStore = Provider.of<HomeStore>(context);
    baseStore = Provider.of<BaseStore>(context);
    jornadaBaseStore = Provider.of<JornadaBaseStore>(context);
    jornadaStore = Provider.of<JornadaStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child:Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.99,
              height: MediaQuery.of(context).size.height * 0.2,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                elevation: 5,
                child: Observer(
                  builder: (_) {
                    return RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      color: jornadaBaseStore.jornada
                          ? Color.fromARGB(255, 187, 242, 164)
                          : Color.fromARGB(255, 253, 149, 149),
                      onPressed: jornadaBaseStore.turnJornada,
                      child: Text(
                        jornadaBaseStore.jornada
                            ? "Encerrar jornada"
                            : "Iniciar Jornada",
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
