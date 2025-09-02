import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'pages/MyHomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    var logger = Logger();
    logger.d("Logger is working!");
    

    return MaterialApp(
      title: '2023479071',
      theme: ThemeData(
        fontFamily: '28DaysLater',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 217, 255)),   
      ),
      
      home: const MyHomePage(),
    );
  }
}

