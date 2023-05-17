import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../register/shop_register_screen.dart';
import '../shared/components/components.dart';
import '../shared/components/constants.dart';
import '../shared/network/local/cache_helper.dart';
import '../shop_layout/shop_layout.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class ShopLoginScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopLoginCubit() ,
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener:(context,state){
          if(state is ShopLoginSuccessState){
            if(state.loginModel.status!){
              print(state.loginModel.message);
              print(state.loginModel.data?.token);
              CacheHelper.saveData(key: 'token', value:state.loginModel.data?.token ).then((value){
                token=state.loginModel.data!.token!;
                navigateAndFinish(context,ShopLayout() );
              });

            }else{
              print(state.loginModel.message);
              showToast(
                  text: state.loginModel.message!,
                  state: ToastStates.ERROR);

            }
          }
        },
        builder: (context,state)=> Scaffold(
          appBar: AppBar(),
          body:Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                          color:Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Login now to browse our hot offers ',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      defaultFormField(
                          controller: emailController,
                          type:TextInputType.emailAddress,
                          validate: (String? value){
                            if(value==null || value.isEmpty){
                              return 'please enter your email address';
                            }else{
                              return null;
                            }
                          },
                          label: 'email address',
                          prefix:Icons.email_outlined),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                          controller:passwordController,
                          type:TextInputType.visiblePassword,
                          validate: (String? value){
                            if(value==null || value.isEmpty){
                              return 'password is too short';
                            }else{
                              return null;
                            }
                          },
                          onSubmit:(value){
                            if(formKey.currentState!.validate()){
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                              );
                            }

                          },
                          label: 'password',
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          prefix:Icons.lock,
                          suffix:ShopLoginCubit.get(context).suffix,
                          suffixPressed:(){
                            ShopLoginCubit.get(context).changePasswordVisibility();
                          }
                      ),
                      SizedBox(height: 20.0,),
                      ConditionalBuilder(
                        condition: state is! ShopLoginLoadingState ,
                        builder: (context)=>defaultButton(
                          function: (){
                            if(formKey.currentState!.validate()){
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text
                              );
                            }

                          },
                          text: 'login',
                          isUpperCase: true,),
                        fallback:(context)=> Center(child: CircularProgressIndicator()),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account ?',
                          ),
                          TextButton(
                            onPressed: (){
                              navigateTo(context,ShopRegisterScreen());
                            },
                            child: Text('register'.toUpperCase(),

                            ),

                          )
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

      ),
    );
  }
}
