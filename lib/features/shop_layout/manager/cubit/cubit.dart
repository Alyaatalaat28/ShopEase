
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/features/shop_layout/manager/cubit/states.dart';

import '../../../../core/utils/api_service/api_service.dart';
import '../../../../core/utils/api_service/end_points.dart';
import '../../../categories/presentation/views/categories_view.dart';
import '../../../favorite/presentaion/views/favorite_view.dart';
import '../../../login/presentation/views/login_view.dart';
import '../../../products/presentation/views/products_screen.dart';
import '../../../setting/presentation/views/setting_screen_view.dart';
import '../../../../core/utils/components.dart';
import '../../../../constants.dart';
import '../../../../core/utils/cache_helper.dart';
import '../../../categories/data/categories_model.dart';
import '../../../favorite/data/change_favorites_model.dart';
import '../../../favorite/data/get_favorites_model.dart';
import '../../../products/data/home_model.dart';
import '../../../login/data/shop_login_model.dart';

class ShopCubit extends Cubit<ShopStates>
{
     ShopCubit():super(ShopInitialState());

   static ShopCubit get(context)=>BlocProvider.of(context);
   List<Widget> bottomScreens =[
     const ProductsScreen(),
     const CategoriesScreen(),
     const FavoriteScreen(),
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
         url: home,
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
     DioHelper.getData(url: getCategoris).then((value) {
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
         url: favorite,
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
      url: favorite,
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
  DioHelper.getData(url: profile,token: token).then((value) {
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
      url: updateProfile,
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


