import 'package:mobx/mobx.dart';

part 'checklist_item_store.g.dart';

class ChecklistItemStore = _ChecklistItemStore with _$ChecklistItemStore;

abstract class _ChecklistItemStore with Store{

  @observable
  var itemCode;

  @action
  void setItemCode(value)=>itemCode = value;

  @observable
  var itemArray;

  @observable
  var selectionArray;

  @action
  void setSelection(index, value)=>selectionArray[index]=value;


  @action
  void setArray(value)=>itemArray = value;
}