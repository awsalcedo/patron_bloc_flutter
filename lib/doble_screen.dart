
import 'package:bloc_patron/src/bloc/DoubleBloc.dart';
import 'package:flutter/material.dart';

class DoubleScreen extends StatefulWidget {
  @override
  _DoubleScreenState createState() => _DoubleScreenState();
}

class _DoubleScreenState extends State<DoubleScreen> {
  
  DoubleBloc _doubleBloc = DoubleBloc();  

  @override
  void initState() {
    _doubleBloc.userEnviaEventos.add(FetchEvent());
    super.initState();
  }

  @override
  void dispose() {
    _doubleBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
        title: Text('Double'),
      ),
      body: Center(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Now counter is: ',
            ),
            //Modificar la vista para que se redibuje con el nuevo valor del contador, se lo hace mediante
            //un StreamBuilder
            StreamBuilder<int>(
              stream: _doubleBloc.counterStream, 
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
              _doubleBloc.userEnviaEventos.add(DoubleEvent());
            },
            tooltip: 'Increment',
            child: Icon(Icons.trending_up),
          ),
          SizedBox(width: 8.0,),
          FloatingActionButton(
            heroTag: "Button2",
            onPressed: () {
              _doubleBloc.userEnviaEventos.add(ClearEvent());
            },
            tooltip: 'Clear',
            child: Icon(Icons.clear),
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
