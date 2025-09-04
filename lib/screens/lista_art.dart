import 'package:flutter/material.dart';

class ListArtScreen extends StatelessWidget {
  const ListArtScreen({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text('Pixel Art List'),
),
body: Center(
child: Text(
'Lista de pixel art disponibles',
style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
),
),
);
}
}
