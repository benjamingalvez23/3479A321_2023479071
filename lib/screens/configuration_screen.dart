import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lab2/providers/ConfigurationData.dart';

class ConfigurationScreen extends StatefulWidget {
  const ConfigurationScreen({super.key});

  @override
  State<ConfigurationScreen> createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {
  
  final List<int> _sizeOptions = [8, 12, 16, 18, 20, 24, 32];

  final List<String> _colorOptions = ['basica', 'oscura', 'pastel', 'neon', 'retro'];

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
              "Configuración General",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            const Text(
              "Tamaño del Pixel Art:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),

            DropdownButtonFormField<int>(
              value: config.size,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Selecciona el tamaño',
                prefixIcon: Icon(Icons.grid_on),
              ),
              items: _sizeOptions.map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('${value}x$value'),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  context.read<Configurationdata>().setsize(value);
                }
              },
            ),

            const SizedBox(height: 30),

            // Configuración de paleta de colores
            const Text(
              "Paleta de Colores:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: config.colorPalette,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Selecciona la paleta',
                prefixIcon: Icon(Icons.palette),
              ),
              items: _colorOptions.map((String palette) {
                return DropdownMenuItem<String>(
                  value: palette,
                  child: Text(_getPaletteName(palette)),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  context.read<Configurationdata>().setcolorPalette(value);
                }
              },
            ),

            const SizedBox(height: 40),

            Card(
              color: Colors.blue.shade50,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Los cambios se aplican automáticamente',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.check),
                label: const Text('Guardar y Volver'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getPaletteName(String palette) {
    switch (palette) {
      case 'basica':
        return 'Básica';
      case 'oscura':
        return 'Oscura';
      case 'pastel':
        return 'Pastel';
      case 'neon':
        return 'Neón';
      case 'retro':
        return 'Retro';
      default:
        return palette;
    }
  }
}