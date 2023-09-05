import 'package:flutter/material.dart';

import '../../../data/categories_model.dart';

// ignore: must_be_immutable
class CategorisItem extends StatelessWidget {
   CategorisItem({super.key,required this.model});
  DataModel model;
  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(image: NetworkImage('${model. image}'),
        width: 80.0,
          height: 80.0,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          width: 20.0,
        ),
        Text('${model.name}',
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        const Icon(
          Icons.arrow_forward_ios
        ),
      ],
    ),
  );
}

  
}