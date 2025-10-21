import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lab2/providers/ConfigurationData.dart';
import 'dart:io';
import 'package:logger/logger.dart';

class ListCreation extends StatefulWidget {
  const ListCreation({super.key});

  @override
  State<ListCreation> createState() => _ListCreationState();
}

class _ListCreationState extends State<ListCreation> {
  Logger logger = Logger();
  List<String> creations = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCreations();
  }

  // Cargar las creaciones desde el provider
  Future<void> _loadCreations() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Obtener las creaciones del provider
      final configData = context.read<ConfigurationData>();
      final loadedCreations = configData.creations;

      // Filtrar solo los archivos que existen
      List<String> existingFiles = [];
      for (String filePath in loadedCreations) {
        final file = File(filePath);
        if (await file.exists()) {
          existingFiles.add(filePath);
        } else {
          logger.w('File not found: $filePath');
        }
      }

      setState(() {
        creations = existingFiles;
        isLoading = false;
      });

      logger.d('Loaded ${creations.length} creations');
    } catch (e) {
      logger.e('Error loading creations: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  // Eliminar una creación
  Future<void> _deleteCreation(String filePath, int index) async {
    try {
      // Mostrar diálogo de confirmación
      final shouldDelete = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Eliminar creación'),
          content: const Text('¿Estás seguro de que deseas eliminar esta creación?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Eliminar'),
            ),
          ],
        ),
      );

      if (shouldDelete == true) {
        // Eliminar el archivo
        final file = File(filePath);
        if (await file.exists()) {
          await file.delete();
        }

        // Eliminar del provider
        if (mounted) {
          context.read<ConfigurationData>().removeCreation(filePath);

          // Eliminar de la lista local
          setState(() {
            creations.removeAt(index);
          });

          // Mostrar mensaje
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Creación eliminada'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      logger.e('Error deleting creation: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al eliminar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Creaciones realizadas"),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadCreations,
            tooltip: 'Recargar',
          ),
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Card(
              elevation: 10,
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    const Text(
                      'Lista de creaciones realizadas',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Total: ${creations.length} creaciones',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : creations.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_not_supported,
                              size: 80,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No hay creaciones aún',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Crea tu primer pixel art',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(8),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: creations.length,
                        itemBuilder: (context, index) {
                          final filePath = creations[index];
                          final fileName = filePath.split('/').last;

                          return Card(
                            elevation: 4,
                            child: InkWell(
                              onTap: () {
                                // Mostrar la imagen en un diálogo
                                showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        AppBar(
                                          title: const Text('Vista previa'),
                                          automaticallyImplyLeading: false,
                                          actions: [
                                            IconButton(
                                              icon: const Icon(Icons.close),
                                              onPressed: () => Navigator.pop(context),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Image.file(
                                            File(filePath),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.file(
                                        File(filePath),
                                        fit: BoxFit.contain,
                                        errorBuilder: (context, error, stackTrace) {
                                          logger.e('Error loading image: $error');
                                          return const Center(
                                            child: Icon(
                                              Icons.broken_image,
                                              size: 50,
                                              color: Colors.grey,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    color: Colors.grey[200],
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          fileName,
                                          style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.delete, size: 20),
                                              color: Colors.red,
                                              padding: EdgeInsets.zero,
                                              constraints: const BoxConstraints(),
                                              onPressed: () => _deleteCreation(filePath, index),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.home),
              label: const Text("Volver al Home"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}