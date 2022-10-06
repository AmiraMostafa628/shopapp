class SearchModel {
  bool? status;
  Data? data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? currentPage;
  List<Product> data=[];


  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
      json['data'].forEach((element) {
        data.add(Product.fromJson(element));
      });


  }

}
class Product {
  int? id;
  dynamic price;
  int? discount;
  String? image;
  String? name;
  String? description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

}
