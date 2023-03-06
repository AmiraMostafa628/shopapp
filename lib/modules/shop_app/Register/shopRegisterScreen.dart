import 'package:all_tests/layout/shopLayout.dart';
import 'package:all_tests/modules/shop_app/Register/Register_cubit/register_cubit.dart';
import 'package:all_tests/modules/shop_app/Register/Register_cubit/states.dart';
import 'package:all_tests/modules/shop_app/login/loginScreen.dart';
import 'package:all_tests/shared/components/components.dart';
import 'package:all_tests/shared/components/constant.dart';
import 'package:all_tests/shared/cubit/shop_cubit.dart';
import 'package:all_tests/shared/network/local/cache_helper.dart';
import 'package:all_tests/shared/network/style/color.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class ShopRegisterScreen extends StatelessWidget {

  var formKey= GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context,state){
          if(state is ShopRegisterSuccessState){
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
                ShopCubit.get(context).getHomeData();
                ShopCubit.get(context).getCategories();
                ShopCubit.get(context).getFavorites();
                ShopCubit.get(context).getCarts();

                navigateAndFinish(
                    context, ShopLayoutScreen()
                );
              }
              );

            }
            else
            {
              print(state.loginModel.message);

              showToast(
                  text: state.loginModel.message,
                  state: ToastState.ERROR);
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
                        Text('Sign up',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: ShopCubit.get(context).isDark?Colors.white:HexColor('333739'),
                                fontSize: 25.0
                            )
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: ( value)
                            {
                              if (value!.isEmpty) {
                                return 'name must not be Empty';
                              }
                            },
                            label: 'UserName',
                            prefix: Icons.person),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: ( value)
                            {
                              if (value!.isEmpty) {
                                return 'Email must not be Empty';
                              }
                            },
                            label: 'Email Address',
                            prefix: Icons.email_outlined),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          isPassword: ShopRegisterCubit.get(context).ispassword,
                          suffixPressed: (){
                            ShopRegisterCubit.get(context).changePasswordVisibility();
                          },
                          validate: ( value)
                          {
                            if (value!.isEmpty) {
                              return 'password is too short';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock,
                          suffix: ShopRegisterCubit.get(context).suffix,

                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: ( value)
                            {
                              if (value!.isEmpty) {
                                return 'phone must not be Empty';
                              }
                            },
                            label: 'Phone',
                            prefix: Icons.phone),

                        SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          condition: true,
                          builder: (context)=>defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  ShopRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                    context: context
                                  );
                                }
                              },
                              background: defaultColor,
                              text: 'Sign up'
                          ) ,
                          fallback: (context)=>Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                            ),
                            defaultTextButten(
                                function:(){
                                  NavigateTo(
                                      context,
                                      ShopLoginScreen());
                                },
                                color: defaultColor,
                                text: 'Login')
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

