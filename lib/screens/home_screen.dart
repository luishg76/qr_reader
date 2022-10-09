import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:qr_reader/providers/qr_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/widgets/directions_partial.dart';
import 'package:qr_reader/widgets/maps_partial.dart';
import 'package:flutter/foundation.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class HomeScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
     final uiprovider=Provider.of<UIProvider>(context);
     final qrprovider=Provider.of<QRProvider>(context);
     
     //TODO: lectura temporal a la base de datos 
     //DBProvider.dbp.getDataBase;
     final temp=new ScanModel(valor:'https://otro3.com');
     //DBProvider.dbp.AddScan(temp);
     //DBProvider.dbp.getScanById(2).then((scan)=>print(scan?.valor));
     //DBProvider.dbp.getAllScans().then((value) => {print(value) });
     
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
            body:_HomeBody(),  
            floatingActionButton: FloatingActionButton(      
                child: Icon(Icons.qr_code_scanner_outlined, size: 35),
                onPressed: () {
                    /*Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const QRViewExample(),
                    ));*/
                    qrprovider.SetResult=ScanModel(valor:'https://ing.luishg76@gmail.com');                 

                },
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

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    /*if (Platform.isAndroid) {
      controller!.pauseCamera();
    }*/
    controller!.resumeCamera();
  }
 
  @override
  Widget build(BuildContext context) {
    final qrprovider=Provider.of<QRProvider>(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                      Text('Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')                  
                  else
                    const Text('Scan a code'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                return Text('Flash: ${snapshot.data}');
                              },
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.flipCamera();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getCameraInfo(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return Text(
                                      'Camera facing ${describeEnum(snapshot.data!)}');
                                } else {
                                  return const Text('loading');
                                }
                              },
                            )),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.resumeCamera();                            
                          },
                          child: const Text('Star',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.stopCamera(); //pauseCamera();
                            qrprovider.SetResult=ScanModel(valor: result!.code??'');
                            Navigator.pop(context);
                          },
                          child: const Text('Stop',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
      this.controller!.resumeCamera();
    });

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}