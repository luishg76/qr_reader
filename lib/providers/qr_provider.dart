import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_reader/models/scan_model.dart';

class QRProvider extends ChangeNotifier{
  ScanModel? _result;

  set SetResult(ScanModel? result){
    _result=result;
    notifyListeners();
  }

  ScanModel? get GetCode{
    return _result;
  }

}