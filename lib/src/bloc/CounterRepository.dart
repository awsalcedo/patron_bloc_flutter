class CounterRepository{
  int _count = 0;

  //Creo un Singleton para poder usar la misma instancia en todos los BLoC's - inicio
  static CounterRepository _instance = CounterRepository._internal();

  CounterRepository._internal();

  factory CounterRepository() {
    return _instance;
  }

  //Creo un Singleton para poder usar la misma instancia en todos los BLoC's - fin

  int get(){
    return _count;
  }

  void increment(){
    _count++;
  }

  void clear(){
    _count = 0;
  }

  void duplicar(){
    _count *= 2;
  }
}