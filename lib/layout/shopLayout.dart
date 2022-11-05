import 'package:all_tests/modules/shop_app/search/search_screen.dart';
import 'package:all_tests/shared/components/components.dart';
import 'package:all_tests/shared/cubit/shop_cubit.dart';
import 'package:all_tests/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ShopLayoutScreen extends StatelessWidget {

  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit,ShopStates>(
        listener:(context,state){} ,
        builder: (context,state){
          var cubit = ShopCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Salla',
                ),
                actions: [
                  IconButton(onPressed: (){
                    NavigateTo(context, SearchScreen());
                  }
                      , icon: Icon(Icons.search)),
                  IconButton(
                    onPressed: (){
                      ShopCubit.get(context).changeMode();
                    },
                    icon: Icon(Icons.brightness_4_outlined),
                  ),
                  
                ],
              ),
              body: cubit.bottomScreens[cubit.currentIndex],
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
                      icon: Icon(Icons.settings),
                      label: 'settings'
                  ),
                ],
              )

          );
        },

          );

      }


}