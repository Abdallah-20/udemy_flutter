import 'package:udemy_flutter/models/shop_app/change_favorites_model.dart';
import 'package:udemy_flutter/models/shop_app/login_model.dart';

abstract class ShopStates {}

class InitialShopState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {
  final String error;

  ShopErrorHomeDataState(this.error);
}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {
  final String error;

  ShopErrorCategoriesState(this.error);
}

class ShopChangeFavState extends ShopStates {}

class ShopSuccessChangeFavState extends ShopStates {
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavState(this.model);
}

class ShopErrorChangeFavState extends ShopStates {
  final String error;

  ShopErrorChangeFavState(this.error);
}

class ShopLoadingGetFavState extends ShopStates {}

class ShopSuccessGetFavState extends ShopStates {}

class ShopErrorGetFavState extends ShopStates {
  final String error;

  ShopErrorGetFavState(this.error);
}

class ShopLoadingGetUserDataState extends ShopStates {}

class ShopSuccessGetUserDataState extends ShopStates {
  final ShopLoginModel userModel;

  ShopSuccessGetUserDataState(this.userModel);
}

class ShopErrorGetUserDataState extends ShopStates {
  final String error;

  ShopErrorGetUserDataState(this.error);
}

class ShopLoadingUpdateUserState extends ShopStates {}

class ShopSuccessUpdateUserState extends ShopStates {
  final ShopLoginModel userModel;

  ShopSuccessUpdateUserState(this.userModel);
}

class ShopErrorUpdateUserState extends ShopStates {
  final String error;

  ShopErrorUpdateUserState(this.error);
}