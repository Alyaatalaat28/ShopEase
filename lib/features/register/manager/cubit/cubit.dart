import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/features/register/manager/cubit/states.dart';
import '../../../../core/utils/api_service/api_service.dart';
import '../../../../core/utils/api_service/end_points.dart';
import '../../../login/data/shop_login_model.dart';


class ShopRegisterCubit extends Cubit<ShopRegisterStates>{

  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context)=>BlocProvider.of(context);

  ShopLoginModel? loginModel;


  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }){
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url: register,
        data: {
          'name':name,
          'email':email ,
          'password':password,
          'phone':phone,

        }).then((value) {
      // ignore: avoid_print
      print(value.data);
      loginModel=ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((onError){
      // ignore: avoid_print
      print(onError.toString());
      emit(ShopRegisterErrorState());
    });
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;
    emit(ShopRegisterPasswordVisibilityState());
  }


}