import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/features/products/presentation/views/widgets/product_builder.dart';

import '../../../../../core/utils/components.dart';
import '../../../../shop_layout/manager/cubit/cubit.dart';
import '../../../../shop_layout/manager/cubit/states.dart';

class ProductViewBody extends StatelessWidget {
  const ProductViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if(state is ShopSuccessChangeFavoritesState){
          if(!state.model.status!){
            showToast(
                text: state.model.message!,
                state: ToastStates.ERROR);
          }
        }
      },
        builder: (context,state)=>ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel!=null && ShopCubit.get(context).categoriesModel!=null,
          builder: (context)=>ProductBuilder(model:ShopCubit.get(context).homeModel!,model2: ShopCubit.get(context).categoriesModel!),
          fallback: (context)=>const Center(child: CircularProgressIndicator()),
        ),
        ) ;
  }
}
