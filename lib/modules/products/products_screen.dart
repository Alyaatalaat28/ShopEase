import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components/components.dart';
import '../shared/styles/colors.dart';
import '../shopAppModels/categories_model.dart';
import '../shopAppModels/home_model.dart';
import '../shop_layout/cubit/cubit.dart';
import '../shop_layout/cubit/states.dart';
class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

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
          builder: (context)=>ProductBuilder(ShopCubit.get(context).homeModel!,ShopCubit.get(context).categoriesModel!,context),
          fallback: (context)=>const Center(child: CircularProgressIndicator()),
        ),
        ) ;
  }
  Widget ProductBuilder(HomeModel model,CategoriesModel model2,context)=>SingleChildScrollView(
    physics:const BouncingScrollPhysics(),
    child: Column(
      children: [
        CarouselSlider(
          items:model.data!.banners.map((e) =>Image(
            image: NetworkImage('${e.images}'),
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          ).toList() ,
          options: CarouselOptions(
            height: 250.0,
            initialPage: 0,
            enableInfiniteScroll: true,
            viewportFraction: 1.0,
            reverse: false,
            autoPlay: true,
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayInterval: Duration(seconds: 3),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,

          ),),
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Categories',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                height: 100.0,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context,index)=>buildCategoryItem(model2.data!.data[index]),
                    separatorBuilder: (context,index)=>SizedBox(width:20.0,),
                    itemCount:model2.data!.data.length ),
              ),
              Text('New Products',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1/1.72,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,


            children: List.generate(model.data!.products.length,
                    (index) =>buildGridProduct(model.data!.products[index],context)),

          ),
        ),
      ]
    ),
  );


  Widget buildGridProduct(ProductModel model,context)=>
     Container(
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      '${model.name}',
                     maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      height:1.3,
                    ),
                  ),
                  Row(
                    children: [
                      Text('${model.price.round()}',
                        style: TextStyle(
                          color: default_color,
                          fontSize: 12.0,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if(model.discount != 0)
                          Text(
                        '${model.oldPrice.round()}',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Spacer(),
                      CircleAvatar(
                        radius: 15.0,
                        backgroundColor:ShopCubit.get(context).favorites[model.id]!?default_color:Colors.grey ,
                        child: IconButton(
                          onPressed: (){
                            ShopCubit.get(context).changeFavorites(model.id!);
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
  Widget buildCategoryItem(DataModel model)=>Stack(
    alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
              image: NetworkImage('${model.image}'),
            width: 100.0,
            height: 100.0,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.8),
            child: Text('${model.name}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),

            ),
          ),
        ],
  );


}
