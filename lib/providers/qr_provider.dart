import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRProvider extends ChangeNotifier{
  Barcode? _result;

  set SetResult(Barcode? result){
    _result=result;
    notifyListeners();
  }

  get GetCode{
    return _result?.code;
  }

}