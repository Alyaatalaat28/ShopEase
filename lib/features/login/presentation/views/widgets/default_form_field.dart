
import 'package:flutter/material.dart';

import '../../../../../core/utils/styles/colors.dart';

Widget defaultButton({
   double width = double.infinity  ,
   Color background = default_color ,
  required Function function ,
  required String text ,
  bool isUpperCase = true ,
  double radius = 0.0,


}) =>  Container(
  width: width,

  // ignore: sort_child_properties_last
  child: MaterialButton(
    onPressed:() {
      function();
    } ,
    child: Text(
      isUpperCase ? text.toUpperCase() : text ,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color:background,
  ),
);

Widget defaultFormField({
  required TextEditingController controller ,
  required TextInputType type ,
  Function? onSubmit ,
  Function? onChange ,
  required FormFieldValidator<String>? validate ,
  required String label,
  required IconData prefix ,
  VoidCallback? onTap ,
  IconData? suffix ,
  Function? suffixPressed ,

  bool isPassword = false,
  
}) => TextFormField(
controller: controller,
keyboardType: type,
obscureText: isPassword,
onFieldSubmitted:(value){

},
onChanged: (val){

},
validator: validate,
onTap:onTap,
decoration: InputDecoration(
labelText: label,
prefixIcon: Icon(
prefix,
),
suffixIcon: suffix != null ? IconButton(
  onPressed: (){
    suffixPressed!();
  } ,
  icon : Icon(
  
    suffix,
  
  ),
) : null ,
  border: const OutlineInputBorder(),
),

);