

import '../../shopAppModels/change_favorites_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ChangeBottomNavBar extends ShopStates{}

class ShopLoadingHomeData extends ShopStates{}

class ShopSuccessHomeData extends ShopStates{}

class ShopErrorHomeData extends ShopStates{
 final String error;
 ShopErrorHomeData(this.error);

}
class ShopSuccessCategoriesData extends ShopStates{}

class ShopErrorCategoriesData extends ShopStates{
 final String error;
 ShopErrorCategoriesData(this.error);

}
class ShopSuccessChangeFavoritesState extends ShopStates{
  ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopChangeFavoritesState extends ShopStates{}

class ShopErrorChangeFavoritesState extends ShopStates{
 final String error;
 ShopErrorChangeFavoritesState(this.error);

}
class ShopSuccessGetFavoritesState extends ShopStates{}

class ShopErrorGetFavoritesState extends ShopStates{
  final String error;
  ShopErrorGetFavoritesState(this.error);

}
class ShopLoadingFavoritesState extends ShopStates{}

class ShopLoadingUserData extends ShopStates{}

class ShopSuccessUserData extends ShopStates{}

class ShopErrorUserData extends ShopStates{
  final String error;
  ShopErrorUserData(this.error);

}

class ShopLoadingUpdateUserData extends ShopStates{}

class ShopSuccessUpdateUserData extends ShopStates{}

class ShopErrorUpdateUserData extends ShopStates{
  final String error;
  ShopErrorUpdateUserData(this.error);

}

