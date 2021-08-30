import "dart:ui";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:todomobx/stores/base_store.dart";
import "package:todomobx/widgets/base_top.dart";

class Media extends StatefulWidget {
  @override
  Media(proposedAverage, currentAverage) {
    this.proposedAverage = proposedAverage;
    this.currentAverage = currentAverage;
  }

  var proposedAverage;
  var currentAverage;

  _MediaState createState() => _MediaState(proposedAverage, currentAverage);
}

class _MediaState extends State<Media> {
  _MediaState(proposedAverage, currentAverage) {
    this.proposedAverage = proposedAverage;
    this.currentAverage = currentAverage;
  }

  var proposedAverage;
  var currentAverage;

  late BaseStore baseStore;
  var hora = new DateTime.now().hour;

  Future getMedias()async{
    Map<String,dynamic> listaMedias = {};
    Map<String,dynamic> amountAcumulator = {};
    Map<String,dynamic> distanceAcumulator = {};
    Map<String,dynamic> tempAmountAcumulator = {};
    Map<String,dynamic> tempDistanceAcumulator = {};
    Map<String,dynamic> proposedAverages = {};
    String licensePlate;
    QuerySnapshot<Map<String,dynamic>> supplies = (await FirebaseFirestore.instance
        .collection("Companies")
        .doc(baseStore.cnpj)
        .collection("Supplies")
        .where("driverCPF", isEqualTo: baseStore.cpf)
        .get());
    for(var supply in supplies.docs){
      licensePlate = supply["licensePlate"];
      if(!amountAcumulator.containsKey(licensePlate)){
        amountAcumulator[licensePlate] = 0.0;
      }
      if(!distanceAcumulator.containsKey(licensePlate)){
        distanceAcumulator[licensePlate] = 0.0;
      }
      if(!tempAmountAcumulator.containsKey(licensePlate)){
        tempAmountAcumulator[licensePlate] = 0.0;
      }
      if(!tempDistanceAcumulator.containsKey(licensePlate)){
        tempDistanceAcumulator[licensePlate] = 0.0;
      }
      if(!proposedAverages.containsKey(licensePlate.toString())){
        var average = (await FirebaseFirestore.instance
            .collection("Companies")
            .doc(baseStore.cnpj)
            .collection("Horses")
            .doc(licensePlate)
            .get());
        proposedAverages[licensePlate] = average["proposedAverage"];
      }
      if(!supply["first"]&&supply['fullTank']){
        var tempAverage = ((supply['odometerNew']-supply['odometerOld']+tempDistanceAcumulator[licensePlate])/(supply['amount']+tempAmountAcumulator[licensePlate]));
        if(tempAverage > (proposedAverages[licensePlate]+1) || tempAverage < (proposedAverages[licensePlate] - 1.5)){
          tempAmountAcumulator[supply["licensePlate"]] = 0.0;
          tempDistanceAcumulator[supply["licensePlate"]] = 0.0;
        }else{
          amountAcumulator[licensePlate] += (supply['amount']+tempAmountAcumulator[licensePlate]);
          distanceAcumulator[licensePlate] += (supply['odometerNew']-supply['odometerOld']+tempDistanceAcumulator[licensePlate]);
          tempAmountAcumulator[licensePlate] = 0.0;
          tempDistanceAcumulator[licensePlate] = 0.0;
        }

      }else if(!supply['first']){
        tempAmountAcumulator[licensePlate] += supply['amount'];
        tempDistanceAcumulator[licensePlate] += (supply['odometerNew']-supply['odometerOld']);
      }
    }
    distanceAcumulator.forEach((key, value) {
      listaMedias[key] = {};
      listaMedias[key]["mediaAtual"] = distanceAcumulator[key]/amountAcumulator[key];
      listaMedias[key]["mediaProposta"] = proposedAverages[key];
    });
    print(listaMedias);
    return listaMedias;

  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    baseStore = Provider.of<BaseStore>(context);
  }

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
              height: MediaQuery.of(context).size.height * 0.07,
              color: Colors.white,
              child: Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Color.fromARGB(255, 140, 140, 140))),
                    child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_outlined,
                          color: Color.fromARGB(255, 120, 120, 120),
                          size: MediaQuery.of(context).size.width * 0.05,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ),
                  Text(
                    "  Médias",
                    textScaleFactor: 1,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.height * 0.025, color: Color.fromARGB(255, 100, 100, 100)),
                  ),
                  Icon(
                    Icons.graphic_eq,
                    size: MediaQuery.of(context).size.height * 0.035,
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
                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01),
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.485,
                  decoration:
                      BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text("Média atual"),
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1, top: MediaQuery.of(context).size.width * 0.01),
                      ),
                      Container(
                        child: Text(
                          currentAverage.toStringAsFixed(3).replaceAll(".", ","),
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.122,
                              color: currentAverage < proposedAverage ? Color.fromARGB(255, 255, 145, 145) : Color.fromARGB(255, 137, 202, 204)),
                        ),
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                      ),
                      Container(
                        child: Text(
                          "Km/L",
                          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03),
                          textScaleFactor: 1,
                        ),
                        margin: EdgeInsets.only(bottom: 1, left: MediaQuery.of(context).size.width * 0.36),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.01),
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.485,
                  decoration:
                      BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text("Média Proposta"),
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1, top: 5),
                      ),
                      Container(
                        child: Text(
                          proposedAverage.toStringAsFixed(3).replaceAll(".", ","),
                          textScaleFactor: 1,
                          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.122, color: Color.fromARGB(255, 191, 191, 191)),
                        ),
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                      ),
                      Container(
                        child: Text("Km/L", textScaleFactor: 1, style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03)),
                        margin: EdgeInsets.only(bottom: 1.5, left: MediaQuery.of(context).size.width * 0.36),
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
                child: Container(
                    margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                    width: MediaQuery.of(context).size.width * 0.98,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 20, top: 10),
                          child: (Text(
                            "Histórico",
                            textScaleFactor: 1,
                            style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 137, 202, 204), fontWeight: FontWeight.bold),
                          )),
                        ),
                        Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width,
                          color: Color.fromARGB(255, 230, 230, 230),
                        ),
                        Flexible(
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              color: Colors.white,
                              child: FutureBuilder(
                                future: getMedias(),
                                builder: (BuildContext context, AsyncSnapshot snapshot) {
                                  List<Widget> listMedias = [];
                                  if (!snapshot.hasData) return new Text("Loading...");
                                  snapshot.data!.forEach((key, value) {
                                    listMedias.add(Container(
                                      height: MediaQuery.of(context).size.height * 0.1,
                                      width: MediaQuery.of(context).size.width,
                                      margin:
                                      EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02, right: MediaQuery.of(context).size.width * 0.02),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(width: 1, color: Color.fromARGB(255, 210, 210, 210)),
                                          bottom: BorderSide(width: 1, color: Color.fromARGB(255, 210, 210, 210)),
                                        ),
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Placa",
                                                textScaleFactor: 1,
                                                style: TextStyle(
                                                  color: Color.fromARGB(255, 84, 84, 84),
                                                  fontSize: MediaQuery.of(context).size.width * 0.04,
                                                ),
                                              ),
                                              Text(
                                                key,
                                                textScaleFactor: 1,
                                                style: TextStyle(color: Color.fromARGB(255, 164, 164, 164)),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Sua média",
                                                textScaleFactor: 1,
                                                style: TextStyle(
                                                  color: Color.fromARGB(255, 84, 84, 84),
                                                  fontSize: MediaQuery.of(context).size.width * 0.04,
                                                ),
                                              ),
                                              Text(
                                                value["mediaAtual"].toStringAsFixed(2).replaceAll(".", ","),
                                                textScaleFactor: 1,
                                                style: TextStyle(color: Color.fromARGB(255, 164, 164, 164)),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Média proposta",
                                                textScaleFactor: 1,
                                                style: TextStyle(
                                                  color: Color.fromARGB(255, 84, 84, 84),
                                                  fontSize: MediaQuery.of(context).size.width * 0.04,
                                                ),
                                              ),
                                              Text(
                                                value["mediaProposta"].toStringAsFixed(2).replaceAll(".", ","),
                                                textScaleFactor: 1,
                                                style: TextStyle(color: Color.fromARGB(255, 164, 164, 164)),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ));
                                  });
                                    return ListView(
                                      children: [
                                        ...listMedias
                                      ],
                                    );
                                  })


                              )),

                      ],
                    )))
          ],
        )),
      ),
    );
  }
}
