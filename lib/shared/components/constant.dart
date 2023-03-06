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



/*return Scaffold(
              body: SliderDrawer(
                key: key,
                appBar: SliderAppBar(
                    appBarColor: Colors.white,
                    title: Text('Salla',
                        textAlign: TextAlign.left,
                        style:
                        const TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            height: 1.3)),
                  isTitleCenter:false ,
                  trailing: IconButton(onPressed: (){
                    NavigateTo(context, SearchScreen());
                  }
                      , icon: Icon(Icons.search,color: Colors.black,),

                  ),
                ),
                slider: SliderItem(),
                child: cubit.bottomScreens[cubit.currentIndex]),
              bottomNavigationBar: BottomNavigationBar(
                    onTap: (index)
                    {
                      cubit.changeBottom(index);
                    },
                    currentIndex: cubit.currentIndex ,
                    items: [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home),
                          label: 'Home'
                      ),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.apps),
                          label: 'Categories'
                      ),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.favorite),
                          label: 'favorite'
                      ),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.shopping_cart),
                          label: 'cart'
                      ),
                    ],
                  )
              );*/

