// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../../core/utils/styles/colors.dart';
import '../../../../favorite/data/get_favorites_model.dart';
import '../../../../shop_layout/manager/cubit/cubit.dart';

class SearchItem extends StatelessWidget {
  SearchItem({super.key,required this.model, required bool isOldPrice});
  Product model;
  bool isOldPrice=true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
    height: 120.0,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image:NetworkImage('${model.image}'),
              width: 120,
              height: 120,
            ),
            if(model.discount!=0&& isOldPrice)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                color:Colors.red,
                child:const Text('DISCOUNT',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.white,
                  ),

                ),
              ),
          ],
        ),
        const SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  height:1.3,
                  fontSize: 14.0,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Text('${model.price.round()}',
                    style: const TextStyle(
                      color: default_color,
                      fontSize: 12.0,
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  if(model.discount != 0&&isOldPrice)
                    Text(
                      '${model.oldPrice.round()}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 10.0,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  const Spacer(),
                  CircleAvatar(
                    radius: 15.0,
                    backgroundColor:ShopCubit.get(context).favorites[model.id!]!?default_color:Colors.grey ,
                    child: IconButton(
                      onPressed: (){
                        ShopCubit.get(context).changeFavorites(model.id!);
                      },
                      icon:const Icon(
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
}