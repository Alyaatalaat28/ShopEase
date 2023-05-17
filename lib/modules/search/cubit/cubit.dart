
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/states.dart';

import '../../shared/components/constants.dart';
import '../../shared/network/remote/dio_helper.dart';
import '../../shared/network/remote/endPoints.dart';
import '../../shopAppModels/search_model.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit(): super(SearchInitialState());
  static SearchCubit get(context)=>BlocProvider.of(context);
  SearchModel? model;
  void searh( String? text){
    emit(SearchLoadingState());
    DioHelper.postData(url: SEARCH ,
        token: token,
        data: {
      'text':text
    }).then((value){
      model=SearchModel.fromJson(value.data);
      emit(SearchSuccessState());

    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState());
    });
  }

}