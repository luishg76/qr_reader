import 'package:flutter/material.dart';
import 'package:qr_reader/screens/home_screen.dart';
import 'package:qr_reader/screens/map_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QRReader',
      theme: ThemeData(       
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'home',
      routes: {
        'home':(context) => HomeScreen(),
        'map':(context) => MapScreen(),
      },
      home: HomeScreen(),
    );
  }
}



