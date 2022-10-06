import 'dart:convert';

class HomeModel{
  bool? status;
  HomeDataModel? data;

  HomeModel.fromJson(Map<String,dynamic>json)
  {
    status=json['status'];
    data= json['data'] != null ?  HomeDataModel.fromJson(json['data']):null;


  }

}
class HomeDataModel{
  List<BannerModel> banners=[];
  List<ProductModel> products=[];

  HomeDataModel.fromJson(Map<String,dynamic>json)
  {
    json['banners'].forEach((element){
      banners.add(BannerModel.fromJson(element));
    });

    json['products'].forEach((element){
      products.add(ProductModel.fromJson(element));
    });

  }
}

class BannerModel
{
  int? id;
  String? image;
  BannerModel.fromJson(Map<String,dynamic>json)
  {
    id=json['id'];
    image=json['image'];

  }

}

class ProductModel
{
  int? id;
  dynamic? price;
  dynamic? oldPrice;
  dynamic? disCount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;
  ProductModel.fromJson(Map<String,dynamic>json)
  {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    disCount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }

}