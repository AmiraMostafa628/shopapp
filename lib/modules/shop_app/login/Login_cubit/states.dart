import 'package:all_tests/models/shop_model/shopLogin.dart';

abstract class ShopLoginStates {}

class ShopLoginIntialState extends ShopLoginStates{}

class ShopLoginLoadingState extends ShopLoginStates{}

class ShopLoginSuccessState extends ShopLoginStates{
  final ShopLoginModel loginModel;
  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginStates{
  final String error;
  ShopLoginErrorState(this.error);
}

class ShopChangePasswordVisibilityState extends ShopLoginStates{}

class ShopVerifyEmailSuccessState extends ShopLoginStates{}

class ShopVerifyEmailErrorState extends ShopLoginStates{}

class ShopChangePasswordSuccessState extends ShopLoginStates{}

class ShopChangePasswordErrorState extends ShopLoginStates{}