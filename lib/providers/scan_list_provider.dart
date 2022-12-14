import 'package:flutter/cupertino.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:qr_reader/providers/db_provider.dart';


class ScanListProvider extends ChangeNotifier {
    List<ScanModel?> listScans=[];
    String tipoSelect='http';

    //Add a new scam in the list and data base
    addScan(String value)async {
      ScanModel newscan=ScanModel(valor: value);
      newscan.id=await DBProvider.dbp.addScan(newscan);
      if(tipoSelect==newscan.tipo)
      {
        listScans.add(newscan);
        notifyListeners();
      }
    }

    carryScanByTipo(String tipo)async {
      final scans=await DBProvider.dbp.getSansByTipo(tipo);
      tipoSelect=tipo;
      listScans=[...scans];
      notifyListeners();
    }

    deleteAllScans()async{
      await DBProvider.dbp.deleteAllScans();
      listScans=[]; 
      notifyListeners();
    }

    deleteScansById(int id)async{
      await DBProvider.dbp.deleteScansById(id);
      carryScanByTipo(tipoSelect);      
    }


}