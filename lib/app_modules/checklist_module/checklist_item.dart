import 'dart:convert';
import "dart:io";
import "dart:ui";

import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_mobx/flutter_mobx.dart";
import "package:flutter_signature_pad/flutter_signature_pad.dart";
import "package:image_picker/image_picker.dart";
import "package:path/path.dart" as Path;
import "package:path_provider/path_provider.dart";
import "package:provider/provider.dart";
import "package:todomobx/stores/base_store.dart";
import "package:todomobx/stores/cadastro_1_store.dart";
import "package:todomobx/stores/checklist_base_store.dart";
import "package:todomobx/stores/checklist_item_store.dart";
import 'package:todomobx/utils/Logger.dart';
import 'package:todomobx/widgets/aviso.dart';
import 'package:uuid/uuid.dart';

import 'edit_images.dart';

class ChecklistItem extends StatefulWidget {
  @override
  _ChecklistItemState createState() => _ChecklistItemState();
}

class _ChecklistItemState extends State<ChecklistItem> {
  late ChecklistItemStore checklistItemStore;
  late ChecklistBaseStore checklistBaseStore;
  late Cadastro1Store cadastro1Store;
  var image;
  GlobalKey<SignatureState> _signRequired = GlobalKey<SignatureState>();
  List<GlobalKey<SignatureState>> _signQuestions = [];
  late BaseStore baseStore;
  var loading = false;
  TextEditingController observation = new TextEditingController();
  var charCounter = 0;
  var noteSignature = {};
  var requiredSignature = "";
  var isDependencyChangedOnce = false;

