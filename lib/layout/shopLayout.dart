import 'package:all_tests/modules/shop_app/search/search_screen.dart';
import 'package:all_tests/modules/shop_app/setting/setting_screen.dart';
import 'package:all_tests/shared/components/components.dart';
import 'package:all_tests/shared/cubit/shop_cubit.dart';
import 'package:all_tests/shared/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/components/constant.dart';


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
                      icon: Icon(Icons.shopping_cart),
                      label: 'cart'
                  ),
                ],
              ),

              drawer: ShopCubit.get(context).userModel!.data != null? Drawer(
                  child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        UserAccountsDrawerHeader(
                            decoration: BoxDecoration(color: Colors.purple),
                            currentAccountPicture: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 50.0,
                              child: Icon(Icons.person_2_outlined,color: Colors.purple,size: 32,),
                            ),
                            accountName: Text(
                              '${ShopCubit.get(context).userModel!.data!.name}',
                              style: TextStyle(color: Colors.white,height: 1.3),),
                            accountEmail: Text(
                                '${ShopCubit.get(context).userModel!.data!.email}',
                                style: TextStyle(color: Colors.white,height: 1.3)
                            )),
                        ListTile(
                          leading: Icon(
                            Icons.account_circle_sharp,
                            color: Colors.purple,
                          ),
                          title: Text("Account"),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.dark_mode_sharp,
                            color: Colors.purple,
                          ),
                          title: Text("Dark mode"),
                          onTap: (){
                            ShopCubit.get(context).changeMode();
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.settings,
                            color: Colors.purple,
                          ),
                          title: Text("Settings"),
                          onTap: () {
                            NavigateTo(context, SettingScreen());
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.logout,
                            color: Colors.purple,
                          ),
                          title: Text("Log Out"),
                          onTap: (){signOut(context: context);},

                        )

                      ])):null,

            );
        },);

  }



}