import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/qr_provider.dart';

import '../providers/ui_provider.dart';

class DirectionsWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final qrprovider=Provider.of<QRProvider>(context);
     return Center(
        child: Text('Directions Partial ${qrprovider.GetCode}'),
       );
  }
}