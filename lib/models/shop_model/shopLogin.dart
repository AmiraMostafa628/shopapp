class ShopLoginModel{
  bool? status;
  String? message;
  UserData? data;
  ShopLoginModel.fromJson(Map<String,dynamic> json)
  {
    status=json['status'];
    message=json['message'];
    data= json['data'] != null ? UserData.fromJson(json['data']):null;
  }
}

class UserData{
  int? id;
  String? phone;
  String? email;
  String? image;
  int? credit;
  String? name;
  int? point;
  String? token;

  UserData.fromJson(Map<String,dynamic> json)
  {
    id=json['id'];
    name=json['name'];
    phone=json['phone'];
    email=json['email'];
    image=json['image'];
    credit = json['credit'];
    point=json['point'];
    token=json['token'];


  }
}