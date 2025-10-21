// ignore: file_names
import 'package:flutter/material.dart';
import 'package:lab2/services/shared_preferences_service.dart';
import 'package:logger/logger.dart';

class ConfigurationData extends ChangeNotifier {
  final SharedPreferencesService _prefsService; 
  final Logger logger = Logger();
  int _size = 12; 
  String _colorPalette = 'basica';
  List<String> _creations = []; // Lista de rutas de archivos creados
  String _title = '';
  bool _showNumbers = true;
  
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
  List<String> get creations => List.unmodifiable(_creations);
  String get title => _title;
  bool get showNumbers => _showNumbers;
  
  List<Color> get currentColorPalette {
    return _palettes[_colorPalette] ?? _palettes['basica']!;
  }

  ConfigurationData(this._prefsService) {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    try {
      final data = await _prefsService.loadPreferences();
      _size = data['size'] as int;
      _colorPalette = data['colorPalette'] as String;
      _showNumbers = data['showNumbers'] as bool? ?? true;
      _title = data['title'] as String? ?? '';
      
      final loadedCreations = await _prefsService.loadCreations();
      _creations = List<String>.from(loadedCreations);
      
      notifyListeners();
      logger.i('Preferences loaded successfully');
    } catch (e) {
      logger.e('Error loading preferences: $e');
    }
  }

  Future<void> setsize(int newsize) async {
    try {
      if (_size != newsize) {
        _size = newsize;
        await _prefsService.saveSize(newsize);
        notifyListeners();
        logger.i('Size updated to: $newsize');
      }
    } catch (e) {
      logger.e('Error saving size: $e');
    }
  }

  Future<void> setcolorPalette(String newPalette) async {
    try {
      if (_colorPalette != newPalette) {
        _colorPalette = newPalette;
        await _prefsService.saveColorPalette(newPalette);
        notifyListeners();
        logger.i('Color palette updated to: $newPalette');
      }
    } catch (e) {
      logger.e('Error saving color palette: $e');
    }
  }

  Future<void> setTitle(String newTitle) async {
    try {
      if (_title != newTitle) {
        _title = newTitle;
        await _prefsService.saveTitle(newTitle);
        notifyListeners();
        logger.i('Title updated to: $newTitle');
      }
    } catch (e) {
      logger.e('Error saving title: $e');
    }
  }

  Future<void> setShowNumbers(bool value) async {
    try {
      if (_showNumbers != value) {
        _showNumbers = value;
        await _prefsService.saveShowNumbers(value);
        notifyListeners();
        logger.i('Show numbers updated to: $value');
      }
    } catch (e) {
      logger.e('Error saving show numbers setting: $e');
    }
  }

  void addCreation(String filePath) {
    try {
      if (!_creations.contains(filePath)) {
        _creations.add(filePath);
        _prefsService.saveCreations(_creations);
        notifyListeners();
        logger.i('Creation added: $filePath');
      }
    } catch (e) {
      logger.e('Error adding creation: $e');
    }
  }

  void removeCreation(String filePath) {
    try {
      if (_creations.remove(filePath)) {
        _prefsService.saveCreations(_creations);
        notifyListeners();
        logger.i('Creation removed: $filePath');
      }
    } catch (e) {
      logger.e('Error removing creation: $e');
    }
  }

  void clearCreations() {
    try {
      _creations.clear();
      _prefsService.saveCreations(_creations);
      notifyListeners();
      logger.i('All creations cleared');
    } catch (e) {
      logger.e('Error clearing creations: $e');
    }
  }
}