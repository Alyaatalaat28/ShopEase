import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/styles/colors.dart';
import '../shopAppModels/get_favorites_model.dart';
import '../shop_layout/cubit/cubit.dart';
import '../shop_layout/cubit/states.dart';
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder:(context,state)=>ConditionalBuilder(
        condition: state is !ShopLoadingFavoritesState,
        builder: (context)=>ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder:(context,index)=>buildFavItem(ShopCubit.get(context).getFavoritesModel!.data!.data![index],context) ,
            separatorBuilder:(context,index)=> Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 1.0,
                width: 1.0,
              ),
            ),
            itemCount:ShopCubit.get(context).getFavoritesModel!.data!.data!.length),
        fallback:(context)=> Center(child: CircularProgressIndicator()),
      ) ,
    );


  }
  Widget buildFavItem(FavoritesData model,context)=>Container(
    height: 120.0,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image:NetworkImage('${model.product!.image}'),
              width: 120,
              height: 120,
            ),
            if(model.product!.discount!=0)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                color:Colors.red,
                child:Text('DISCOUNT',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.white,
                  ),

                ),
              ),
          ],
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.product!.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  height:1.3,
                  fontSize: 14.0,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text('${model.product!.price.round()}',
                    style: TextStyle(
                      color: default_color,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  if(model.product!.discount != 0)
                    Text(
                      '${model.product!.oldPrice.round()}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10.0,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  CircleAvatar(
                    radius: 15.0,
                    backgroundColor:ShopCubit.get(context).favorites[model.product!.id!]!?default_color:Colors.grey ,
                    child: IconButton(
                      onPressed: (){
                        ShopCubit.get(context).changeFavorites(model.product!.id!);
                      },
                      icon:Icon(
                        Icons.favorite_border,
                        size: 14.0,
                        color: Colors.white,

                      ),),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );


}
