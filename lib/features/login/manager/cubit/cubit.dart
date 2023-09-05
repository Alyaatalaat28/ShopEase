
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/features/login/manager/cubit/states.dart';
import '../../../../core/utils/api_service/api_service.dart';
import '../../../../core/utils/api_service/end_points.dart';
import '../../data/shop_login_model.dart';


class ShopLoginCubit extends Cubit<ShopLoginStates>{

  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context)=>BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userLogin({
  required String email,
    required String password,
}){
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: login,
        data: {
          'email':email ,
          'password':password,
        }).then((value) {
          print(value.data);
          loginModel=ShopLoginModel.fromJson(value.data);
          emit(ShopLoginSuccessState(loginModel!));
    }).catchError((onError){
      print(onError.toString());
      emit(ShopLoginErrorState(onError.toString()));
    });
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;
    emit(ShopPasswordVisibilityState());
  }


}