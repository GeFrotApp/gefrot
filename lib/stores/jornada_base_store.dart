import "package:mobx/mobx.dart";

part "jornada_base_store.g.dart";

class JornadaBaseStore = _JornadaBaseStore with _$JornadaBaseStore;

abstract class _JornadaBaseStore with Store {
  @observable
  var select = false;

  @observable
  int index = 0;

  @action
  void setIndex(value) => index = value;

  @action
  void turnSelect() => select = !select;

  @observable
  var jornada = false;

  @action
  void turnJornada(){
    jornada = !jornada;
  }

}
