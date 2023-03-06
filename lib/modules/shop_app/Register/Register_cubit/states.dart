import 'package:all_tests/models/shop_model/shopLogin.dart';

abstract class ShopRegisterStates {}

class ShopRegisterIntialState extends ShopRegisterStates{}

class ShopRegisterLoadingState extends ShopRegisterStates{}

class ShopRegisterSuccessState extends ShopRegisterStates{

  final ShopLoginModel loginModel;
  ShopRegisterSuccessState(this.loginModel);
}

class ShopRegisterErrorState extends ShopRegisterStates{
  final String error;
  ShopRegisterErrorState(this.error);
}

class ShopRegisterChangePasswordVisibilityState extends ShopRegisterStates{}

class ShopImagePickedSuccessStates extends ShopRegisterStates{}

class ShopImagePickedErrorStates extends ShopRegisterStates{}