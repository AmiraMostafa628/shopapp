import 'package:all_tests/models/shop_model/change_favorites_model.dart';

abstract class ShopStates{}

class ShopInitialStates extends ShopStates{}

class BottomNavBarStates extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates {
  final String error;

  ShopErrorHomeDataState(this.error);
}

class ShopSuccesscategoriesState extends ShopStates{}

class ShopErrorcategoriesState extends ShopStates {
  final String error;

  ShopErrorcategoriesState(this.error);
}

class ShopChangeFavoritesState extends ShopStates{}

class ShopChangeFavoritesSuccessState extends ShopStates
{

  final ChangeFavoritesModel model;

  ShopChangeFavoritesSuccessState(this.model);
}

class ShopChangeFavoritesErrorState extends ShopStates {
  final String error;

  ShopChangeFavoritesErrorState(this.error);
}

class ShopLoadingGetFavoritesState extends ShopStates{}

class ShopGetFavoritesSuccessState extends ShopStates{}

class ShopGetFavoritesErrorState extends ShopStates {
  final String error;

  ShopGetFavoritesErrorState(this.error);
}

class ShopChangeCartState extends ShopStates{}

class ShopChangeCartSuccessState extends ShopStates{

  final ChangeFavoritesModel model;

  ShopChangeCartSuccessState(this.model);
}

class ShopChangeCartErrorState extends ShopStates {
  final String error;

  ShopChangeCartErrorState(this.error);
}

class ShopLoadingGetCartState extends ShopStates{}

class ShopGetCartSuccessState extends ShopStates{}

class ShopGetCartErrorState extends ShopStates {
  final String error;

  ShopGetCartErrorState(this.error);
}

class ShopLoadingUserDataState extends ShopStates{}

class ShopSuccessUserDataState extends ShopStates{}

class ShopErrorUserDataState extends ShopStates {
  final String error;

  ShopErrorUserDataState(this.error);
}

class ShopLoadingUpdateUserDataState extends ShopStates{}

class ShopSuccessUpdateUserDataState extends ShopStates{}

class ShopErrorUpdateUserDataState extends ShopStates {
  final String error;

  ShopErrorUpdateUserDataState(this.error);
}

class AppChangeBottomModeState extends ShopStates{}

class AppChangeCurrentModeState extends ShopStates{}

class ShopProfileImagePickedSuccessStates extends ShopStates{}

class ShopProfileImagePickedErrorStates extends ShopStates{}

class AppCreateDatabaseState extends ShopStates{}

class SocialUploadProfileImageSuccessStates extends ShopStates{}

class SocialUploadProfileImageErrorStates extends ShopStates{}