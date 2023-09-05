import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/features/favorite/presentaion/views/widgets/favorite_view_body.dart';
import '../../../shop_layout/manager/cubit/cubit.dart';
import '../../../shop_layout/manager/cubit/states.dart';
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder:(context,state)=>ConditionalBuilder(
        condition: state is !ShopLoadingFavoritesState,
        builder: (context)=>const FavoriteViewBody(),
       fallback:(context)=> const Center(child: CircularProgressIndicator()),
      ) ,
    );


  }
}