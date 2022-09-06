import 'package:all_tests/shared/cubit/state.dart';
import 'package:all_tests/shared/network/end_point.dart';
import 'package:all_tests/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ShopLoginCubit extends Cubit <ShopLoginStates>{

  ShopLoginCubit() : super(ShopLoginIntialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  
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
      print(value);
      emit(ShopLoginSuccessState());
    }).catchError((error){
      emit(ShopLoginErrorState(error.toString()));
    });
    }
  }
