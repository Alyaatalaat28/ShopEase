import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../login/login_screen.dart';
import '../shared/components/components.dart';
import '../shared/network/local/cache_helper.dart';
import '../shared/styles/colors.dart';

class BoardingModel{
  late final String image ;
  late final String? title ;
  late final String body ;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  } );

}

class OnBoardingScreen extends StatefulWidget {


  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding =[
    BoardingModel(
        image:'assets/images/onboard_1.png',
        title: 'Welcome',
        body: 'Find your favourite products that you want to buy easily '),
    BoardingModel(
        image: 'assets/images/onboard_2.png',
        title:'Choose in-store pick-up ',
        body: 'Find your favourite products that you want to buy easily'),
    BoardingModel(
        image:'assets/images/onboard_3.png',
        title:'Purchase your items online ',
        body: 'Find your favourite products that you want to buy easily'),

  ];
  bool isLast=false;
  void onSubmit(){
    CacheHelper.saveData(key: 'isBoarding', value: true).then((value) {
      if(value!){
        navigateAndFinish(context,ShopLoginScreen() );
      }
    });

  }

  var boardController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed:(){
                onSubmit();
              },
              child: Text('SKIP'),)
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
                physics:BouncingScrollPhysics() ,
                itemBuilder: (context , index)=>buildingBoardItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller:  boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 4,
                    spacing: 5,
                    activeDotColor: default_color ,
                  ),

                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(isLast){
                      onSubmit();
                    }
                    else{
                      boardController.nextPage(duration:Duration(
                        milliseconds: 720,
                      ) , curve:Curves.fastLinearToSlowEaseIn );
                    }
                    },


                  child: Icon(
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

  Widget buildingBoardItem(BoardingModel model) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Expanded(
  child: Image(
  image: AssetImage('${model.image}'),
  ),
  ),
  Text(
  '${model.title}',
  style: TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
  ),
  ),
  SizedBox(
  height: 15.0,
  ),
  Text(
  '${model.body}',
  style: TextStyle(
  fontSize: 14.0,
  ),
  ),
    SizedBox(
      height: 60,
    ),


  ],
  );
}
