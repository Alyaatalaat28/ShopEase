import 'package:flutter/material.dart';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_layout/cubit/cubit.dart';
import 'package:shop_app/modules/shop_layout/cubit/states.dart';
import '../shopAppModels/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates> (
      listener:(context,state){} ,
      builder:(context,state)=>ListView.separated(
           physics: BouncingScrollPhysics(),
          itemBuilder:(context,index)=> buildCatItem(ShopCubit.get(context).categoriesModel!.data!.data[index]),
          separatorBuilder: (context,index)=>Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(height: 1.0,width: 1.0,),
          ),
          itemCount:ShopCubit.get(context).categoriesModel!.data!.data.length ) ,
    );
  }
  Widget buildCatItem(DataModel model)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(image: NetworkImage('${model.image}'),
        width: 80.0,
          height: 80.0,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: 20.0,
        ),
        Text('${model.name}',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Icon(
          Icons.arrow_forward_ios
        ),
      ],
    ),
  );
}
