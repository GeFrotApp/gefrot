import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import "package:path/path.dart" as Path;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/stores/checklist_item_store.dart';

class EditImages extends StatefulWidget {
  EditImages(index) {
    this.index = index;
  }

  late var index;

  @override
  _EditImagesState createState() => _EditImagesState();
}

class _EditImagesState extends State<EditImages> {
  late ChecklistItemStore checklistItemStore;
  var selectedImage = 0;

  Future<void> SetPicture(index) async {
    await ImagePicker().getImage(source: ImageSource.camera, maxHeight: 600, maxWidth: 800, imageQuality: 75).then((image) async {
      File file = new File(image!.path);
      try {
        var path = await getApplicationDocumentsDirectory();
        await file.rename(path.path + "/" + Path.basename(file.path));
        checklistItemStore.setInput(checklistItemStore.itemArray.keys.elementAt(index), File(path.path + "/" + Path.basename(file.path)), "picture");
      } catch (e) {}
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    checklistItemStore = Provider.of<ChecklistItemStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Observer(
          builder: (contet) => Stack(
            children: [
              Center(child: checklistItemStore.inputArray[checklistItemStore.itemArray.keys.elementAt(widget.index)].containsKey('picture')?Image.file(checklistItemStore.inputArray[checklistItemStore.itemArray.keys.elementAt(widget.index)]["picture"][selectedImage]):Container()),
              Positioned(
                  right: MediaQuery.of(context).size.height * 0.02,
                  child: GestureDetector(
                    onTap: (){
                      if(checklistItemStore.deleteInput(checklistItemStore.itemArray.keys.elementAt(widget.index), selectedImage, "picture")==0){
                        setState(() {

                        });
                        Navigator.of(context).pop();
                      }
                      selectedImage = 0;
                      setState(() {

                      });
                    },
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(100000)),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: MediaQuery.of(context).size.height * 0.05,
                        )),
                  )),
              Positioned(
                  right: MediaQuery.of(context).size.height * 0.1,
                  child: GestureDetector(
                    onTap: ()async{
                      await SetPicture(widget.index);
                      setState(() {

                      });
                      print(1234);
                    },
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(100000)),

                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: MediaQuery.of(context).size.height * 0.05,
                          ),
                        ),
                  )),
              Positioned(
                bottom: MediaQuery.of(context).size.height*0.1,
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.15,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: checklistItemStore.inputArray[checklistItemStore.itemArray.keys.elementAt(widget.index)].containsKey('picture')?checklistItemStore.inputArray[checklistItemStore.itemArray.keys.elementAt(widget.index)]["picture"].length:0,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedImage = index;
                            });
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.15,
                            width: MediaQuery.of(context).size.width * 0.15,
                            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03),
                            color: Colors.grey,
                            child: Center(
                                child: Container(
                                    alignment: Alignment.center,
                                    height: MediaQuery.of(context).size.width * 0.13,
                                    width: MediaQuery.of(context).size.width * 0.13,
                                    child:
                                        Image.file(checklistItemStore.inputArray[checklistItemStore.itemArray.keys.elementAt(widget.index)]["picture"][index]))),
                          ),
                        );
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
