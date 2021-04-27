import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as Path;

part 'checklist_item_store.g.dart';

class ChecklistItemStore = _ChecklistItemStore with _$ChecklistItemStore;

abstract class _ChecklistItemStore with Store {


  var model;
  var isEdit;
  var documentId;
  var selection;
  var signatureIsRequired;
  var arrHead;
  var arrTail;
  @observable
  var online;
  @observable
  var itemCode;
  var note;
  var noteText;
  var equipmentPlateIsRequired;
  var locationIsRequired;
  var isEditable;

  @observable
  var buttonQty;

  @action
  void setItemCode(value) => itemCode = value;

  @observable
  var itemArray;

  @observable
  var selectionArray;

  @observable
  var actionArray;

  @action
  void setSelection(index, value) {
    selectionArray[index] = value;
  }

  @observable
  bool isFormValid = false;

  @observable
  var inputArray = ObservableMap();

  @action
  void setInput(index, value, type) {
    if (inputArray[index] != null && inputArray[index].containsKey(type)) {
      inputArray[index][type].add(value);
    } else {
      if (inputArray[index] == null) {
        inputArray[index] = ObservableMap();
      }
      inputArray[index].putIfAbsent(type, () => [value]);
    }
    this.setFormValid();
    print(inputArray);
  }

  @action
  void setAction(index, value) {
    actionArray[index] = value;
    this.setFormValid();
  }


  @action
  void setArray(value) => itemArray = value;

  @action
  void setFormValid() {
    var check = true;
    if (online) {
      actionArray.forEach((k, v) {
        if (v.contains("note")) {
          if (inputArray[k] == null || inputArray[k]['note'] == null) {
            check = false;
          }
        }
        if (v.contains("picture")) {
          if (inputArray[k] == null || inputArray[k]['picture'] == null) {
            check = false;
          }
        }
      });


    }
    actionArray.forEach((k, v) {
      if (v.contains("picture")) {
        if (inputArray[k] == null || inputArray[k]['picture'] == null) {
          check = false;
        }
      }
    });
    itemArray.forEach((k, v) {
      if (selectionArray[k] == null || selectionArray == null) {
        check = false;
      }
    });
    isFormValid = check;
  }

  Future <void> uploadOfflineChecklists(cnpj) async{
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    Directory checklitsDir = new Directory(appDocumentsDirectory.path+'/docs/checklists');
    if(checklitsDir.existsSync()){
      var checklists = checklitsDir.listSync();
      for(var checklistEntity in checklists){
        var checklistPath = checklistEntity.path;
        File checklist = File(checklistPath);
        var fileContent = await checklist.readAsString();
        var checklistContent = jsonDecode(fileContent);
        checklistContent['date']= Timestamp.fromMillisecondsSinceEpoch(checklistContent['date']);
        for(var v in checklistContent['noteSignature'].entries){
          var foto = File(v.value);
          var storageReference =
          FirebaseStorage.instance.ref().child('signatures/${Path.basename(foto.path)}');
          var uploadTask = await storageReference.putFile(foto);
          checklistContent['noteSignature'][v.key] = await storageReference.getDownloadURL();
        }
        print(checklistContent['requiredSignature']);

        var foto = File(checklistContent['requiredSignature']);
        var storageReference =
        FirebaseStorage.instance.ref().child('signatures/${Path.basename(foto.path)}');
        var uploadTask = await storageReference.putFile(foto);
        checklistContent['requiredSignature'] = await storageReference.getDownloadURL();



        for(var v in checklistContent['selection'].entries){
          print(v.value['actions']['picture']);
          var arrayPhotoFutures = [];
          var arrayUrlFutures = [];
          // Caso esteja online, salva os arquivos no banco de dados. Caso não, salva no JSON o caminho do arquivo.
          if (v.value['actions'] != null && v.value['actions']["picture"] != null) {
            for(var picture in v.value['actions']["picture"]){
              var path;
              var foto = File(picture);
              var storageReference =
              FirebaseStorage.instance.ref().child('checklistPhotos/${Path.basename(foto.path)}');
              var uploadTask = storageReference.putFile(foto);
              arrayPhotoFutures.add(uploadTask);
            }
          }


          arrayUrlFutures=[];
          if (v.value['actions'] != null && v.value['actions']["picture"] != null) {
            var c = 0;
            for(var picture in v.value['actions']["picture"]){
              var path;
              var foto = File(picture);

              var storageReference =
              FirebaseStorage.instance.ref().child('checklistPhotos/${Path.basename(foto.path)}');
              await arrayPhotoFutures[c];
              arrayUrlFutures.add(await storageReference.getDownloadURL());
              c++;
            }
          }
          var pictureArray = [];
          if (v.value['actions'] != null && v.value['actions']["picture"] != null) {
            v.value['actions']["picture"] = [];
            for(var urlFuture in arrayUrlFutures ){
              var path = await urlFuture;
              pictureArray.add(path);
            }

            checklistContent['selection'][v.key]['actions']['picture']=pictureArray;
          }
        }

        final firestore = FirebaseFirestore.instance;

        firestore
            .collection('Companies')
            .doc(cnpj)
            .collection("CheckLists")
            .add(checklistContent);
        await checklistEntity.delete();
      }
    }

  }
}

