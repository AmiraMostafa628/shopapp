import 'dart:io';

import 'package:all_tests/shared/components/components.dart';
import 'package:all_tests/shared/components/constant.dart';
import 'package:all_tests/shared/cubit/shop_cubit.dart';
import 'package:all_tests/shared/cubit/states.dart';
import 'package:all_tests/shared/network/style/color.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class SettingScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  
  var formKey=GlobalKey<FormState>();


  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var model = ShopCubit.get(context).userModel;
            nameController.text = model!.data!.name!;
            emailController.text = model.data!.email!;
            phoneController.text = model.data!.phone!;



        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context)=>Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: TextButton(
                      onPressed: (){
                        if(formKey.currentState!.validate())
                        {
                          ShopCubit.get(context).updateData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,

                          );
                        }
                      },
                      child: Text('Update',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: defaultColor
                        ),
                      ),),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if(state is ShopLoadingUpdateUserDataState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                        controller: nameController,
                        color: defaultColor,
                        type: TextInputType.text,
                        validate: (value)
                        {
                          if(value!.isEmpty)
                            return 'name must not be empty';
                        },
                        label: 'Name',
                        prefix: Icons.person
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                        controller: emailController,
                        color: defaultColor,
                        type: TextInputType.emailAddress,
                        validate: (value)
                        {
                          if(value!.isEmpty)
                            return 'email must not be empty';
                        },
                        label: 'Email',
                        prefix: Icons.email
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                        controller: phoneController,
                        color: defaultColor,
                        type: TextInputType.phone,
                        validate: (value)
                        {
                          if(value!.isEmpty)
                            return 'phone must not be empty';
                        },
                        label: 'Phone',
                        prefix: Icons.phone
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
