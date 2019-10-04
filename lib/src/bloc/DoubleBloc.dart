import 'dart:async';

import 'package:bloc_patron/src/bloc/CounterRepository.dart';

class DoubleBase{}
class DoubleEvent extends DoubleBase{}
class ClearEvent extends DoubleBase{}
class FetchEvent extends DoubleBase{}

class DoubleBloc{

  //Usar el Singleton para no colocarlo como parámetro en el contructor de la clase DoubleBloc
  CounterRepository repository = CounterRepository(); 

  //1 Crear los StreamController (input y output) y el método dispose que libera los recursos

  StreamController<DoubleBase> _input = StreamController();
  StreamController<int> _output = StreamController();

  //3 Crear Stream que va a escuchar la pantalla

  Stream<int> get counterStream => _output.stream;
  StreamSink<DoubleBase> get userEnviaEventos => _input.sink;

  void dispose(){
    _input.close();
    _output.close();
  }

  //2 En el constructor de la clase escuchar los eventos que vienen en el input para procesarlos
  DoubleBloc() {
    this.repository = repository;
    _input.stream.listen(_eventosHaciaBloc);
  }


  void _eventosHaciaBloc(DoubleBase event) {
    if(event is DoubleEvent){
      repository.duplicar();
    }else if (event is ClearEvent) {
      repository.clear();
    }
    _output.add(repository.get());
  }
}