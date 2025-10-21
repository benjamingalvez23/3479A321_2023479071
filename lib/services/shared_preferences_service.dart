// lib/services/shared_preferences_service.dart

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String _sizeKey = 'gridSize'; 
  static const String _paletteKey = 'colorPalette';
  static const String _creationsKey = 'creations'; // Nueva clave para las creaciones

  static const int _defaultSize = 8;
  static const String _defaultPalette = 'basica';

  Future<Map<String, dynamic>> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    
    final size = prefs.getInt(_sizeKey) ?? _defaultSize;
    final colorPalette = prefs.getString(_paletteKey) ?? _defaultPalette;

    return {
      'size': size,
      'colorPalette': colorPalette,
    };
  }

  Future<void> saveSize(int size) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_sizeKey, size);
  }

  Future<void> saveColorPalette(String colorPalette) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_paletteKey, colorPalette);
  }

  // Guardar la lista de creaciones
  Future<void> saveCreations(List<String> creations) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_creationsKey, creations);
  }

  // Cargar la lista de creaciones
  Future<List<String>> loadCreations() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_creationsKey) ?? [];
  }

  // Agregar una sola creación (alternativa más eficiente)
  Future<void> addCreation(String filePath) async {
    final creations = await loadCreations();
    if (!creations.contains(filePath)) {
      creations.add(filePath);
      await saveCreations(creations);
    }
  }

  // Eliminar una creación específica
  Future<void> removeCreation(String filePath) async {
    final creations = await loadCreations();
    creations.remove(filePath);
    await saveCreations(creations);
  }

  // Limpiar todas las creaciones
  Future<void> clearCreations() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_creationsKey);
  }
}