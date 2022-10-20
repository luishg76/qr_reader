
import 'package:flutter/material.dart';

class MapsWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
     return ListView.builder(
      itemCount:10,
      itemBuilder:(context,i)=> ListTile(
        leading:Icon(Icons.map,color:Theme.of(context).primaryColor,),
        title: Text('4589, 6548'),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey,),
        onTap: () => print('mostrar algo'),
         ),
    );
  }
}