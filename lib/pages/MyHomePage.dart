// ignore_for_file: file_names

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final List<Color> _colores = [
    const Color.fromARGB(255, 0, 217, 255), 
    const Color.fromARGB(255, 212, 255, 0), 
    const Color.fromARGB(255, 0, 255, 8),   
  ];
  int _colorIndex = 0; 
  late Color _color =Color.fromARGB(255, 0, 217, 255);  
  @override
  void initState() {
    super.initState();
    _color = _colores[_colorIndex]; 
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
  void _restablecer(){
    setState(() {
      _counter=0;
    });
  }
  void _decrementoCounter(){
    setState(() {

      _counter--;
    });
  }
  void _setcolor() {
    setState(() {
      _colorIndex = (_colorIndex + 1) % _colores.length; 
      _color = _colores[_colorIndex];
    });
  }
  
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    var scaffold2 = Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Pixel Art sobre una gri la personalizable', ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
              children: [
                Image.asset('Pixel-Art-Hot-Pepper-2-1.webp', width: 400, fit: BoxFit.cover,),
              
              
                Image.asset('Pixel-Art-Pizza-2.webp', width: 400, fit: BoxFit.cover,),
              
        
                Image.asset('Pixel-Art-Watermelon-3.webp', width: 400, fit: BoxFit.cover,)
              ],
            ) ,
            )

           
            
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton (
        onPressed: _setcolor, 
        backgroundColor: _color,
        tooltip: 'color',
        child: const Icon(Icons.color_lens),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      persistentFooterButtons: [
        ElevatedButton(onPressed:_decrementoCounter, child: const Icon(Icons.remove),),

        ElevatedButton(onPressed:_restablecer, child: const Icon(Icons.drag_handle)),

        ElevatedButton(onPressed:_incrementCounter, child: const Icon(Icons.add))

        
      ],
    );
    var scaffold = scaffold2;
    return scaffold;
  }
}
