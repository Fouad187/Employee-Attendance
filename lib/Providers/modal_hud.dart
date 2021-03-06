
import 'package:flutter/cupertino.dart';
class Modal extends ChangeNotifier
{

  bool isChange = false ;

  changeIsLoading(bool value)
  {
    isChange=value;
    notifyListeners();
  }
}