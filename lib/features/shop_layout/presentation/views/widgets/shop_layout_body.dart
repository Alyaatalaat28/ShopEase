import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/components.dart';
import '../../../../search/presentation/views/search_screen_view.dart';
import '../../../manager/cubit/cubit.dart';
import '../../../manager/cubit/states.dart';

class ShopLayoutBody extends StatelessWidget {
  const ShopLayoutBody({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit=ShopCubit.get(context);
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){

      },
      builder: (context,state)=>Scaffold(
        appBar:AppBar(
          title: const Text('Salla'),
          actions: [
            IconButton(
                onPressed: (){
                  navigateTo(context,const ShopSearchScreen());
                }, icon:const Icon(Icons.search))
          ],
        ),
        body:cubit.bottomScreens[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index){
            cubit.changeBottomNavBar(index);
          },
          currentIndex: cubit.currentIndex,
          items: const [
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