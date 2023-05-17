import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/modules/shop_layout/cubit/cubit.dart';
import 'package:shop_app/modules/shop_layout/cubit/states.dart';

import '../shared/components/components.dart';


class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit=ShopCubit.get(context);
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){

      },
      builder: (context,state)=>Scaffold(
        appBar:AppBar(
          title: Text('Salla'),
          actions: [
            IconButton(
                onPressed: (){
                  navigateTo(context, ShopSearchScreen());
                }, icon:Icon(Icons.search))
          ],
        ),
        body:cubit.bottomScreens[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index){
            cubit.changeBottomNavBar(index);
          },
          currentIndex: cubit.currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                  Icons.home ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  Icons.apps ),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  Icons.favorite),
              label: 'favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  Icons.settings),
              label: 'Setting',
            ),
          ],
        ),
      ),
    );
  }
}
