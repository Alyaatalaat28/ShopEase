import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/modules/shop_layout/cubit/cubit.dart';

import '../shared/styles/colors.dart';
import '../shopAppModels/search_model.dart';
class ShopSearchScreen extends StatelessWidget {
  var searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
          appBar:AppBar() ,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  controller: searchController ,
                  keyboardType:TextInputType.text ,
                  decoration: InputDecoration(
                    label:Text('Search') ,
                    suffixIcon:Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  validator:(String? value){
                    if(value!.isEmpty){
                      return'Enter Text To Search';
                    }else{
                      return null;
                    }
                  },
                  onFieldSubmitted: (String text){
                    SearchCubit.get(context).searh(text);
                  },
                ),
                SizedBox(height: 10.0,),
                if(state is SearchLoadingState)
                  LinearProgressIndicator(),
                if(state is SearchSuccessState)
                   Expanded(
                  child: ListView.separated(
                       physics: BouncingScrollPhysics(),
                      itemBuilder:(context,index)=> buildSearchItem(SearchCubit.get(context).model!.data!.data![index] as Product, context,isOldPrice: false),
                      separatorBuilder:(context,index)=> Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          height: 1.0,
                          width: 1.0,
                        ),
                      ),
                      itemCount:SearchCubit.get(context).model!.data!.data!.length),
                )
              ],
            ),
          ));
        },
      ),
    );
  }
  Widget buildSearchItem( Product model,context,{bool isOldPrice=true})=>Container(
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
                '${model.name}',
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
                  Text('${model.price.round()}',
                    style: TextStyle(
                      color: default_color,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  if(model.discount != 0&&isOldPrice)
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
                    backgroundColor:ShopCubit.get(context).favorites[model.id!]!?default_color:Colors.grey ,
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
}
