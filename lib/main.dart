import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'modules/shop_app/on_Boarding/onBoardingScreen.dart';
import 'shared/blocObserver.dart';
import 'shared/network/style/theme.dart';

void main()async {

  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

        return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme:darkTheme,
              home:OnBoardingScreen(),
            );



    }
  }

