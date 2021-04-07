
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:todomobx/login_screens/login_screen.dart';
import 'package:todomobx/stores/abastecimento_base_store.dart';
import 'package:todomobx/stores/base_store.dart';
import 'package:todomobx/stores/cadastro_1_store.dart';
import 'package:todomobx/stores/cadastro_2_store.dart';
import 'package:todomobx/stores/cadastro_3_store.dart';
import 'package:todomobx/stores/checklist_base_store.dart';
import 'package:todomobx/stores/checklist_item_store.dart';
import 'package:todomobx/stores/home_store.dart';
import 'package:todomobx/stores/jornada_base_store.dart';
import 'package:todomobx/stores/jornada_store.dart';
import 'package:todomobx/stores/login_store.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  InAppUpdate.performImmediateUpdate().catchError((onError){print(onError);});
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
  runApp(RestartWidget(child:MyApp(cpf, senha, remember, cavalo, carreta1, carreta2, carreta3, rememberEquip)));
  //runApp(DevicePreview(builder: (context)=>MyApp(cpf, senha, remember, cavalo, carreta1, carreta2, carreta3, rememberEquip)));


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
        Provider<AbastecimentoBaseStore>(create: (_)=>AbastecimentoBaseStore(),),
        Provider<JornadaBaseStore>(create: (_)=>JornadaBaseStore(),),
        Provider<JornadaStore>(create: (_)=>JornadaStore(),)
      ],
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        // builder: DevicePreview.appBuilder,
        // locale: DevicePreview.locale(context),
        supportedLocales: [const Locale('pt', 'BR')],
        title: 'GEFROT',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 108, 190, 193),
          cursorColor: Color.fromARGB(255, 108, 190, 193),
          scaffoldBackgroundColor: Color.fromARGB(255, 108, 190, 193),
        ),
        home: _introScreen(),
      ),
    );
  }
}
Widget _introScreen() {
  return Stack(
    children: <Widget>[
      SplashScreen(
        seconds: 2,

        navigateAfterSeconds: LoginScreen(),
        loaderColor: Color.fromARGB(255, 137, 202, 204),
      ),
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splashscreen.png"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    ],
  );
}

//Classe utilizada para reiniciar o app (logout)
class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
String capitalize(String s) => s[0].toUpperCase() + s.substring(1);