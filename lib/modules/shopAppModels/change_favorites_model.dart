class ChangeFavoritesModel{
  bool? status;
  String? message;
  ChangeFavoritesModel.fromjson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
  }
}