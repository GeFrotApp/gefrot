import 'package:mobx/mobx.dart';

part 'abastecimento_base_store.g.dart';

class AbastecimentoBaseStore = _AbastecimentoBaseStore with _$AbastecimentoBaseStore;

abstract class _AbastecimentoBaseStore with Store{

  @observable
  var select = false;

  @observable
  int index = 0;

  @action
  void setIndex(value) => index = value;

  @action
  void turnSelect() => select = !select;
}