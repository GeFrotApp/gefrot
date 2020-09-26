import 'package:mobx/mobx.dart';

part 'checklist_base_store.g.dart';

class ChecklistBaseStore = _ChecklistBaseStore with _$ChecklistBaseStore;

abstract class _ChecklistBaseStore with Store{

  @observable
  var select = false;

  @observable
  int index = 0;

  @action
  void setIndex(value) => index = value;

  @action
  void turnSelect() => select = !select;
}