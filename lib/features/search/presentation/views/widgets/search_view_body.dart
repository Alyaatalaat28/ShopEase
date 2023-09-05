import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/features/search/presentation/views/widgets/search_item.dart';

import '../../../manager/cubit/cubit.dart';
import '../../../manager/cubit/states.dart';

// ignore: must_be_immutable
class SearchViewBody extends StatelessWidget {
   SearchViewBody({super.key});
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
                  decoration: const InputDecoration(
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
                const SizedBox(height: 10.0,),
                if(state is SearchLoadingState)
                  const LinearProgressIndicator(),
                if(state is SearchSuccessState)
                   Expanded(
                  child: ListView.separated(
                       physics: const BouncingScrollPhysics(),
                      itemBuilder:(context,index)=>SearchItem(model:SearchCubit.get(context).model!.data!.data![index],isOldPrice: false),
                      separatorBuilder:(context,index)=> const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: SizedBox(
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

  }
