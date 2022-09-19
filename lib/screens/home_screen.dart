import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/widgets/directions_partial.dart';
import 'package:qr_reader/widgets/maps_partial.dart';


class HomeScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
     final uiprovider=Provider.of<UIProvider>(context);
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
            body: _HomeBody(),  
            floatingActionButton: FloatingActionButton(      
                child: Icon(Icons.qr_code_scanner_outlined, size: 35),
                onPressed: (){},
              ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: uiprovider.getSelectTap,
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.map,size: 35,),
                  label: 'Mapa'),
                  BottomNavigationBarItem(
                  icon: Icon(Icons.compass_calibration, size: 35,),
                  label: 'Direcciones')
              ],
              onTap: (index){
                uiprovider.setSelectTap=index;                                                  
              },
            ),
          );
  }  
}

class _HomeBody extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final uiprovider=Provider.of<UIProvider>(context);
    switch(uiprovider.getSelectTap){
        case 0:return MapsWidget(); break;
        case 1:return DirectionsWidget(); break;

        default:return MapsWidget();
      }
  }
}