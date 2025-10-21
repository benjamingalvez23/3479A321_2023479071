import 'package:flutter/material.dart';
import 'dart:io';
import 'package:lab2/pixel_art_screen.dart';
import 'package:lab2/screens/list_creation.dart';
import 'package:lab2/screens/lista_art.dart';
import 'package:lab2/screens/configuration_screen.dart';
import 'package:lab2/services/shared_preferences_service.dart'; 
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:lab2/providers/ConfigurationData.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    var logger = Logger();
    logger.d("Logger is working!");
    
    return ChangeNotifierProvider<ConfigurationData>( 
      create: (context) => ConfigurationData(SharedPreferencesService()),
      child: MaterialApp(
        title: '2023479071',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 0, 217, 255)
          ),
        ),
        home: const MyHomePage(title: '2023479071')
      ),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Card(
          elevation: 10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Última Creación',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Consumer<ConfigurationData>(
                builder: (context, configData, child) {
                  final creations = configData.creations;
                  final lastImagePath = creations.isNotEmpty ? creations.last : null;
                  
                  return Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      border: Border.all(color: Colors.grey[400]!, width: 2),
                    ),
                    child: lastImagePath != null
                        ? ClipRect(
                            child: Image.file(
                              File(lastImagePath),
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.error_outline, size: 48, color: Colors.red),
                                      SizedBox(height: 8),
                                      Text('Error al cargar imagen'),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        : const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.image_not_supported, size: 48, color: Colors.grey),
                                SizedBox(height: 8),
                                Text(
                                  'No hay creaciones aún',
                                  style: TextStyle(fontSize: 16, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () async {
                        await Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => const ListArt())
                        );
                      },
                      child: const Text('Crear'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,  
                          MaterialPageRoute(builder: (context) => const ListCreation())
                        );
                      },
                      child: const Text('Creaciones'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Compartir'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => const PixelArtScreen())
                        );
                      },
                      child: const Text('Pixel Art'),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const ConfigurationScreen())
                    );
                  },
                  icon: const Icon(Icons.settings),
                  label: const Text('Configuración'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}