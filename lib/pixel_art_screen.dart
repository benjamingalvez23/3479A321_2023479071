import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:provider/provider.dart';
import 'package:lab2/providers/ConfigurationData.dart';

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
 
 late final List<Color> _cellColors = List<Color>.generate( 
   _sizeGrid * _sizeGrid, 
   (index) => Colors.transparent, 
 );
  @override 
 void initState() { 
   super.initState(); 
   logger.d("PixelArtScreen initialized. Mounted: $mounted"); 
   _sizeGrid = context.read<ConfigurationData>().size; 
   logger.d("Grid size set to: $_sizeGrid"); 
 } 
 
 @override 
 void didChangeDependencies() { 
   super.didChangeDependencies(); 
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
 
// ignore: unused_element
Future<void> _saveArt() async { 
final recorder = ui.PictureRecorder();
final canvas = Canvas(recorder, Rect.fromLTWH(0, 0, _sizeGrid * 20.0,
_sizeGrid * 20.0));

for (int i = 0; i < _sizeGrid; i++) {
  for (int col = 0; col < _sizeGrid; col++) {
    final color = _cellColors[i * _sizeGrid + col];
    final paint = Paint()..color = color;
    canvas.drawRect(Rect.fromLTWH(col * 20.0, i * 20.0, 20.0, 20.0), paint);
}
}
final picture = recorder.endRecording();
final imagen = await picture.toImage(_sizeGrid * 20, _sizeGrid * 20);
final byteData = await imagen.toByteData(format: ui.ImageByteFormat.png);

final imageBytes = byteData!.buffer.asUint8List();

final directory = await getApplicationDocumentsDirectory();
}


 @override 
 Widget build(BuildContext context) { 
   return Scaffold( 
     appBar: AppBar( 
       title: const Text('Creation Process'), 
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
               SizedBox(width: 8), 
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
                       child: Text( 
                         '$index', 
                         style: TextStyle( 
                           color: _cellColors[index] == Colors.black 
                               ? Colors.white 
                               : Colors.black, 
                         ), 
                       ), 
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
 
  Future getApplicationDocumentsDirectory() async {} 
} 