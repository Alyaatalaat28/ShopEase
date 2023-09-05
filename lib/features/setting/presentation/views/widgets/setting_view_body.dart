import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/styles/colors.dart';
import '../../../../shop_layout/manager/cubit/cubit.dart';
import '../../../../shop_layout/manager/cubit/states.dart';

// ignore: must_be_immutable
class SeetingViewBody extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  SeetingViewBody({super.key});
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){

        nameController.text=ShopCubit.get(context).userModel!.data!.name!;
        emailController.text=ShopCubit.get(context).userModel!.data!.email!;
        phoneController.text=ShopCubit.get(context).userModel!.data!.phone!;

     return ConditionalBuilder(

        condition:ShopCubit.get(context).userModel!=null,
        builder:(context)=>Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if(state is ShopLoadingUpdateUserData)
                    const LinearProgressIndicator(),
                  const SizedBox(height: 20.0,),
                  TextFormField(
                    controller: nameController ,
                    keyboardType:TextInputType.name ,
                    decoration: const InputDecoration(
                      label:Text('Name') ,
                      suffixIcon:Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    validator:(String? value){
                      if(value!.isEmpty){
                        return'Name Must Not Be Null';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: emailController ,
                    keyboardType:TextInputType.emailAddress ,
                    decoration: const InputDecoration(
                      label:Text('Email Address') ,
                      suffixIcon:Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    validator:(String? value){
                      if(value!.isEmpty){
                        return'Email Address Must Not Be Null';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: phoneController ,
                    keyboardType:TextInputType.phone ,
                    decoration: const InputDecoration(
                      label:Text('Phone') ,
                      suffixIcon:Icon(Icons.phone),
                      border: OutlineInputBorder(),
                    ),
                    validator:(String? value){
                      if(value!.isEmpty){
                        return'Phone Must Not Be Null';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: double.infinity,
                    color:default_color,
                    child: MaterialButton(
                      onPressed: (){
                        if(formKey.currentState!.validate()){
                          ShopCubit.get(context).updateUser(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text
                          );
                        }
                      },
                      child:Text(
                        'update'.toUpperCase(),
                      ), ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: double.infinity,
                    color:default_color,
                    child: MaterialButton(
                      onPressed: (){
                          if(formKey.currentState!.validate()){
                            ShopCubit.get(context).logout(context);
                          }
                      },
                      child:Text(
                        'logout'.toUpperCase(),
                      ), ),
                  )
                ],
              ),
            ),
          ),
        ),
        fallback:(context)=>const Center(child: CircularProgressIndicator()) ,
      );},
    );
  }
}
