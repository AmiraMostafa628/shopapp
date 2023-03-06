import 'dart:io';
import 'package:all_tests/models/shop_model/cart_model.dart';
import 'package:all_tests/models/shop_model/categories_model.dart';
import 'package:all_tests/models/shop_model/change_favorites_model.dart';
import 'package:all_tests/models/shop_model/favorites_model.dart';
import 'package:all_tests/models/shop_model/home_model.dart';
import 'package:all_tests/models/shop_model/shopLogin.dart';
import 'package:all_tests/modules/shop_app/categories/categories_screen.dart';
import 'package:all_tests/modules/shop_app/favourite/favourite_screen.dart';
import 'package:all_tests/modules/shop_app/products/products_screen.dart';
import 'package:all_tests/shared/components/constant.dart';
import 'package:all_tests/shared/cubit/states.dart';
import 'package:all_tests/shared/network/end_point.dart';
import 'package:all_tests/shared/network/local/cache_helper.dart';
import 'package:all_tests/shared/network/remote/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../modules/shop_app/cart/cartScreen.dart';

class ShopCubit extends Cubit<ShopStates>{
   ShopCubit():super(ShopInitialStates());

   static ShopCubit get(context)=> BlocProvider.of(context);

   int currentIndex=0;
   
   List <Widget> bottomScreens=
   [
     ProductsScreen(),
     CategoriesScreen(),
     favoritesScreen(),
     CartScreen(),

   ];

   void changeBottom(index){
     currentIndex=index;
     emit(BottomNavBarStates());

   }
   HomeModel? homeModel;
   Map<dynamic,dynamic> favorites ={};
   Map<dynamic,dynamic> cart ={};

   void getHomeData(){
     emit(ShopLoadingHomeDataState());

     DioHelper.getData(
         url: HOME,
         token: token
     ).then((value){

       homeModel=HomeModel.fromJson(value.data);
       print(homeModel!.status);

       //print(homeModel!.data?.banners[0].image);

       homeModel!.data!.products.forEach((element) {
         favorites.addAll(
             {element.id: element.inFavorites});
         cart.addAll(
             {element.id: element.inCart});
       });
       emit(ShopSuccessHomeDataState());

     }).catchError((error){
       print(error.toString());
       emit(ShopErrorHomeDataState(error.toString()));
     });

   }

   CategoriesModel? categoriesModel;

   void getCategories(){

     DioHelper.getData(
         url: Get_Categories,
     ).then((value){

       categoriesModel=CategoriesModel.fromJson(value.data);
       emit(ShopSuccesscategoriesState());

     }).catchError((error){
       print(error.toString());
       emit(ShopErrorcategoriesState(error.toString()));
     });

   }

   ChangeFavoritesModel? changefavoritesModel;

   void changeFavorites(int? productId){

     favorites[productId]=!favorites[productId];
       emit(ShopChangeFavoritesState());

     DioHelper.postData(
         url: FAVORITES,
         data: {
           'product_id':productId
         },
         token: token,
     ).then((value){
       changefavoritesModel= ChangeFavoritesModel.fromJson(value.data);
       print(value.data);
           if(!changefavoritesModel!.status!)
               favorites[productId]= !favorites[productId];
           else
             getFavorites();

           emit(ShopChangeFavoritesSuccessState(changefavoritesModel!));
     }).catchError((error){
       print(error.toString());
       favorites[productId]= !favorites[productId];
       emit(ShopChangeFavoritesErrorState(error));
     });

   }

   FavoritesModel? favoritesModel;

   void getFavorites(){
     emit(ShopLoadingGetFavoritesState());

     DioHelper.getData(
       url: FAVORITES,
       token: token
     ).then((value){

       favoritesModel=FavoritesModel.fromJson(value.data);

       emit(ShopGetFavoritesSuccessState());

     }).catchError((error){
       print(error.toString());
       emit(ShopGetFavoritesErrorState(error.toString()));
     });

   }

   ShopLoginModel? userModel;

   void getUserData(){
     emit(ShopLoadingUserDataState());

     DioHelper.getData(
         url: PROFILE,
         token: token,
     ).then((value){

       userModel =ShopLoginModel.fromJson(value.data);
       emit(ShopSuccessUserDataState());

     }).catchError((error){
       print(error.toString());
       emit(ShopErrorUserDataState(error.toString()));
     });

   }

   Future<void> updateData({
      required String name,
      required String email,
      required String phone,
       }) async {
     emit(ShopLoadingUpdateUserDataState());
     DioHelper.putData(
         url: UPDATEPROFILE,
         token:token,
         data:{
           "name": name,
           "email": email,
           'phone' :phone,
         }
         ).then((value){

       userModel =ShopLoginModel.fromJson(value.data);

       print(userModel!.data!.image);

       emit(ShopSuccessUpdateUserDataState());

     }).catchError((error){
       print(error.toString());
       emit(ShopErrorUpdateUserDataState(error.toString()));
     });

   }

   ChangeFavoritesModel? changeCartModel;

   void changeCart(int? productId){

     cart[productId]=!cart[productId];
     emit(ShopChangeCartState());

     DioHelper.postData(
       url: Carts,
       data: {
         'product_id':productId
       },
       token: token,
     ).then((value){
       changeCartModel= ChangeFavoritesModel.fromJson(value.data);
       print(value.data);
       if(!changeCartModel!.status!)
         cart[productId]= !cart[productId];
       else
         getCarts();

       emit(ShopChangeCartSuccessState(changeCartModel!));
     }).catchError((error){
       print(error.toString());
       cart[productId]= !cart[productId];
       emit(ShopChangeCartErrorState(error));
     });

   }

   CartModel? cartModel;

   void getCarts(){
     emit(ShopLoadingGetCartState());

     DioHelper.getData(
         url: Carts,
         token: token
     ).then((value){

       cartModel=CartModel.fromJson(value.data);
       emit(ShopGetCartSuccessState());

     }).catchError((error){
       print(error.toString());
       emit(ShopGetCartErrorState(error.toString()));
     });

   }

bool isDark=true;
   void changeMode({bool? fromShared}) {
     if (fromShared != null) {
       isDark = fromShared;
       emit(AppChangeCurrentModeState());
     }
     else {
       isDark = !isDark;
       CacheHelper.saveData(key: 'isDark', value: isDark).then((value) {
         emit(AppChangeCurrentModeState());
       });
     }
   }

}
