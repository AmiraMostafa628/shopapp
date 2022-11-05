import 'package:all_tests/layout/shopLayout.dart';
import 'package:all_tests/modules/shop_app/Register/shopRegisterScreen.dart';
import 'package:all_tests/shared/components/components.dart';
import 'package:all_tests/shared/components/constant.dart';
import 'package:all_tests/shared/cubit/shop_cubit.dart';
import 'package:all_tests/shared/network/local/cache_helper.dart';
import 'package:all_tests/shared/network/style/color.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:toast/toast.dart';
import 'Login_cubit/Login_cubit.dart';
import 'Login_cubit/states.dart';

class ShopLoginScreen extends StatelessWidget {

  var formKey= GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return  BlocProvider(
      create: (BuildContext context)=>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state){
          if(state is ShopLoginSuccessState){
            if(state.loginModel.status!)
            {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);


              CacheHelper.saveData(
                  key: 'token',
                  value: state.loginModel.data!.token).then((value)
              {
                token =state.loginModel.data!.token;
                ShopCubit.get(context).currentIndex =0;
                ShopCubit.get(context).getUserData();

                navigateAndFinish(
                    context, ShopLayoutScreen()
                );
              }
              );

            }
            else {
              print(state.loginModel.message);

              showToast(
                  text: state.loginModel.message,
                  state: ToastState.ERROR);

               /*showSnackBar(
                  context,
                  text: state.loginModel.message,
                  state: ToastState.ERROR);*/



            }

          }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                            image:AssetImage('assets/images/login.png',)
                        ),
                        Text('LOGIN',
                            style: Theme.of(context).textTheme.headline4?.copyWith(
                              color: ShopCubit.get(context).isDark? Colors.white:HexColor('333739'),
                            )
                        ),
                        Text('Login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                            controller: emailController,
                            color: ShopCubit.get(context).isDark? Colors.grey[300]:HexColor('333739'),
                            type: TextInputType.emailAddress,
                            validate: ( value)
                            {
                              if (value!.isEmpty) {
                                return 'Email Can not be Empty';
                              }
                            },
                            label: 'Email Address',
                            prefix: Icons.email_outlined),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          color: ShopCubit.get(context).isDark? Colors.grey[300]:HexColor('333739'),
                          type: TextInputType.visiblePassword,
                          isPassword: ShopLoginCubit.get(context).ispassword,
                          onSubmit: (value)
                          {
                            if(formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          suffixPressed: (){
                            ShopLoginCubit.get(context).changePasswordVisibility();
                          },
                          validate: ( value)
                          {
                            if (value!.isEmpty) {
                              return 'password is too short';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock,
                          suffix: ShopLoginCubit.get(context).suffix,
                          iconColor: ShopCubit.get(context).isDark? Colors.grey[300]:HexColor('333739'),

                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context)=>defaultButton(
                              function: (){
                                if(formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              background: defaultColor,
                              text: 'login'),
                          fallback: (context)=>Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: TextStyle(
                                color: ShopCubit.get(context).isDark? Colors.white:HexColor('333739'),
                              ),
                            ),
                            defaultTextButten(
                                function:(){
                                  NavigateTo(
                                      context,
                                      ShopRegisterScreen());
                                },
                                color: defaultColor,
                                text: 'Register')
                          ],
                        )
                      ],

                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}