import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/qr_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/screens/home_screen.dart';
import 'package:qr_reader/screens/map_screen.dart';

void main() {
  runApp(AppStateWidget());
}
class AppStateWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
     return MultiProvider(providers: [
             ChangeNotifierProvider(create: (_)=>UIProvider(), lazy: true),
             ChangeNotifierProvider(create: (_)=>QRProvider(), lazy: true,),
          ],
          child: const MyApp(),
        );
  }
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
        //primaryColor: Colors.blue,   
        primarySwatch: Colors.deepPurple,        

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



