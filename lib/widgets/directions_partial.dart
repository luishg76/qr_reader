import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/qr_provider.dart';

import '../providers/ui_provider.dart';

class DirectionsWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final qrprovider=Provider.of<QRProvider>(context);
     return ListView.builder(
      itemCount:10,
      itemBuilder:(context,i)=> ListTile(
        leading:Icon(Icons.compass_calibration, color:Theme.of(context).primaryColor,),
        title: Text('http://google.com'),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey,),
        onTap: () => print('mostrar algo'),
         ),
    );
  }
}