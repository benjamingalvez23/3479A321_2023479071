import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:lab2/providers/ConfigurationData.dart'; // Asegúrate que esta ruta es correcta

class PixelArtScreen extends StatefulWidget { 
  const PixelArtScreen({super.key}); 
  
  @override 
  // ignore: library_private_types_in_public_api
  _PixelArtScreenState createState() => _PixelArtScreenState(); 
} 
 
class _PixelArtScreenState extends State<PixelArtScreen> { 
  Logger logger = Logger(); 
  int _sizeGrid = 16; 
  Color _selectedColor = Colors.black; 
  
  // 1. Variable de estado para controlar la visibilidad de los números
  bool _showNumbers = true; 
 
  final List<Color> _listColors = [ 
    Colors.black, 
    Colors.white, 
    Colors.red, 
    Colors.orange, 
    Colors.yellow, 
    Colors.green, 
    Colors.blue, 
    Colors.indigo, 
    Colors.purple, 
    Colors.brown, 
    Colors.grey, 
    Colors.pink, 
  ]; 
 
  // Nota: Si el tamaño de la grilla (_sizeGrid) cambia en didChangeDependencies,
  // es posible que necesites reinicializar _cellColors en ese momento.
  // Por ahora, usamos el inicializador 'late final' del código base.
  late final List<Color> _cellColors = List<Color>.generate( 
    _sizeGrid * _sizeGrid, 
    (index) => Colors.transparent, 
  );
 
  @override 
  void initState() { 
    super.initState(); 
    logger.d("PixelArtScreen initialized. Mounted: $mounted"); 
    // Obtener el tamaño inicial desde el provider
    _sizeGrid = context.read<ConfigurationData>().size; 
    logger.d("Grid size set to: $_sizeGrid"); 
  } 
 
  @override 
  void didChangeDependencies() { 
    super.didChangeDependencies(); 
    // Observar cambios en el provider
    _sizeGrid = context.watch<ConfigurationData>().size; 
    logger.d("Dependencies changed in PixelArtScreen. Mounted: $mounted"); 
  } 
  
  @override 
  void didUpdateWidget(covariant PixelArtScreen oldWidget) { 
    super.didUpdateWidget(oldWidget); 
    logger.d("PixelArtScreen widget updated. Mounted: $mounted"); 
  } 
  
  @override 
  void deactivate() { 
    super.deactivate(); 
    logger.d("PixelArtScreen deactivated. Mounted: $mounted"); 
  } 
  
  @override 
  void dispose() { 
    super.dispose(); 
    logger.d("PixelArtScreen disposed. Mounted: $mounted"); 
  } 
  
  @override 
  void reassemble() { 
    super.reassemble(); 
    logger.d("PixelArtScreen reassembled. Mounted: $mounted"); 
  } 
  
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar( 
        title: const Text('Creation Process'), 
        // 2. Incluir el botón en el AppBar para alternar la visibilidad
        actions: [
          IconButton(
            icon: Icon(_showNumbers ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _showNumbers = !_showNumbers;
                logger.d('Toggle numbers visibility: $_showNumbers'); 
              });
            },
          ),
        ],
      ), 
      body: SafeArea( 
        child: Column( 
          children: [ 
            Padding( 
              padding: const EdgeInsets.all(8.0), 
              child: Row( 
                mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                children: [ 
                Text('$_sizeGrid x $_sizeGrid'), 
                const SizedBox(width: 8), 
                Expanded( 
                  child: Padding( 
                  padding: const EdgeInsets.symmetric(horizontal: 8.0), 
                  child: TextField( 
                    decoration: const InputDecoration( 
                    hintText: 'Enter title', 
                    border: OutlineInputBorder(), 
                    ), 
                    onSubmitted: (value) { 
                    logger.d('Title entered: $value'); 
                    }, 
                  ), 
                  ), 
                ), 
                ElevatedButton( 
                  onPressed: () { 
                  logger.d('Button pressed'); 
                  }, 
                  child: const Text('Submit'), 
                ), 
                ], 
              ), 
            ), 
            Expanded( 
              child: GridView.builder( 
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount( 
                  crossAxisCount: _sizeGrid, 
                ), 
                itemCount: _sizeGrid * _sizeGrid, 
                itemBuilder: (context, index) { 
                  return GestureDetector( 
                    onTap: () { 
                      setState(() { 
                        _cellColors[index] = _selectedColor; 
                      }); 
                    }, 
                    child: Container( 
                      margin: const EdgeInsets.all(1),
                      color: _cellColors[index], 
                      child: Center( 
                        // 3. Aplicar la lógica de visibilidad al widget Text
                        child: _showNumbers
                            ? Text( 
                                '$index', 
                                style: TextStyle( 
                                  color: _cellColors[index] == Colors.black 
                                      ? Colors.white 
                                      : Colors.black, 
                                ), 
                              )
                            : const SizedBox.shrink(), // Ocultar si _showNumbers es false
                      ), 
                    ), 
                  ); 
                }, 
              ), 
            ), 
            Container( 
              padding: const EdgeInsets.symmetric(vertical: 8), 
              color: Colors.grey[200], 
              child: SingleChildScrollView( 
                scrollDirection: Axis.horizontal, 
                child: Row( 
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: _listColors.map((color) { 
                    final bool isSelected = color == _selectedColor; 
                    return GestureDetector( 
                      onTap: () { 
                        setState(() { 
                          _selectedColor = color; 
                        }); 
                      }, 
                      child: AnimatedContainer( 
                        duration: const Duration(milliseconds: 200), 
                        margin: const EdgeInsets.symmetric(horizontal: 4), 
                        padding: EdgeInsets.all(isSelected ? 12 : 8), 
                        decoration: BoxDecoration( 
                          color: color, 
                          shape: BoxShape.circle, 
                          border: isSelected 
                              ? Border.all(color: Colors.black, width: 2) 
                              : null, 
                        ), 
                        width: isSelected ? 36 : 28, 
                        height: isSelected ? 36 : 28, 
                      ), 
                    ); 
                  }).toList(), 
                ), 
              ),
            ), 
          ], 
        ), 
      ), 
    ); 
  } 
}