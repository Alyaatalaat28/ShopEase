//POST
// UPDATE
// DELETE
// GET
// base url : https://newsapi.org/
// method (url) : v2/top-headlines?
// queries : country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca
// https://newsapi.org/v2/everything?q=tesla&apiKey=65f7f556ec76449fa7dc7c0069f040ca
//https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=ce3bd33275b44866ae895b0838532800
//https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=ce3bd33275b44866ae895b0838532800



void printFullText(String text){
  final pattern=RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match)=>print(match.group(0)));
}
String token ='';
String? uId ;
// if(!FirebaseAuth.instance.currentUser!.emailVerified)
//    Container(
//   color: Colors.amber.withOpacity(0.8),
//   padding: EdgeInsets.symmetric(
//     horizontal: 20.0,
//   ),
//   child: Row(
//       children:[
//         Icon(Icons.info_outline),
//         SizedBox(width: 15.0,),
//         Text('please verify your email'),
//         Spacer(),
//         TextButton(
//             onPressed: (){
//               FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value) {
//                 showToast(text: 'check your mail', state: ToastStates.SUCCESS);
//               }).catchError((error){
//                 print(error.toString());
//               });
//
//             },
//             child: Text('Send'.toUpperCase(),
//               style: TextStyle(color: Colors.blue,),)),
//       ]
//   ),
// ),




