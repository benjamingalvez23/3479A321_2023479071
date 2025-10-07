// ignore: file_names
import 'package:flutter/material.dart';

class Configurationdata extends ChangeNotifier {

  int _size = 12;
  String _colorPalette = 'basica'; 
  
  int get size => _size;
  String get colorPalette => _colorPalette;

  void setsize(int newsize) {
    _size = newsize;
    notifyListeners(); 
  }
  
  void setcolorPalette(String newcolorPalette) {
    _colorPalette = newcolorPalette;
    notifyListeners(); 
  }
}