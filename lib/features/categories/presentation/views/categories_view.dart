import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/features/categories/presentation/views/widgets/categoris_view_body.dart';
import 'package:shop_app/features/shop_layout/manager/cubit/cubit.dart';
import 'package:shop_app/features/shop_layout/manager/cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates> (
      listener:(context,state){} ,
      builder:(context,state)=>const CategoriesViewBody(),
    );
  }
}