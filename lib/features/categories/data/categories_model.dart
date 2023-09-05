class CategoriesModel{
  bool? status;
  CategoriesDataModel? data;
  CategoriesModel.fromjson(Map<String,dynamic>json){
    status = json['status'];
    data=json['data']!=null?CategoriesDataModel.fromjson(json['data']):null;
  }
}
class CategoriesDataModel{
  List<DataModel> data=[];
  // ignore: non_constant_identifier_names
  int? current_page;
  CategoriesDataModel.fromjson(Map<String,dynamic>json){
    current_page=json['current_page'];
    json['data'].forEach((e)=>
      data.add(DataModel.fromjson(e))
    );
  }
}
class DataModel{
  int? id;
  String? name;
  String? image;
  DataModel.fromjson(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}