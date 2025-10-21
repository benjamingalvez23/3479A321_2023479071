// ignore: file_names
import 'package:flutter/material.dart';
import 'package:lab2/services/shared_preferences_service.dart';

class ConfigurationData extends ChangeNotifier {
  final SharedPreferencesService _prefsService; 

  int _size = 12; 
  String _colorPalette = 'basica';
  List<String> _creations = []; // Lista de rutas de archivos creados
  
  final Map<String, List<Color>> _palettes = {
    'basica': [
      Colors.black, Colors.white, Colors.red, Colors.orange, Colors.yellow, 
      Colors.green, Colors.blue, Colors.indigo, Colors.purple, Colors.brown, 
      Colors.grey, Colors.pink,
    ],
    'oscura': [
      const Color(0xFF1B1C1E), const Color(0xFF4C4F51), const Color(0xFF6A050D), 
      const Color(0xFF8A4B02), const Color(0xFFB88C00), const Color(0xFF005A31), 
      const Color(0xFF003D7A), const Color(0xFF2C2F7A), const Color(0xFF4E1D4E), 
      const Color(0xFF5A391D), const Color(0xFFB0B0B0), const Color(0xFF75364C),
    ],
    'pastel': [
      const Color(0xFFFFB3BA), const Color(0xFFFFDFBA), const Color(0xFFFFFFBA), 
      const Color(0xFFBAFFC9), const Color(0xFFBAE1FF), const Color(0xFFAAB7F5), 
      const Color(0xFFD6A9E2), const Color(0xFFF0E68C), const Color(0xFF87CEFA), 
      const Color(0xFFFFCCCC), const Color(0xFFCCFFCC), const Color(0xFFFFDAB9),
    ],
    'neon': [
      const Color(0xFF00FF00), const Color(0xFFFF00FF), const Color(0xFFFFFF00), 
      const Color(0xFF00FFFF), const Color(0xFFFF4D4D), const Color(0xFFFF9900), 
      const Color(0xFF0000FF), const Color(0xFF8A2BE2), const Color(0xFF33FFCC), 
      const Color(0xFFFF007F), const Color(0xFFD4AF37), const Color(0xFF6600FF),
    ],
    'retro': [
      const Color(0xFF000000), const Color(0xFFFFFFFF), const Color(0xFFF7931E), 
      const Color(0xFF8B008B), const Color(0xFF006400), const Color(0xFF00008B), 
      const Color(0xFFB8860B), const Color(0xFF808080), const Color(0xFFF0E68C), 
      const Color(0xFFB22222), const Color(0xFFDAA520), const Color(0xFF556B2F),
    ],
  };
  
  int get size => _size;
  String get colorPalette => _colorPalette;
  List<String> get creations => List.unmodifiable(_creations); // Devolver copia inmutable
  
  List<Color> get currentColorPalette {
    return _palettes[_colorPalette] ?? _palettes['basica']!; 
  }

  ConfigurationData(this._prefsService) {
    _loadPreferences(); 
  }

  Future<void> _loadPreferences() async {
    final data = await _prefsService.loadPreferences();
    _size = data['size'] as int;
    _colorPalette = data['colorPalette'] as String;
    
    // Cargar las creaciones guardadas
    final loadedCreations = await _prefsService.loadCreations();
    _creations = List<String>.from(loadedCreations);
      
    notifyListeners(); 
  }

  void setsize(int newsize) {
    if (_size != newsize) {
      _size = newsize;
      _prefsService.saveSize(newsize);
      notifyListeners(); 
    }
  }
  
  void setcolorPalette(String newcolorPalette) {
    if (_colorPalette != newcolorPalette) {
      _colorPalette = newcolorPalette;
      _prefsService.saveColorPalette(newcolorPalette);
      notifyListeners(); 
    }
  }

  // Agregar una nueva creación
  void addCreation(String filePath) {
    if (!_creations.contains(filePath)) {
      _creations.add(filePath);
      _prefsService.saveCreations(_creations);
      notifyListeners();
    }
  }

  // Obtener la última creación
  String? getLastCreation() {
    if (_creations.isEmpty) return null;
    return _creations.last;
  }

  // Eliminar una creación
  void removeCreation(String filePath) {
    _creations.remove(filePath);
    _prefsService.saveCreations(_creations);
    notifyListeners();
  }

  // Limpiar todas las creaciones
  void clearCreations() {
    _creations.clear();
    _prefsService.saveCreations(_creations);
    notifyListeners();
  }
}