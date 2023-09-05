
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/features/search/manager/cubit/states.dart';

import '../../../../constants.dart';
import '../../../../core/utils/api_service/api_service.dart';
import '../../../../core/utils/api_service/end_points.dart';
import '../../data/search_model.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit(): super(SearchInitialState());
  static SearchCubit get(context)=>BlocProvider.of(context);
  SearchModel? model;
  void searh( String? text){
    emit(SearchLoadingState());
    DioHelper.postData(url: search ,
        token: token,
        data: {
      'text':text
    }).then((value){
      model=SearchModel.fromJson(value.data);
      emit(SearchSuccessState());

    }).catchError((error){
      // ignore: avoid_print
      print(error.toString());
      emit(SearchErrorState());
    });
  }

}