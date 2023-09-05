import 'package:flutter/material.dart';
import 'package:shop_app/features/categories/presentation/views/widgets/categoris_item.dart';

import '../../../../shop_layout/manager/cubit/cubit.dart';

class CategoriesViewBody extends StatelessWidget {
  const CategoriesViewBody ({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
           physics: const BouncingScrollPhysics(),
          itemBuilder:(context,index)=> CategorisItem(model:ShopCubit.get(context).categoriesModel!.data!.data[index]),
          separatorBuilder: (context,index)=>const Padding(
            padding: EdgeInsets.all(20.0),
            child: SizedBox(height: 1.0,width: 1.0,),
          ),
          itemCount:ShopCubit.get(context).categoriesModel!.data!.data.length ) ;
  }
}