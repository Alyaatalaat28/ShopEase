import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences?sharedpreferences;
  static init()async {
    sharedpreferences = await SharedPreferences.getInstance();
  }
 static Future<bool?> putBoolean({
  required key ,
    required value ,
})async {
   return await sharedpreferences?.setBool(key, value);
  }
  static bool? getBoolean({
    required key ,
  }) {
    return  sharedpreferences?.getBool(key);
  }

  static Future<bool?> saveData({
  required key ,
    required value,
})async{
    if(value is String) return await sharedpreferences?.setString(key, value);
    if(value is int)return await sharedpreferences?.setInt(key, value);
    if(value is bool)return await sharedpreferences?.setBool(key,value);
    return await sharedpreferences?.setDouble(key, value);
  }
  static dynamic getData({
  required key,
}){
    return sharedpreferences?.get(key);
  }
  static Future<bool> removeData({
    required String key,
  })async{
    return await sharedpreferences!.remove(key);
  }
}