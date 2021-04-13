import 'package:mobx/mobx.dart';

part 'checklist_item_store.g.dart';

class ChecklistItemStore = _ChecklistItemStore with _$ChecklistItemStore;

abstract class _ChecklistItemStore with Store {


  var model;
  var isEdit;
  var documentId;
  var selection;
  var signatureIsRequired;
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
      inputArray[index][type] = value;
    } else {
      if (inputArray[index] == null) {
        inputArray[index] = ObservableMap();
      }
      inputArray[index].putIfAbsent(type, () => value);
    }
    this.setFormValid();
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
}

