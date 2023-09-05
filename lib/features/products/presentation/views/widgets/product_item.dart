import 'package:flutter/material.dart';

import '../../../../../core/utils/styles/colors.dart';
import '../../../../shop_layout/manager/cubit/cubit.dart';
import '../../../data/home_model.dart';

// ignore: must_be_immutable
class ProducItem extends StatelessWidget {
   ProducItem({super.key,required this.model});
  ProductModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
       color:Colors.white,
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image:NetworkImage('${model.image}'),
                width: double.infinity,
                height: 200,
              ),
              if(model.discount!=0)
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      '${model.name}',
                     maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      height:1.3,
                    ),
                  ),
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
                      if(model.discount != 0)
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
                        backgroundColor:ShopCubit.get(context).favorites[model.id]!?default_color:Colors.grey ,
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
  }}