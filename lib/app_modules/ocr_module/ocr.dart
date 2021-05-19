import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/stores/base_store.dart';
import 'package:todomobx/widgets/base_top.dart';

class Ocr extends StatefulWidget {
  @override
  _OcrState createState() => _OcrState();
}

class _OcrState extends State<Ocr> {
  BaseStore baseStore;
  var ocrText = "";
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    var baseStore = Provider.of<BaseStore>(context);
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
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10), border: Border.all(color: Color.fromARGB(255, 140, 140, 140))),
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
                        "  OCR",textScaleFactor: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.height * 0.025,
                            color: Color.fromARGB(255, 100, 100, 100)),
                      ),
                      Icon(
                        Icons.remove_red_eye_outlined,
                        size: MediaQuery.of(context).size.height * 0.035,
                        color: Color.fromARGB(255, 40, 95, 140),

                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(ocrText, style: TextStyle(fontSize: 20),),
                TextButton(onPressed: ()async{
                  // File file = new File((await ImagePicker().getImage(source: ImageSource.camera)).path);
                  // final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(file);
                  // final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
                  // final VisionText visionText = await textRecognizer.processImage(visionImage);
                  // String text = visionText.text;
                  //
                  // for (TextBlock block in visionText.blocks) {
                  //   final Rect boundingBox = block.boundingBox;
                  //   final List<Offset> cornerPoints = block.cornerPoints;
                  //   final String text = block.text;
                  //   final List<RecognizedLanguage> languages = block.recognizedLanguages;
                  //
                  //   for (TextLine line in block.lines) {
                  //     // Same getters as TextBlock
                  //     for (TextElement element in line.elements) {
                  //       print(element.text);
                  //     }
                  //   }
                  // }
                }, child: Text("Ler"))

              ],
            )),
      ),
    );
  }
}
