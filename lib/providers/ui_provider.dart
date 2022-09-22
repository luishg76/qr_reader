import 'package:flutter/material.dart';

class UIProvider extends ChangeNotifier{
  int _selecttap=0;
  
  set setSelectTap(int index){
      this._selecttap=index;
      notifyListeners();
  }

  get getSelectTap{
    return this._selecttap;
  }
} 