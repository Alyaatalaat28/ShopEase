import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/cache_helper.dart';
import '../../../../../core/utils/components.dart';
import '../../../../login/presentation/views/widgets/default_form_field.dart';
import '../../../../shop_layout/presentation/views/shop_layout.dart';
import '../../../manager/cubit/cubit.dart';
import '../../../manager/cubit/states.dart';


class ShopRegisterViewBody extends StatelessWidget {
  const ShopRegisterViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (BuildContext context)=>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener:(context,state){
          if(state is ShopRegisterSuccessState){
            if(state.loginModel.status!){
              print(state.loginModel.message);
              print(state.loginModel.data?.token);
              CacheHelper.saveData(key: 'token', value:state.loginModel.data?.token ).then((value) {
                navigateAndFinish(context, const ShopLayout());
              });
            }else{
              print(state.loginModel.message);
              showToast(
                  text: state.loginModel.message!,
                  state: ToastStates.ERROR);

            }
          }
        },
        builder: (context,state)=>Scaffold(
          appBar:AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Text(
                        'REGISTER',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                          color:Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Register now to browse our hot offers ',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defaultFormField(
                          controller: nameController,
                          type:TextInputType.name,
                          validate: (String? value){
                            if(value==null || value.isEmpty){
                              return 'please enter your name';
                            }else{
                              return null;
                            }
                          },
                          label: 'user name',
                          prefix:Icons.person),

                      const SizedBox(
                        height: 15.0,
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

                      const SizedBox(
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
                        label: 'password',
                        isPassword: ShopRegisterCubit.get(context).isPassword,
                        prefix:Icons.lock,
                        suffix:ShopRegisterCubit.get(context).suffix,
                        suffixPressed:(){
                          ShopRegisterCubit.get(context).changePasswordVisibility();
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),

                      defaultFormField(
                          controller: phoneController,
                          type:TextInputType.phone,
                          validate: (String? value){
                            if(value==null || value.isEmpty){
                              return 'please enter your phone';
                            }else{
                              return null;
                            }
                          },
                          label: 'phone',
                          prefix:Icons.phone),

                      const SizedBox(
                        height: 20.0,),

                      ConditionalBuilder(
                        condition: state is! ShopRegisterLoadingState ,
                        builder: (context)=>defaultButton(
                          function: (){
                            if(formKey.currentState!.validate()){
                              ShopRegisterCubit.get(context).userRegister(
                                name:nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone:phoneController.text,

                              );
                            }

                          },
                          text: 'sign up',
                          isUpperCase: true,),
                        fallback:(context)=> const Center(child: CircularProgressIndicator()),
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
