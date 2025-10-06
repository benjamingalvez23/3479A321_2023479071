import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:lab2/providers/ConfigurationData.dart';

class PixelArtScreen extends StatefulWidget {
  const PixelArtScreen({super.key});
   @override
  State<PixelArtScreen> createState() => _PixelArtScreenState();
}
class _PixelArtScreenState extends State<PixelArtScreen> {
  var logger = Logger();
  int counter = 0;
  int _sizeGrid = 0;

    @override
  void initState() {
    super.initState();
    logger.d("PixelArtScreen initState");

    _sizeGrid = context.read<Configurationdata>().size;
    logger.d("Initial grid size: $_sizeGrid");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    logger.d("PixelArtScreen didChangeDependencies");
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    logger.d("PixelArtScreen setState");
  }

  @override
  void didUpdateWidget(covariant PixelArtScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    logger.d("PixelArtScreen didUpdateWidget");
  }

  @override
  void deactivate() {
    super.deactivate();
    logger.d("PixelArtScreen deactivate");
  }

  @override
  void dispose() {
    super.dispose(); 
    logger.d("PixelArtScreen dispose");
  }

  @override
  void reassemble() {
    super.reassemble();
    logger.d("PixelArtScreen reassemble");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pixel Art'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Pixel Art Screen",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              "Tamaño del grid: $_sizeGrid",
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}