import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget myDivider()=> Padding(
  padding: const EdgeInsets.all(20.0),
  // ignore: sized_box_for_whitespace
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

// ignore: constant_identifier_names
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
