import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String sizeKey = 'size';
  static const String paletteKey = 'palette';
  static const String creationsKey = 'creations';
  static const String titleKey = 'title';
  static const String showNumbersKey = 'showNumbers';

  Future<Map<String, dynamic>> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'size': prefs.getInt(sizeKey) ?? 12,
      'colorPalette': prefs.getString(paletteKey) ?? 'basica',
      'showNumbers': prefs.getBool(showNumbersKey) ?? true,
      'title': prefs.getString(titleKey) ?? '',
    };
  }

  Future<void> saveSize(int size) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(sizeKey, size);
  }

  Future<void> saveColorPalette(String palette) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(paletteKey, palette);
  }

  Future<void> saveTitle(String title) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(titleKey, title);
  }

  Future<void> saveShowNumbers(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(showNumbersKey, value);
  }

  Future<List<String>> loadCreations() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(creationsKey) ?? [];
  }

  Future<void> saveCreations(List<String> creations) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(creationsKey, creations);
  }
}