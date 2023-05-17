
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modules/login/login_screen.dart';
import 'modules/on_boarding/on_boarding_screen.dart';
import 'modules/shared/bloc_observer.dart';
import 'modules/shared/components/constants.dart';
import 'modules/shared/cubit/cubit.dart';
import 'modules/shared/cubit/states.dart';
import 'modules/shared/network/local/cache_helper.dart';
import 'modules/shared/network/remote/dio_helper.dart';
import 'modules/shared/styles/theme.dart';
import 'modules/shop_layout/cubit/cubit.dart';
import 'modules/shop_layout/shop_layout.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
 
   
   Bloc.observer = MyBlocObserver();
   DioHelper.init();
   await CacheHelper.init();
   // Use cubits...
    Widget widget;
    bool? isDark = CacheHelper.getBoolean(key: 'isDark');
    bool? isBoarding = CacheHelper.getData(key: 'isBoarding');
    token = CacheHelper.getData(key: 'token');
     if(isBoarding!=null){
      if(token!=null) widget = ShopLayout();
     else widget = ShopLoginScreen();
     }else{
      widget = OnBoardingScreen();
   }
   
  runApp( MyApp(
       isDark:isDark,
       startWidget:widget));
  }

class MyApp extends StatelessWidget {
   final bool? isDark ;
   final Widget? startWidget ;
   const MyApp({Key? key, this.isDark, this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => AppCubit()..changeAppMode(
              fromShared: isDark,)),
        BlocProvider(create: (BuildContext context)=>ShopCubit()..getHomeData()..getCategoriesData()..getFavorites()..getProfile(),),

      ],
      child: BlocConsumer<AppCubit,AppState>(
        listener:(context,state){
        },
        builder: (context , state){
          return  MaterialApp(
              debugShowCheckedModeBanner: false ,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: ThemeMode.light,
              //AppCubit.get(context).isDark? ThemeMode.dark : ThemeMode.light

              home:startWidget,


          );
        }
       ),
    );

  }
 }
