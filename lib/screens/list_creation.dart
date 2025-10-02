import 'package:flutter/material.dart';

class ListCreation extends StatelessWidget {
  const ListCreation({super.key});

  final List<String> creations = const [
    "Creación 1: Pixel Mario terminado",
    "Creación 2: Pixel Pacman coloreado",
    "Creación 3: Fantasma personalizado",
    "Creación 4: Estrella brillante",
    "Creación 5: Corazón animado",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Creaciones realizadas"),
        backgroundColor: Colors.orange,
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
                  'Lista de creaciones realizadas',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: creations.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.star, color: Colors.amber), 
                  title: Text(creations[index]),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Seleccionaste: ${creations[index]}")),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Volver al Home"),
            ),
          ),
        ],
      ),
    );
  }
}