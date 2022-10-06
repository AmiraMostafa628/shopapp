import 'package:all_tests/models/shop_model/search_model.dart';
import 'package:all_tests/modules/shop_app/search/cubit/states.dart';
import 'package:all_tests/shared/components/constant.dart';
import 'package:all_tests/shared/cubit/states.dart';
import 'package:all_tests/shared/network/end_point.dart';
import 'package:all_tests/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopSearch extends Cubit <SearchStates>{

  ShopSearch() : super(SearchInitialStates());

  static ShopSearch get(context) => BlocProvider.of(context);

  SearchModel? model;

  void SearchProduct(String text)
  {
    emit(SearchLoadingStates());
    DioHelper.postData(
        url: SEARCH,
        token: token,
        data: {
          'text':text
        }).then((value) {
          model =SearchModel.fromJson(value.data);
          emit(SearchSuccessStates());

         }).catchError((error){
           print(error.toString());

           emit(SearchErrorStates());

        });

  }



}