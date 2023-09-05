
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/manager/cubit/cubit.dart';
import 'core/manager/cubit/states.dart';
import 'core/utils/api_service/api_service.dart';
import 'features/login/presentation/views/login_view.dart';
import 'features/on_boarding/presentaion/views/on_boarding_view.dart';
import 'core/utils/bloc_observer.dart';
import 'constants.dart';
import 'core/utils/cache_helper.dart';
import 'core/utils/styles/theme.dart';
import 'features/shop_layout/manager/cubit/cubit.dart';
import 'features/shop_layout/presentation/views/shop_layout.dart';

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
      // ignore: curly_braces_in_flow_control_structures, unnecessary_null_comparison
      if(token!=null) widget = const ShopLayout();
     else {
        widget =  ShopLoginScreen();
      }
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
              home:startWidget,


          );
        }
       ),
    );

  }
 }