  void setPicture(index) async {
    await ImagePicker().pickImage(source: ImageSource.camera, maxHeight: 600, maxWidth: 800, imageQuality: 75).then((image) async {
      File file = new File(image!.path);
      try {
        var path = await getApplicationDocumentsDirectory();
        await file.rename(path.path + "/" + Path.basename(file.path));
        checklistItemStore.setInput(checklistItemStore.itemArray.keys.elementAt(index), File(path.path + "/" + Path.basename(file.path)), "picture");
      } catch (e) {
        baseStore.showMyDialog(context, "Não foi possível armazenar a foto");
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(!isDependencyChangedOnce){
      checklistItemStore = Provider.of<ChecklistItemStore>(context);
      checklistBaseStore = Provider.of<ChecklistBaseStore>(context);
      cadastro1Store = Provider.of<Cadastro1Store>(context);
      baseStore = Provider.of<BaseStore>(context);
      checklistItemStore.online = baseStore.online;
      isDependencyChangedOnce = true;
      if (!checklistItemStore.isEdit) {
        for (var question in checklistItemStore.noteText.values) {
          if (question.values.elementAt(0) == true) {
            _signQuestions.add(GlobalKey<SignatureState>());
          }
          }}
    }

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
        : Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Container(
                    color: Color.fromARGB(255, 230, 230, 230),
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: checklistItemStore.itemArray.length,
                        itemBuilder: (context, index) {
                          var buttonSize;
                          var buttonQty = checklistItemStore.itemArray[checklistItemStore.itemArray.keys.elementAt(index)]["activeButtons"].length;
                          var buttons = checklistItemStore.itemArray[checklistItemStore.itemArray.keys.elementAt(index)]["activeButtons"];
                          switch (buttonQty) {
                            case 1:
                              {
                                buttonSize = 0.96;
                              }
                              break;
                            case 2:
                              {
                                buttonSize = 0.48;
                              }
                              break;

                            case 3:
                              {
                                buttonSize = 0.29;
                              }
                              break;

                            case 4:
                              {
                                buttonSize = 0.21;
                              }
                              break;
                          }
                          return Observer(builder: (_) {
                            return Container(
                              child: Card(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width * 0.01,
                                      right: MediaQuery.of(context).size.width * 0.01,
                                      bottom: checklistItemStore.arrTail
                                              .contains(checklistItemStore.itemArray[checklistItemStore.itemArray.keys.elementAt(index)]["number"])
                                          ? 15
                                          : 0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: checklistItemStore.arrHead
                                                  .contains(checklistItemStore.itemArray[checklistItemStore.itemArray.keys.elementAt(index)]["number"])
                                              ? Radius.circular(15)
                                              : Radius.circular(0),
                                          bottom: checklistItemStore.arrTail
                                                  .contains(checklistItemStore.itemArray[checklistItemStore.itemArray.keys.elementAt(index)]["number"])
                                              ? Radius.circular(15)
                                              : Radius.circular(0))),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      checklistItemStore.arrHead
                                              .contains(checklistItemStore.itemArray[checklistItemStore.itemArray.keys.elementAt(index)]["number"])
                                          ? Container(
                                              margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.02),
                                              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromARGB(255, 137, 202, 204)))),
                                              width: MediaQuery.of(context).size.width * 0.98,
                                              child: Text(
                                                " Grupo: " + checklistItemStore.itemArray[checklistItemStore.itemArray.keys.elementAt(index)]["group"],
                                                style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05, color: Color.fromARGB(255, 137, 202, 204)),
                                              ),
                                            )
                                          : Container(),
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.015),
                                        child: Text(
                                          "  " + checklistItemStore.itemArray[checklistItemStore.itemArray.keys.elementAt(index)]["description"],
                                          textScaleFactor: 1,
                                          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05, color: Color.fromARGB(255, 117, 117, 117)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.025,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Observer(
                                            builder: (_) {
                                              return buttons.contains("green")
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        //define a cor escolhida
                                                        checklistItemStore.setSelection(checklistItemStore.itemArray.keys.elementAt(index), "green");
                                                        //seta as ações desse botão
                                                        //primeiro, o nome da seleção (ex combustível), segundo as ações desse botão
                                                        checklistItemStore.setAction(
                                                            checklistItemStore.itemArray.keys.elementAt(index),
                                                            checklistItemStore.itemArray[checklistItemStore.itemArray.keys.elementAt(index)]["buttons"]
                                                                    [checklistItemStore.selectionArray[checklistItemStore.itemArray.keys.elementAt(index)]]
                                                                ["extern_actions"]);
                                                        checklistItemStore.setFormValid();
                                                      },
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width * buttonSize,
                                                        height: MediaQuery.of(context).size.height * 0.065,
                                                        decoration: BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors.grey.withOpacity(0.5),
                                                                spreadRadius: 2,
                                                                blurRadius: 3,
                                                                offset: Offset(0, 3), // changes position of shadow
                                                              ),
                                                            ],
                                                            color:
                                                                checklistItemStore.selectionArray[checklistItemStore.itemArray.keys.elementAt(index)] == "green"
                                                                    ? Color.fromARGB(255, 120, 210, 80)
                                                                    : Color.fromARGB(255, 204, 204, 204),
                                                            borderRadius: BorderRadius.circular(10)),
                                                        child: Center(
                                                            child: Text(
                                                                checklistItemStore.itemArray[checklistItemStore.itemArray.keys.elementAt(index)]["buttons"]
                                                                        ["green"]["text"]
                                                                    .toUpperCase(),
                                                                textScaleFactor: 1,
                                                                style: TextStyle(color: Colors.white))),
                                                      ),
                                                    )
                                                  : Container();
                                            },
                                          ),
                                          buttons.contains("red")
                                              ? GestureDetector(
                                                  onTap: () {
                                                    checklistItemStore.setSelection(checklistItemStore.itemArray.keys.elementAt(index), "red");
                                                    checklistItemStore.setAction(
                                                        checklistItemStore.itemArray.keys.elementAt(index),
                                                        checklistItemStore.itemArray[checklistItemStore.itemArray.keys.elementAt(index)]["buttons"]
                                                                [checklistItemStore.selectionArray[checklistItemStore.itemArray.keys.elementAt(index)]]
                                                            ["extern_actions"]);
                                                    checklistItemStore.setFormValid();
                                                  },
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * buttonSize,
                                                    height: MediaQuery.of(context).size.height * 0.065,
                                                    decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey.withOpacity(0.5),
                                                            spreadRadius: 2,
                                                            blurRadius: 3,
                                                            offset: Offset(0, 3), // changes position of shadow
                                                          ),
                                                        ],
                                                        color: checklistItemStore.selectionArray[checklistItemStore.itemArray.keys.elementAt(index)] == "red"
                                                            ? Color.fromARGB(255, 244, 98, 98)
                                                            : Color.fromARGB(255, 204, 204, 204),
                                                        borderRadius: BorderRadius.circular(10)),
                                                    child: Center(
                                                        child: Text(
                                                            checklistItemStore.itemArray[checklistItemStore.itemArray.keys.elementAt(index)]["buttons"]["red"]
                                                                    ["text"]
                                                                .toUpperCase(),
                                                            textScaleFactor: 1,
                                                            style: TextStyle(color: Colors.white))),
                                                  ),
                                                )
                                              : Container(),
                                          buttons.contains("orange")
                                              ? GestureDetector(
                                                  onTap: () {
                                                    checklistItemStore.setSelection(checklistItemStore.itemArray.keys.elementAt(index), "orange");
                                                    checklistItemStore.setAction(
                                                        checklistItemStore.itemArray.keys.elementAt(index),
                                                        checklistItemStore.itemArray[checklistItemStore.itemArray.keys.elementAt(index)]["buttons"]
                                                                [checklistItemStore.selectionArray[checklistItemStore.itemArray.keys.elementAt(index)]]
                                                            ["extern_actions"]);
                                                    checklistItemStore.setFormValid();
                                                  },
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * buttonSize,
                                                    height: MediaQuery.of(context).size.height * 0.065,
                                                    decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey.withOpacity(0.5),
                                                            spreadRadius: 2,
                                                            blurRadius: 3,
                                                            offset: Offset(0, 3), // changes position of shadow
                                                          ),
                                                        ],
                                                        color: checklistItemStore.selectionArray[checklistItemStore.itemArray.keys.elementAt(index)] == "orange"
                                                            ? Color.fromARGB(255, 246, 178, 60)
                                                            : Color.fromARGB(255, 204, 204, 204),
                                                        borderRadius: BorderRadius.circular(10)),
                                                    child: Center(
                                                        child: Text(
                                                            checklistItemStore.itemArray[checklistItemStore.itemArray.keys.elementAt(index)]["buttons"]
                                                                    ["orange"]["text"]
                                                                .toUpperCase(),
                                                            textScaleFactor: 1,
                                                            style: TextStyle(color: Colors.white))),
                                                  ),
                                                )
                                              : Container(),
                                          buttons.contains("blue")
                                              ? GestureDetector(
                                                  onTap: () {
                                                    checklistItemStore.setSelection(checklistItemStore.itemArray.keys.elementAt(index), "blue");
                                                    checklistItemStore.setAction(
                                                        checklistItemStore.itemArray.keys.elementAt(index),
                                                        checklistItemStore.itemArray[checklistItemStore.itemArray.keys.elementAt(index)]["buttons"]
                                                                [checklistItemStore.selectionArray[checklistItemStore.itemArray.keys.elementAt(index)]]
                                                            ["extern_actions"]);
                                                    checklistItemStore.setFormValid();
                                                  },
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * buttonSize,
                                                    height: MediaQuery.of(context).size.height * 0.065,
                                                    decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey.withOpacity(0.5),
                                                            spreadRadius: 2,
                                                            blurRadius: 3,
                                                            offset: Offset(0, 3), // changes position of shadow
                                                          ),
                                                        ],
                                                        color: checklistItemStore.selectionArray[checklistItemStore.itemArray.keys.elementAt(index)] == "blue"
                                                            ? Color.fromARGB(255, 137, 202, 204)
                                                            : Color.fromARGB(255, 204, 204, 204),
                                                        borderRadius: BorderRadius.circular(10)),
                                                    child: Center(
                                                        child: Text(
                                                      checklistItemStore.itemArray[checklistItemStore.itemArray.keys.elementAt(index)]["buttons"]["blue"]
                                                              ["text"]
                                                          .toUpperCase(),
                                                      textScaleFactor: 1,
                                                      style: TextStyle(color: Colors.white),
                                                    )),
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(5),
                                        height: 1,
                                        color: Color.fromARGB(255, 220, 220, 220),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.015),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                StateSetter _setState;
                                                charCounter = 0;
                                                observation.text = "";
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                          title: Text(
                                                            checklistItemStore.itemArray[checklistItemStore.itemArray.keys.elementAt(index)]["description"],
                                                            textAlign: TextAlign.center,
                                                          ),
                                                          content: StatefulBuilder(
                                                            builder: (BuildContext context, StateSetter setState) {
                                                              _setState = setState;

                                                              return Material(
                                                                type: MaterialType.card,
                                                                child: Container(
                                                                  height: MediaQuery.of(context).size.height * 0.5,
                                                                  width: MediaQuery.of(context).size.width * 0.9,
                                                                  child: Column(
                                                                    mainAxisSize: MainAxisSize.min,
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      TextField(
                                                                        keyboardType: TextInputType.multiline,
                                                                        maxLines: null,
                                                                        controller: observation,
                                                                        onChanged: (value) {
                                                                          _setState(() {
                                                                            charCounter = value.length;
                                                                          });
                                                                        },
                                                                      ),
                                                                      Row(
                                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(charCounter.toString() + "/300"),
                                                                          GestureDetector(
                                                                              onTap: () {
                                                                                checklistItemStore.setInput(checklistItemStore.itemArray.keys.elementAt(index),
                                                                                    observation.text, "note");
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                              child: Container(
                                                                                height: MediaQuery.of(context).size.width * 0.06,
                                                                                width: MediaQuery.of(context).size.width * 0.3,
                                                                                decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(5),
                                                                                    color: Color.fromARGB(255, 137, 202, 204)),
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    "Inserir observação",
                                                                                    textScaleFactor: 1,
                                                                                    style: TextStyle(
                                                                                        fontSize: MediaQuery.of(context).size.width * 0.03,
                                                                                        color: Colors.white),
                                                                                  ),
                                                                                ),
                                                                              ))
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ));
                                                    });
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.comment,
                                                    color: Color.fromARGB(255, 207, 207, 207),
                                                  ),
                                                  Text(
                                                    "  Inserir observação  ", textScaleFactor: 1,
                                                    //TODO melhorar esta palhaçada, reorganizar operador ternário
                                                    style: TextStyle(
                                                        color: checklistItemStore.actionArray[checklistItemStore.itemArray.keys.elementAt(index)] is List &&
                                                                checklistItemStore.actionArray[checklistItemStore.itemArray.keys.elementAt(index)]
                                                                    .contains("note")
                                                            ? checklistItemStore.inputArray[checklistItemStore.itemArray.keys.elementAt(index)] != null &&
                                                                    checklistItemStore.inputArray[checklistItemStore.itemArray.keys.elementAt(index)]["note"] !=
                                                                        null
                                                                ? Color.fromARGB(255, 137, 202, 204)
                                                                : Color.fromARGB(255, 244, 98, 98)
                                                            : checklistItemStore.inputArray[checklistItemStore.itemArray.keys.elementAt(index)] != null &&
                                                                    checklistItemStore.inputArray[checklistItemStore.itemArray.keys.elementAt(index)]["note"] !=
                                                                        null
                                                                ? Color.fromARGB(255, 137, 202, 204)
                                                                : Color.fromARGB(255, 117, 117, 117),
                                                        fontSize: MediaQuery.of(context).size.width * 0.04),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                checklistItemStore.actionArray[checklistItemStore.itemArray.keys.elementAt(index)] is List &&
                                                        checklistItemStore.actionArray[checklistItemStore.itemArray.keys.elementAt(index)].contains("picture")
                                                    ? checklistItemStore.inputArray[checklistItemStore.itemArray.keys.elementAt(index)] != null &&
                                                            checklistItemStore.inputArray[checklistItemStore.itemArray.keys.elementAt(index)]["picture"] != null
                                                        ? Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditImages(index)))
                                                        : setPicture(index)
                                                    : checklistItemStore.inputArray[checklistItemStore.itemArray.keys.elementAt(index)] != null &&
                                                            checklistItemStore.inputArray[checklistItemStore.itemArray.keys.elementAt(index)]["picture"] != null
                                                        ? Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditImages(index)))
                                                        : setPicture(index);
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.camera_alt,
                                                    color: Color.fromARGB(255, 207, 207, 207),
                                                  ),
                                                  Text(
                                                    " Inserir midia  ",
                                                    textScaleFactor: 1,
                                                    style: TextStyle(
                                                        color: checklistItemStore.actionArray[checklistItemStore.itemArray.keys.elementAt(index)] is List &&
                                                                checklistItemStore.actionArray[checklistItemStore.itemArray.keys.elementAt(index)]
                                                                    .contains("picture")
                                                            ? checklistItemStore.inputArray[checklistItemStore.itemArray.keys.elementAt(index)] != null &&
                                                                    checklistItemStore.inputArray[checklistItemStore.itemArray.keys.elementAt(index)]
                                                                            ["picture"] !=
                                                                        null
                                                                ? Color.fromARGB(255, 137, 202, 204)
                                                                : Color.fromARGB(255, 244, 98, 98)
                                                            : checklistItemStore.inputArray[checklistItemStore.itemArray.keys.elementAt(index)] != null &&
                                                                    checklistItemStore.inputArray[checklistItemStore.itemArray.keys.elementAt(index)]
                                                                            ["picture"] !=
                                                                        null
                                                                ? Color.fromARGB(255, 137, 202, 204)
                                                                : Color.fromARGB(255, 117, 117, 117),
                                                        fontSize: MediaQuery.of(context).size.width * 0.04),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      !checklistItemStore.arrTail
                                              .contains(checklistItemStore.itemArray[checklistItemStore.itemArray.keys.elementAt(index)]["number"])
                                          ? Container(
                                              height: 1,
                                              color: Colors.black,
                                            )
                                          : Container(),
                                    ],
                                  )),
                            );
                          });
                        }),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: Observer(
                      builder: (_) {
                        return RaisedButton(
                          onPressed: checklistItemStore.isFormValid && checklistItemStore.isEditable
                              ? () async {
                                  try {
                                    setState(() {
                                      loading = true;
                                    });
                                    var isOnline;
                                    try {
                                      final result = await InternetAddress.lookup("example.com");
                                      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                                        isOnline = true;
                                      }
                                    } catch (e) {
                                      isOnline = false;
                                    }
                                    var position;
                                    var latitude;
                                    var longitude;
                                    try {
                                      position = checklistItemStore.locationIsRequired ? await baseStore.determinePosition() : null;
                                      latitude = checklistItemStore.locationIsRequired ? position.latitude : null;
                                      longitude = checklistItemStore.locationIsRequired ? position.longitude : null;
                                    } catch (error) {
                                      await baseStore.showMyDialog(context, "Nesse checklist é obrigatório que a localização esteja ligada!!");
                                      return;
                                    }
                                    //UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
                                    //Se for uma edição (isEdit) impede que a assinatura seja modificada
                                    if (!checklistItemStore.isEdit) {
                                      var signCounter = 0;
                                      for (var question in checklistItemStore.noteText.values) {
                                        if (question.values.elementAt(0) == true) {
                                          await showDialog<void>(
                                            context: context,
                                            barrierDismissible: false, // user must tap button!
                                            builder: (BuildContext context) {
                                              return RotatedBox(
                                                  quarterTurns: 1,
                                                  child: AlertDialog(
                                                    title: Text(
                                                      checklistItemStore.note[question.keys.elementAt(0)],
                                                      textScaleFactor: 1,
                                                    ),
                                                    content: SingleChildScrollView(
                                                        child: Container(
                                                      height: MediaQuery.of(context).size.width * 0.5,
                                                      width: MediaQuery.of(context).size.height,
                                                      decoration: BoxDecoration(color: Colors.transparent, border: Border.all(color: Colors.grey)),
                                                      child: Signature(
                                                        color: Colors.black,
                                                        // Color of the drawing path
                                                        strokeWidth: 5.0,
                                                        // with
                                                        backgroundPainter: null,
                                                        // Additional custom painter to draw stuff like watermark
                                                        // Callback called on user pan drawing
                                                        key:
                                                        _signQuestions[signCounter], // key that allow you to provide a GlobalKey that"ll let you retrieve the image once user has signed
                                                      ),
                                                    )),
                                                    actions: <Widget>[
                                                      FlatButton(
                                                        child: Text(
                                                          "Limpar",
                                                          textScaleFactor: 1,
                                                        ),
                                                        onPressed: () {
                                                          final sign = _signQuestions[signCounter].currentState;
                                                          sign!.clear();
                                                        },
                                                      ),
                                                      FlatButton(
                                                        child: Text(
                                                          "Pronto",
                                                          textScaleFactor: 1,
                                                        ),
                                                        onPressed: () async {
                                                          final sign = _signQuestions[signCounter].currentState;
                                                          signCounter++;
                                                          image = await sign!.getData();
                                                          sign.clear();
                                                          Navigator.of(context).pop();
                                                        },
                                                      ),
                                                    ],
                                                  ));
                                            },
                                          );
                                          try {
                                            var data = await image.toByteData(format: ImageByteFormat.png);
                                            final file = File("${(await getTemporaryDirectory()).path}/" + Uuid().v4().toString() + ".png");
                                            await file.writeAsBytes(data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
                                            var path = await getApplicationDocumentsDirectory();
                                            await file.rename(path.path + "/" + Path.basename(file.path));
                                            noteSignature[question.keys.elementAt(0)] = path.path + "/" + Path.basename(file.path);
                                          } catch (e) {
                                            await baseStore.showMyDialog(context, "Não foi possível armazenar a assinatura");
                                            setState(() {
                                              loading = false;
                                            });
                                            return;
                                          }

                                          // }
                                        }
                                      }
                                      if (checklistItemStore.signatureIsRequired == true || checklistItemStore.signatureIsRequired == null) {
                                        await showDialog<void>(
                                          context: context,
                                          barrierDismissible: false, // user must tap button!
                                          builder: (BuildContext context) {
                                            return RotatedBox(
                                                quarterTurns: 1,
                                                child: AlertDialog(
                                                  title: Text(
                                                    baseStore.nome,
                                                    textScaleFactor: 1,
                                                  ),
                                                  content: SingleChildScrollView(
                                                      child: Container(
                                                    height: MediaQuery.of(context).size.width * 0.5,
                                                    width: MediaQuery.of(context).size.height,
                                                    decoration: BoxDecoration(color: Colors.transparent, border: Border.all(color: Colors.grey)),
                                                    child: Signature(
                                                      color: Colors.black,
                                                      // Color of the drawing path
                                                      strokeWidth: 5.0,
                                                      // with
                                                      backgroundPainter: null,

                                                      // Callback called on user pan drawing
                                                      key:
                                                          _signRequired, // key that allow you to provide a GlobalKey that"ll let you retrieve the image once user has signed
                                                    ),
                                                  )),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                      child: Text(
                                                        "Limpar",
                                                        textScaleFactor: 1,
                                                      ),
                                                      onPressed: () {
                                                        final sign = _signRequired.currentState;
                                                        sign!.clear();
                                                      },
                                                    ),
                                                    FlatButton(
                                                      child: Text(
                                                        "Pronto",
                                                        textScaleFactor: 1,
                                                      ),
                                                      onPressed: () async {
                                                        final sign = _signRequired.currentState;
                                                        image = await sign!.getData();
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                  ],
                                                ));
                                          },
                                        );

                                        // if (isOnline) {
                                        //   setState(() {
                                        //     loading = !loading;
                                        //   });
                                        //   var storageReference =
                                        //   FirebaseStorage.instance.ref().child("signatures/${Path.basename(file.path)}");
                                        //   var uploadTask = storageReference.putFile(file);
                                        //   await uploadTask;
                                        //   requiredSignature = await storageReference.getDownloadURL();
                                        // } else {
                                        try {
                                          var data = await image.toByteData(format: ImageByteFormat.png);
                                          final file = File("${(await getTemporaryDirectory()).path}/" + Uuid().v4().toString() + ".png");
                                          await file.writeAsBytes(data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
                                          var path = await getApplicationDocumentsDirectory();
                                          await file.rename(path.path + "/" + Path.basename(file.path));
                                          requiredSignature = path.path + "/" + Path.basename(file.path);
                                        } catch (e) {
                                          await baseStore.showMyDialog(context, "Erro ao coletar assinatura");
                                          setState(() {
                                            loading = false;
                                          });
                                          return;
                                        }

                                        // }
                                        // setState(() {
                                        //   loading = !loading;
                                        // });
                                      }
                                    }

                                    setState(() {
                                      loading = true;
                                    });

                                    var form = Map();

                                    for (var k in checklistItemStore.itemArray.keys) {
                                      if (checklistItemStore.inputArray[k] != null && checklistItemStore.inputArray[k]["picture"] != null) {
                                        var arrPicturePaths = [];
                                        for (var picture in checklistItemStore.inputArray[k]["picture"]) {
                                          arrPicturePaths.add(picture.path);
                                        }
                                        checklistItemStore.inputArray[k]["picture"] = arrPicturePaths;
                                      }
                                      form.putIfAbsent(
                                          k, () => {"actions": checklistItemStore.inputArray[k], "selectedButton": checklistItemStore.selectionArray[k]});
                                    }
                                    // }

                                    final firestore = FirebaseFirestore.instance;
                                    var formToSave = {
                                      "driverCPF": baseStore.cpf,
                                      "driverName": baseStore.nome,
                                      "selection": form,
                                      "modelName": checklistItemStore.model["name"],
                                      "horse": cadastro1Store.placaCavalo,
                                      "latitude": latitude,
                                      "longitude": longitude,
                                      "note": checklistItemStore.note,
                                      "trailers": checklistItemStore.equipmentPlateIsRequired
                                          ? [cadastro1Store.placaCarreta1, cadastro1Store.placaCarreta2, cadastro1Store.placaCarreta3]
                                          : null,
                                      "noteSignature": noteSignature,
                                      "requiredSignature": requiredSignature,
                                      "model": checklistItemStore.model,
                                    };
                                    formToSave["date"] = DateTime.now().millisecondsSinceEpoch;
                                    formToSave["model"]["createDate"] = "";
                                    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();

                                    String appDocumentsPath = appDocumentsDirectory.path + "/docs";

                                    String filePath = "$appDocumentsPath/checklists/" + DateTime.now().toString() + ".txt";
                                    File file = new File(filePath); // 1
                                    file.createSync(recursive: true);
                                    file.writeAsString(jsonEncode(formToSave));
                                    String fileContent = await file.readAsString(); // 2
                                    // }

                                    if (isOnline) {
                                      try {
                                        setState(() {
                                          loading = true;
                                        });
                                        await checklistItemStore.uploadOfflineChecklists(baseStore.cnpj);
                                        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                                          return Aviso(checklistItemStore.documentId != null ? "Checklist atualizado!" : "Checklist registrado!");
                                        }));
                                        await Future.delayed(const Duration(seconds: 2), () => "2");
                                        Navigator.of(context).pop();
                                        setState(() {
                                          loading = false;
                                        });
                                        checklistBaseStore.setIndex(3);
                                      } catch (e) {
                                        loading = false;
                                        await baseStore.showMyDialog(context, "Erro de rede. Os checklists serão salvos na próxima vez em que logar");
                                        checklistBaseStore.setIndex(3);
                                      }
                                    } else {
                                      await baseStore.showMyDialog(context, "Erro de rede. Os checklists serão salvos na próxima vez em que logar");
                                      checklistBaseStore.setIndex(3);
                                    }
                                    setState(() {
                                      loading = false;
                                    });
                                  } catch (e, stacktrace) {
                                    Logger logger = new Logger();
                                    setState(() {
                                      loading = false;
                                    });
                                    var nome = checklistItemStore.model['name'].toString();
                                    logger.firebaseLog(e, stacktrace, data: {
                                      "tela": "checklist",
                                      "motorista": baseStore.cpf,
                                      "cavalo": cadastro1Store.placaCavalo,
                                      "modelo": nome,
                                      "carretas": [cadastro1Store.placaCarreta1, cadastro1Store.placaCarreta2, cadastro1Store.placaCarreta3],
                                    });
                                  }
                                }
                              : () async {
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
                                                    checklistItemStore.isEditable
                                                        ? "Inserir as informações solicitadas (texto em vermelho)"
                                                        : "Não é permitida a edição",
                                                    textScaleFactor: 1,
                                                    style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05),
                                                  ),
                                                )));
                                      });
                                },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                          color: checklistItemStore.isFormValid && checklistItemStore.isEditable
                              ? Color.fromARGB(255, 50, 153, 158)
                              : Color.fromARGB(255, 210, 210, 210),
                          child: Text(checklistItemStore.documentId == null ? "Finalizar Check-list" : "Atualizar Check-list",
                              textScaleFactor: 1, style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.05)),
                        );
                      },
                    ))
              ],
            ),
          );
  }
}
