import 'package:flutter/material.dart';
import 'package:shop_app/features/favorite/presentaion/views/widgets/fav_item.dart';

import '../../../../shop_layout/manager/cubit/cubit.dart';

class FavoriteViewBody extends StatelessWidget {
  const FavoriteViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder:(context,index)=>FavItem(model:ShopCubit.get(context).getFavoritesModel!.data!.data![index]) ,
            separatorBuilder:(context,index)=> const Padding(
              padding: EdgeInsets.all(20.0),
              child: SizedBox(
                height: 1.0,
                width: 1.0,
              ),
            ),
            itemCount:ShopCubit.get(context).getFavoritesModel!.data!.data!.length,
            );
      
  }
}