import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../core/utils/cache_helper.dart';
import '../../../../../core/utils/components.dart';
import '../../../../../core/utils/styles/colors.dart';
import '../../../../login/presentation/views/login_view.dart';
import 'board_item.dart';
import 'onboarding_list.dart';

class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key});

  @override
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();
}

class _OnboardingViewBodyState extends State<OnboardingViewBody> {
  bool isLast=false;
  void onSubmit(){
    CacheHelper.saveData(key: 'isBoarding', value: true).then((value) {
      if(value!){
        navigateAndFinish(context,const ShopLoginScreen() );
      }
    });

  }
  var boardController = PageController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed:(){
                onSubmit();
              },
              child: const Text('SKIP'),)
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                onPageChanged: (index){
                  if(index==boarding.length-1){
                    setState(() {
                      isLast = true;
                    }
                    );
                  }else{
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics:const BouncingScrollPhysics() ,
                itemBuilder: (context , index)=>BoardItem(model:boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller:  boardController,
                  count: boarding.length,
                  effect:  const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 4,
                    spacing: 5,
                    activeDotColor: default_color ,
                  ),

                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(isLast){
                      onSubmit();
                    }
                    else{
                      boardController.nextPage(duration:const Duration(
                        milliseconds: 720,
                      ) , curve:Curves.fastLinearToSlowEaseIn );
                    }
                    },


                  child: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),

          ],
        ),
      ),

    );
  }
  }
