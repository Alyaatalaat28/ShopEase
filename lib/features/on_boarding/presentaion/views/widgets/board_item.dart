// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '../../../data/onboarding_model.dart';

class BoardItem extends StatelessWidget {
   BoardItem({super.key,required this.model});
  BoardingModel model;
  @override
  Widget build(BuildContext context) {
    return  Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Expanded(
  child: Image(
  image: AssetImage(model.image),
  ),
  ),
  Text(
  '${model.title}',
  style: const TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
  ),
  ),
  const SizedBox(
  height: 15.0,
  ),
  Text(
  model.body,
  style: const TextStyle(
  fontSize: 14.0,
  ),
  ),
    const SizedBox(
      height: 60,
    ),


  ],
  );
}

  }
