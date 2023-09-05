
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/manager/cubit/states.dart';

import '../../utils/cache_helper.dart';


class AppCubit extends Cubit<AppState> {

  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);


  bool isDark = false;
  void changeAppMode({bool? fromShared}){
    if (fromShared!=null){
      isDark = fromShared;
      emit(AppChangeMode());
    }
    else{
      isDark = !isDark ;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeMode());
      });

    }

  }


}