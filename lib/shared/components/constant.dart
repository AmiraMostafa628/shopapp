/*
{
"email": "amira.mostafa@gmail.com",
"password": "123456"
}*/


import 'package:all_tests/modules/shop_app/login/loginScreen.dart';
import 'package:all_tests/shared/network/local/cache_helper.dart';

import 'components.dart';

void signOut({context}){

  CacheHelper.removeData(key: 'token',).then((value) {
    if (value) {
      navigateAndFinish(context, ShopLoginScreen(),);
    }
  });
}


void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

var token ;



