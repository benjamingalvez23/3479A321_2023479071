import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class PixelArtScreen extends StatefulWidget {
  const PixelArtScreen({super.key});
   @override
  State<PixelArtScreen> createState() => _PixelArtScreenState();
}
class _PixelArtScreenState extends State<PixelArtScreen> {
  var logger = Logger();

  @override
  void initState() {
    super.initState();
    logger.d("PixelArtScreen initState");
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    logger.d('PixelArtScreen didChangeDependencies');
  }
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    logger.d('PixelArtScreen setState');
  }
  @override
  void didUpdateWidget(covariant PixelArtScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    logger.d('PixelArtScreen didUpdateWidget');
   }
   @override
   void deactivate(){
    super.deactivate();
    logger.d('PixelArtScreen deactivate');
   }
   @override
   void dispose(){
    super.dispose();
    logger.d('PixelArtScreen dispose');
   }
   @override
   void reassemble(){
    super.reassemble();
    logger.d('PixelArtScreen reassemble');
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(title: const Text("Pixel Art"),),
     body: const Center(child: Text("Pixel Art Screen")),
    );
  }
}