import 'package:bloc_patron/src/bloc/CounterBloc.dart';
import 'package:flutter/material.dart';

import 'doble_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //int _counter = 0;
  CounterBloc _bloc = CounterBloc();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          FlatButton(
            child: Icon(Icons.trending_up),
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return DoubleScreen();
                  }
                ),
              ).then((_){
                _bloc.enviarEventos.add(FetchCounter());
              });
            },
          )
        ],
      ),
      body: Center(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            //Modificar la vista para que se redibuje con el nuevo valor del contador, se lo hace mediante
            //un StreamBuilder
            StreamBuilder<int>(
              stream: _bloc.counterStream, 
              initialData: 0, //Un valor por defecto si aún el stream no a emitido un evento 
              builder: (context, snapshot) {
                return Text(
                  '${snapshot.data}',
                  style: Theme.of(context).textTheme.display1,
                );
              }
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: "Button1",
            onPressed: (){
              _bloc.enviarEventos.add(IncrementCounter());
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          SizedBox(width: 8.0,),
          FloatingActionButton(
            heroTag: "Button2",
            onPressed: () {
              _bloc.enviarEventos.add(ClearCounter());
            },
            tooltip: 'Clear',
            child: Icon(Icons.clear),
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
