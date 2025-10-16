import 'package:flutter/material.dart';
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
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 0, 217, 255)
          ),
        ),
        debugShowCheckedModeBanner: false,
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
                  'Título',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: 250,
                height: 250,
                color: const Color.fromARGB(255, 8, 225, 8), 
                child: const Center(
                  child: Text('Imágenes.'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
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
                      onPressed: () {
                        Navigator.push(
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