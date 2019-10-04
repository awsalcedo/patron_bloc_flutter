import 'dart:async';

import 'package:bloc_patron/src/bloc/CounterRepository.dart';

class CounterBase{}
class IncrementCounter extends CounterBase {}
class ClearCounter extends CounterBase {}
class FetchCounter extends CounterBase{}

class CounterBloc{
  //Patrón tiene una entrada que corresponde a los events en el medio el BLoC y la salida son los estados
  //con los cuales se actualizará la interfaz de usuario.

  //Se debe crear un BLoC por cada pantalla.

  CounterRepository repository = CounterRepository();

  //1) Crear los StreamController, método dispose que libera los recursos

  //es la entrada Eventos
  StreamController<CounterBase> _input = StreamController();
  //es la salida Estados en este caso es de tipo entero ya que solo se actualiza un contador
  StreamController<int> _output = StreamController();

  //3) La patalla mande eventos o escuche los resultados
  //Stream que va a escuchar la pantalla
  Stream<int> get counterStream => _output.stream;
  //Usuario nos envíe los eventos
  StreamSink<CounterBase> get enviarEventos => _input.sink;

  //La interfaz StreamController tiene manejo de recursos por lo que se debe liberar dichos recursos
  void dispose(){
    _input.close();
    _output.close();
  }

  //2) Escuchar los eventos que vienen en imput y procesarlos
  CounterBloc() {
    this.repository = repository;
    _input.stream.listen(_eventosHaciaBloc);
  }

  void _eventosHaciaBloc(CounterBase event) {
    if(event is IncrementCounter){
      repository.increment();
    }else if (event is ClearCounter) {
      repository.clear();
    }

    print(repository.get()); //Solo para verificar que se ejecute la lógica
    //Una vez modificado el estado le agrega a la salida, es decir la varible _count se debe enviar 
    //por el _output
    _output.add(repository.get());
  }
}