import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:lab2/providers/ConfigurationData.dart';
import 'dart:io';
import 'dart:ui' as ui;

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
  
  // ignore: unused_field
  File? _backgroundImage;  
  // ignore: unused_field
  final double _backgroundOpacity = 0.5;  

  bool _showNumbers = true;
  // ignore: unused_field
  final bool _isSaving = false; 
 
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
 
  late List<Color> _cellColors;
 
  @override 
  void initState() { 
    super.initState(); 
    logger.d("PixelArtScreen initialized. Mounted: $mounted"); 
    _sizeGrid = context.read<ConfigurationData>().size;
    
    _cellColors = List<Color>.generate(
      _sizeGrid * _sizeGrid,
      (index) => Colors.transparent,
    );
    
    logger.d("Grid size set to: $_sizeGrid"); 
  } 
 
  @override 
  void didChangeDependencies() { 
    super.didChangeDependencies(); 
    
    final newSize = context.watch<ConfigurationData>().size;
    
    if (newSize != _sizeGrid) {
      final oldColors = _cellColors;
      _cellColors = List<Color>.generate(
        newSize * newSize,
        (index) => Colors.transparent,
      );
      
      final minSize = _sizeGrid < newSize ? _sizeGrid : newSize;
      for (int row = 0; row < minSize; row++) {
        for (int col = 0; col < minSize; col++) {
          final oldIndex = row * _sizeGrid + col;
          final newIndex = row * newSize + col;
          if (oldIndex < oldColors.length) {
            _cellColors[newIndex] = oldColors[oldIndex];
          }
        }
      }
      
      setState(() {
        _sizeGrid = newSize;
      });
    }
    
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

  Future<void> _savePixelArt() async { 
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(
      recorder, 
      Rect.fromLTWH(0, 0, _sizeGrid * 20.0, _sizeGrid * 20.0)
    );

    for (int row = 0; row < _sizeGrid; row++) {
      for (int col = 0; col < _sizeGrid; col++) {
        final color = _cellColors[row * _sizeGrid + col];
        final paint = Paint()..color = color;
        final rect = Rect.fromLTWH(col * 20.0, row * 20.0, 20.0, 20.0);
        canvas.drawRect(rect, paint);
      }
    }

    final picture = recorder.endRecording();
    final image = await picture.toImage(_sizeGrid * 20, _sizeGrid * 20);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final imageBytes = byteData!.buffer.asUint8List();

    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/pixel_art_${DateTime.now().millisecondsSinceEpoch}.png';
    final file = File(filePath);
    await file.writeAsBytes(imageBytes);

    logger.d('Pixel art saved to: $filePath');

    if (mounted) {
      context.read<ConfigurationData>().addCreation(filePath);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pixel art guardado exitosamente!'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );

      Navigator.pop(context, filePath);
    }
  }

  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar( 
        title: const Text('Creation Process'), 
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
                      logger.d('Submit button pressed - Saving pixel art');
                      _savePixelArt(); 
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
                itemCount: _cellColors.length, 
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
                        child: _showNumbers
                            ? Text( 
                                '$index', 
                                style: TextStyle( 
                                  color: _cellColors[index] == Colors.black 
                                      ? Colors.white 
                                      : Colors.black, 
                                ), 
                              )
                            : const SizedBox.shrink(),
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