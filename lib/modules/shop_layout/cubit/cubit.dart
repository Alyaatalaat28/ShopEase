
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_layout/cubit/states.dart';

import '../../categories/categories_screen.dart';
import '../../favorite/favorite_screen.dart';
import '../../login/login_screen.dart';
import '../../products/products_screen.dart';
import '../../setting/setting_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/network/remote/dio_helper.dart';
import '../../shared/network/remote/endPoints.dart';
import '../../shopAppModels/categories_model.dart';
import '../../shopAppModels/change_favorites_model.dart';
import '../../shopAppModels/get_favorites_model.dart';
import '../../shopAppModels/home_model.dart';
import '../../shopAppModels/shop_login_model.dart';

class ShopCubit extends Cubit<ShopStates>
{
     ShopCubit():super(ShopInitialState());

   static ShopCubit get(context)=>BlocProvider.of(context);
   List<Widget> bottomScreens =[
     ProductsScreen(),
     CategoriesScreen(),
     FavoriteScreen(),
     ShopSettingScreen(),
   ];
   int currentIndex = 0;
   void changeBottomNavBar(int index){
     currentIndex=index;
     emit(ChangeBottomNavBar());
   }
   Map<int,bool> favorites={};
   HomeModel? homeModel;
   void getHomeData(){
     emit(ShopLoadingHomeData());
     DioHelper.getData(
         url: HOME,
         token: token,
     ).then((value) {
       homeModel=HomeModel.fromJson(value?.data);
       print(value?.data);
       homeModel!.data!.products.forEach((element) {
         favorites.addAll({
           element.id!: element.inFavorites!
         });
       });


       emit(ShopSuccessHomeData());
     }).catchError((onError){
       print(onError.toString());
       emit(ShopErrorHomeData(onError.toString()));
     });

   }
   CategoriesModel? categoriesModel;
   void getCategoriesData(){
     DioHelper.getData(url: GET_CATEGORIES).then((value) {
       categoriesModel=CategoriesModel.fromjson(value!.data);
       print(value.data);

       emit(ShopSuccessCategoriesData());
     }).catchError((onError){
       print(onError.toString());
       emit(ShopErrorCategoriesData(onError));
     });
}

     ChangeFavoritesModel? changeFavoritesModel;
void changeFavorites(int productId){
  favorites[productId]=!favorites[productId]!;
  emit(ShopChangeFavoritesState());
     DioHelper.postData(
         url: FAVORITES,
         data:{
           'product_id':productId,
         },
         token:token,
     ).then((value) {
       changeFavoritesModel=ChangeFavoritesModel.fromjson(value.data);
       print(value.data);
       if(!changeFavoritesModel!.status!){
         favorites[productId]=!favorites[productId]!;
       }else{
         getFavorites();
       }
       emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));

     }).catchError((error){
        print(error.toString());
        emit(ShopErrorChangeFavoritesState(error));
     });
}
     GetFavoritesModel? getFavoritesModel;

void getFavorites(){
  emit(ShopLoadingFavoritesState());
  DioHelper.getData(
      url: FAVORITES,
      token: token
  ).then((value) {
    getFavoritesModel = GetFavoritesModel.fromJson(value!.data);
    print(value.data);
    emit(ShopSuccessGetFavoritesState());
  }).catchError((error){
    print(error.toString());
    emit(ShopErrorGetFavoritesState(error));
  });
}

ShopLoginModel? userModel;
void getProfile(){
  emit(ShopLoadingUserData());
  DioHelper.getData(url: PROFILE,token: token).then((value) {
    userModel=ShopLoginModel.fromJson(value?.data);
    print(userModel!.data!.name);
    print(userModel!.toString());
    emit(ShopSuccessUserData());
  }).catchError((error){
    print(error.toString());
    emit(ShopErrorUserData(error));
  });
}
void logout(context){
  CacheHelper.removeData(
      key: 'token'
  ).then((value) {
    if(value){
    navigateAndFinish(context,ShopLoginScreen() );
    }
  });
}
void updateUser({
  required String? name,
  required String? email,
  required String? phone,
}
    ){
  emit(ShopLoadingUpdateUserData());
  DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data:{
        'name':name,
        'email':email,
        'phone':phone,
      }).then((value) {
        userModel=ShopLoginModel.fromJson(value.data);
        emit(ShopSuccessUpdateUserData());
  }).catchError((error){
     print(error.toString());
     emit(ShopErrorUpdateUserData(error));
  });
}


 }


