import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../categories/data/categories_model.dart';
import '../../../data/home_model.dart';

// ignore: must_be_immutable
class ProductBuilder extends StatelessWidget {
   ProductBuilder({super.key,required this.model,required this.model2});
  HomeModel model;
  CategoriesModel model2;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
    physics:const BouncingScrollPhysics(),
    child: Column(
      children: [
        CarouselSlider(
          items:model.data!.banners.map((e) =>Image(
            image: NetworkImage('${e.images}'),
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          ).toList() ,
          options: CarouselOptions(
            height: 250.0,
            initialPage: 0,
            enableInfiniteScroll: true,
            viewportFraction: 1.0,
            reverse: false,
            autoPlay: true,
            autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,

          ),),
        const SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Categories',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 100.0,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context,index)=>buildCategoryItem(model2.data!.data[index]),
                    separatorBuilder: (context,index)=>const SizedBox(width:20.0,),
                    itemCount:model2.data!.data.length ),
              ),
              const Text('New Products',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1/1.72,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,


            children: List.generate(model.data!.products.length,
                    (index) =>buildGridProduct(model.data!.products[index],context)),

          ),
        ),
      ]
    ),
  );

     
  }
}