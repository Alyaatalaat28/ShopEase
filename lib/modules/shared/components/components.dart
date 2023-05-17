import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

import '../styles/colors.dart';

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
      style: TextStyle(
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
  border: OutlineInputBorder(),
),

);


Widget myDivider()=> Padding(
  padding: const EdgeInsets.all(20.0),
  child:  Container(
    height: 1.0,
    width: 1.0,
  ),
);


void navigateTo(context,widget)=>  Navigator.push(context,
  MaterialPageRoute(
    builder: (context) => widget,
));
void navigateAndFinish(context,widget)=> Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder:(context)=>widget ),
        (route) => false);
void showToast({
  required String text,
  required ToastStates state,
})=>Fluttertoast.showToast(
msg: text,
toastLength: Toast.LENGTH_LONG,
gravity: ToastGravity.BOTTOM,
timeInSecForIosWeb: 5,
backgroundColor: chooseColor(state),
textColor: Colors.white,
fontSize: 16.0,);

enum ToastStates {SUCCESS , ERROR , WARNING}
Color chooseColor(ToastStates state){
  Color color;
  switch(state){
    case ToastStates.SUCCESS:
      color= Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color= Colors.amber;
      break;
  }
  return color;
}
