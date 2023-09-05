class HomeModel{
  bool? status ;
  HomeData? data;
  // named constructor
 HomeModel.fromJson(Map<String,dynamic>json){
   status=json['status'];
   data=json['data']!=null? HomeData.FromJson(json['data']):null;
 }
}
class HomeData{
   List<BannerModel>banners=[];
   List<ProductModel>products=[];
  // ignore: non_constant_identifier_names
  HomeData.FromJson(Map<String,dynamic>json){
    if(json['banners']!=null){
       json['banners'].forEach((element){
         banners.add(BannerModel.FromJson(element));
    });}
    if(json['products']!=null){
        json['products'].forEach((element){
          products.add(ProductModel.FromJson(element));
    });}
  }
}
class BannerModel{
  int? id;
  String? images;
  BannerModel.FromJson(Map<String,dynamic>json){
    id=json['id'];
    images=json['image'];
  }
}
class ProductModel{
  int?id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? name;
  String? image;
  bool? inFavorites;
  bool? inCart;

  ProductModel.FromJson(Map<String,dynamic>json){
  id = json['id'];
  price = json['price'];
  oldPrice = json['old_price'];
  discount = json['discount'];
  image = json['image'];
  name = json['name'];
  inFavorites = json['in_favorites'];
  inCart = json['in_cart'];

}
}