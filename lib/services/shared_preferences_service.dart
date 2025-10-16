// lib/services/SharedPreferencesService.dart

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String _sizeKey = 'gridSize'; 
  static const String _paletteKey = 'colorPalette';

  static const int _defaultSize = 12;
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
}