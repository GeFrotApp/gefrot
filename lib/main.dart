import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/login_screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todomobx/stores/base_store.dart';
import 'package:todomobx/stores/cadastro_1_store.dart';
import 'package:todomobx/stores/cadastro_2_store.dart';
import 'package:todomobx/stores/cadastro_3_store.dart';
import 'package:todomobx/stores/checklist_base_store.dart';
import 'package:todomobx/stores/checklist_item_store.dart';
import 'package:todomobx/stores/home_store.dart';
import 'package:todomobx/stores/login_store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var cpf = prefs.getString("cpf");
  var senha = prefs.getString("pass");
  var remember;
  if(cpf != ""){
    remember = true;
  }else{
    remember = false;
  }
  runApp(MyApp(cpf, senha, remember));


}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp(cpf, senha, remember){
    this.cpf = cpf;
    this.senha = senha;
    this.remember = remember;
  }
  var cpf;
  var senha;
  var remember;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LoginStore>(create:(_)=> LoginStore(cpf, senha, remember),),
        Provider<Cadastro1Store>(create:(_)=> Cadastro1Store(),),
        Provider<Cadastro2Store>(create:(_)=> Cadastro2Store(),),
        Provider<Cadastro3Store>(create:(_)=> Cadastro3Store(),),
        Provider<HomeStore>(create:(_)=> HomeStore(),),
        Provider<BaseStore>(create:(_)=> BaseStore(),),
        Provider<ChecklistItemStore>(create:(_)=> ChecklistItemStore(),),
        Provider<ChecklistBaseStore>(create:(_)=>ChecklistBaseStore(),)
      ],
      child: MaterialApp(
        title: 'MobX Tutorial',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 108, 190, 193),
          cursorColor: Color.fromARGB(255, 108, 190, 193),
          scaffoldBackgroundColor: Color.fromARGB(255, 108, 190, 193),
        ),
        home: LoginScreen(),
      ),
    );
  }
}
String capitalize(String s) => s[0].toUpperCase() + s.substring(1);