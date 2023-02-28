import 'dart:io';
import 'package:all_tests/layout/shopLayout.dart';
import 'package:all_tests/shared/cubit/shop_cubit.dart';
import 'package:all_tests/shared/cubit/states.dart';
import 'package:all_tests/shared/network/local/cache_helper.dart';
import 'package:all_tests/shared/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'modules/shop_app/login/loginScreen.dart';
import 'modules/shop_app/on_Boarding/onBoardingScreen.dart';
import 'shared/blocObserver.dart';
import 'shared/components/constant.dart';
import 'shared/network/style/theme.dart';

void main()async {

  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  dynamic isDark= CacheHelper.getData(key: 'isDark');
  print(isDark);
  late Widget widget;

  bool? onBoarding=CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');

  print(token);

  if(onBoarding == true)
  {
    if(token != null) {
     widget =ShopLayoutScreen();
    }
    else {
      widget = ShopLoginScreen();
    }
  }else {
    widget = OnBoardingScreen();
  }

  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp(startWidget:widget,isDark: isDark,));


}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

class MyApp extends StatelessWidget {

  final Widget? startWidget;
  final dynamic isDark;

  MyApp({this.startWidget,this.isDark});
  Widget build(BuildContext context) {
        return BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()..getCategories()..getFavorites()..getUserData()..changeMode(fromShared: isDark),
          child: BlocConsumer<ShopCubit,ShopStates>(
            listener: (context,state){},
            builder: (context,state){
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: lightTheme,
                darkTheme:darkTheme,
                themeMode: ShopCubit.get(context).isDark==true?ThemeMode.dark:ThemeMode.light,
                home:startWidget,
              );
            },
          ),
        );



    }
  }

