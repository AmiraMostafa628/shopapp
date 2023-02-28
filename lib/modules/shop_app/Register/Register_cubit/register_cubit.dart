import 'package:all_tests/models/shop_model/shopLogin.dart';
import 'package:all_tests/modules/shop_app/Register/Register_cubit/states.dart';
import 'package:all_tests/modules/shop_app/login/Login_cubit/states.dart';
import 'package:all_tests/shared/network/end_point.dart';
import 'package:all_tests/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ShopRegisterCubit extends Cubit <ShopRegisterStates>{

  ShopRegisterCubit() : super(ShopRegisterIntialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;
  
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,

})
  {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
        data: {
            'name': name,
            'email': email,
            'password': password,
            'phone': phone,
        },
    ).then((value){
      print(value.data);

      loginModel=ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
    }

    IconData suffix =Icons.visibility_outlined;
    bool ispassword= true;
    void changePasswordVisibility()
    {
      ispassword = !ispassword;
      suffix = ispassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
      emit(ShopRegisterChangePasswordVisibilityState());
    }
  }
