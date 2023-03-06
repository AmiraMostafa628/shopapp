import 'package:all_tests/models/shop_model/shopLogin.dart';
import 'package:all_tests/modules/shop_app/login/Login_cubit/states.dart';
import 'package:all_tests/modules/shop_app/login/loginScreen.dart';
import 'package:all_tests/shared/network/end_point.dart';
import 'package:all_tests/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/components/components.dart';


class ShopLoginCubit extends Cubit <ShopLoginStates>{

  ShopLoginCubit() : super(ShopLoginIntialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;
  
  void userLogin({
    required String email,
    required String password,
})
  {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: LOGIN,
        data: {
            'email': email,
            'password': password,
        },
    ).then((value){
      print(value.data);
      loginModel=ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
    }

    IconData suffix =Icons.visibility_outlined;
    bool ispassword= true;
    void changePasswordVisibility()
    {
      ispassword = !ispassword;
      suffix = ispassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
      emit(ShopChangePasswordVisibilityState());
    }

    void changePassword(currentPass,newPass,context)
    {
      DioHelper.postData(
          url: ChangePassword,
          data: {
            'current_password':'$currentPass',
            'new_password' : '$newPass',
          }).then((value) {
        showToast(text: 'Password change Successfully',
            state: ToastState.SUCCESS);
        NavigateTo(context, ShopLoginScreen());
            emit(ShopChangePasswordSuccessState());
      })
          .catchError((error){
            emit(ShopChangePasswordErrorState());
      });
    }
  }
