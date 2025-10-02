import 'package:flutter/material.dart';

class ListArt extends StatelessWidget {
  const ListArt({super.key});

  final List<String> pixelArts = const [
    "Pixel Mario",
    "Pixel Pacman",
    "Pixel Fantasma",
    "Pixel Estrella",
    "Pixel Corazón",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pixel Art List'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Center(
            child: Card(
              elevation: 10,
              margin: const EdgeInsets.all(16),
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Lista de pixel art disponibles',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: pixelArts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.image), 
                  title: Text(pixelArts[index]),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Seleccionaste: ${pixelArts[index]}"),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
