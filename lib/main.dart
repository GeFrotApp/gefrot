import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/app_modules/abastecimento_module/abastecimento_base.dart';
import 'package:todomobx/login_screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todomobx/stores/abastecimento_base_store.dart';
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
  var cavalo = prefs.getString("cavalo");
  var carreta1 = prefs.getString("carreta1");
  var carreta2 = prefs.getString("carreta2");
  var carreta3 = prefs.getString("carreta3");
  var remember;
  var rememberEquip;
  if(cpf != ""){
    remember = true;
  }else{
    remember = false;
  }
  if(cavalo!=""&&cpf!=null&&cavalo!="null"){
    rememberEquip = true;
  }else{
    rememberEquip = false;
  }
  await Firebase.initializeApp();
  runApp(MyApp(cpf, senha, remember, cavalo, carreta1, carreta2, carreta3, rememberEquip));


}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp(cpf, senha, remember, cavalo, carreta1, carreta2, carreta3, rememberEquip){
    this.cpf = cpf;
    this.senha = senha;
    this.remember = remember;
    this.cavalo = cavalo;
    this.carreta1 = carreta1;
    this.carreta2 = carreta2;
    this.carreta3 = carreta3;
    this.rememberEquip = rememberEquip;
  }
  var cpf;
  var senha;
  var remember;
  var rememberEquip;
  var cavalo;
  var carreta1;
  var carreta2;
  var carreta3;
  @override
  Widget build(BuildContext context) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return MultiProvider(
      providers: [
        Provider<LoginStore>(create:(_)=> LoginStore(cpf, senha, remember),),
        Provider<Cadastro1Store>(create:(_)=> Cadastro1Store(cavalo, carreta1, carreta2, carreta3, rememberEquip),),
        Provider<Cadastro2Store>(create:(_)=> Cadastro2Store(),),
        Provider<Cadastro3Store>(create:(_)=> Cadastro3Store(),),
        Provider<HomeStore>(create:(_)=> HomeStore(),),
        Provider<BaseStore>(create:(_)=> BaseStore(),),
        Provider<ChecklistItemStore>(create:(_)=> ChecklistItemStore(),),
        Provider<ChecklistBaseStore>(create:(_)=>ChecklistBaseStore(),),
        Provider<AbastecimentoBaseStore>(create: (_)=>AbastecimentoBaseStore(),)
      ],
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [const Locale('pt', 'BR')],
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