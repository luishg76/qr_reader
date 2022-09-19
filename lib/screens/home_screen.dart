import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
     return Scaffold(
          appBar: AppBar(
            centerTitle:true,            
            title: Text('Historial'),
            actions:[
              IconButton(
                onPressed:(){}, 
                icon:Icon(Icons.delete_outline), 
              )
             ],
            ),           
            body: Center(child: Text('Home Screen')),  
            floatingActionButton: FloatingActionButton(      
                child: Icon(Icons.qr_code_scanner_outlined),
                onPressed: (){},
              ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomNavigationBar(
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.map),
                  label: 'Mapa'),
                  BottomNavigationBarItem(
                  icon: Icon(Icons.compass_calibration),
                  label: 'Direcciones')
              ]
              ),

           );
  }
}