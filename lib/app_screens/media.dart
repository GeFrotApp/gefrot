import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/app_modules/abastecimento_module/abastecimento_base.dart';
import 'package:todomobx/app_screens/warnings.dart';
import 'package:todomobx/stores/base_store.dart';
import 'package:todomobx/stores/home_store.dart';
import 'package:todomobx/widgets/base_top.dart';

import 'home.dart';

class Media extends StatefulWidget {
  @override
  _MediaState createState() => _MediaState();
}

class _MediaState extends State<Media> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 230, 230, 230),
        child: SafeArea(
            child: Column(
          children: [
            BaseTop(),
            Container(
              padding: EdgeInsets.only(left: 5),
              height: MediaQuery.of(context).size.height*0.07,
              color: Colors.white,
              child: Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.06,
                    width: MediaQuery.of(context).size.height*0.06,
                    decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),border: Border.all(color: Color.fromARGB(255, 140, 140, 140))),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: Color.fromARGB(255, 170, 170, 170),),
                      onPressed: (){
                        Navigator.of(context).pop();
                      }
                    ),
                  ),
                  Text("  Médias", style: TextStyle(fontWeight: FontWeight.bold, fontSize:MediaQuery.of(context).size.height*0.025, color: Color.fromARGB(255,100,100,100)),),
                  Icon(
                    Icons.graphic_eq,
                    size: MediaQuery.of(context).size.height*0.035,
                    color: Color.fromARGB(255, 254, 182, 241),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                Container(
                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01),
                  height: MediaQuery.of(context).size.height*0.15,
                  width: MediaQuery.of(context).size.width*0.485,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15),bottomLeft: Radius.circular(15))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text("Média atual"),
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1, top: 5),
                      ),
                      Container(child: Text("2,311", style: TextStyle(fontSize: 50, color: Color.fromARGB(255, 255, 145, 145)), ),
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),
                      ),

                      Container(
                        child: Text("Km/L"),
                        margin: EdgeInsets.only(bottom: 1.5, left: MediaQuery.of(context).size.width*0.36),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),
                  height: MediaQuery.of(context).size.height*0.15,
                  width: MediaQuery.of(context).size.width*0.485,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(15),bottomRight: Radius.circular(15))
                  ),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text("Média Proposta"),
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1, top: 5),
                    ),
                    Container(child: Text("2,311", style: TextStyle(fontSize: 50, color: Color.fromARGB(255, 191, 191, 191)), ),
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),
                    ),

                    Container(
                      child: Text("Km/L"),
                      margin: EdgeInsets.only(bottom: 1.5, left: MediaQuery.of(context).size.width*0.36),
                    )
                  ],
                ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(
              child:Container(
                margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                width: MediaQuery.of(context).size.width*0.98,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: (
                          Text("Histórico", style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 137, 202, 204), fontWeight: FontWeight.bold),)
                      ),
                    ),
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                      color: Color.fromARGB(255, 230, 230, 230),
                    )
                  ],
                )
                
              )
            )





          ],
        )),
      ),
    );
  }
}
