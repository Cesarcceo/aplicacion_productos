
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginFormProvider extends ChangeNotifier{

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String email='';
  String password ='';

  bool _isLoading =false;
  bool get isLoading =>_isLoading;
  set isLoading (bool value){
    _isLoading=value;
    notifyListeners();
  }

  bool isValidForm(){
    
    print(formkey.currentState?.validate());
    
    return formkey.currentState?.validate()??false;
  }
}