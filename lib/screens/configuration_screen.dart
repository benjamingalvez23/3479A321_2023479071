import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lab2/providers/ConfigurationData.dart';

class ConfigurationScreen extends StatefulWidget {
  const ConfigurationScreen({super.key});

  @override
  State<ConfigurationScreen> createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {
  final List<int> _sizeOptions = [12, 16, 18, 20, 24];
  final List<String> _colorOptions = ['básica', 'oscura', 'pastel', 'neón'];

  @override
  Widget build(BuildContext context) {
    final config = context.watch<Configurationdata>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Configuración del Pixel Art",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            const Text("Tamaño del Pixel Art:"),
            const SizedBox(height: 10),
            DropdownButtonFormField<int>(
              value: config.size,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: _sizeOptions.map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('$value px'),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  context.read<Configurationdata>().setsize(value);
                }
              },
            ),

            const SizedBox(height: 30),

            const Text("Paleta de colores:"),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: config.colorPalette,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: _colorOptions.map((String palette) {
                return DropdownMenuItem<String>(
                  value: palette,
                  child: Text(palette),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  context.read<Configurationdata>().setcolorPalette(value);
                }
              },
            ),

            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Guardar y volver'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}