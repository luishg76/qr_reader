import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';

class QRProvider extends ChangeNotifier{
  ScanModel? _result;

  set setResult(ScanModel? result){
    _result=result;
    notifyListeners();
  }

  ScanModel? get getCode{
    return _result;
  }

}