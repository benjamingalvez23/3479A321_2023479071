import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '2023479071',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 217, 255)),
      ),
      home: const MyHomePage(title: '2023479071'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

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
  late Color _color;  
  
  
  void _incrementCounter() {
    setState(() {
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
  void initState() {
    super.initState();
    _color = _colores[_colorIndex]; 
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        
        title: Text(widget.title),
      ),
      body: Center(
        
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Pixel Art sobre una gri la personalizable'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton (
        onPressed: _setcolor, 
        backgroundColor: _color,
        tooltip: 'color',
        child: const Icon(Icons.color_lens),
      ), 
      persistentFooterButtons: [
        ElevatedButton(onPressed:_decrementoCounter, child: const Icon(Icons.remove),),

        ElevatedButton(onPressed:_restablecer, child: const Icon(Icons.drag_handle)),

        ElevatedButton(onPressed:_incrementCounter, child: const Icon(Icons.add))

        
      ],
    );
  }
}
