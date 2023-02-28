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
          builder: (context)=>Padding(
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
                  defaultFormField(
                      controller: nameController,
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
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            if(formKey.currentState!.validate())
                            {
                              ShopCubit.get(context).updateData(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text);
                            }
                          },
                          child: Container(
                            height: 60,
                            child: Row(
                              children: [
                                Icon(Icons.update,color: defaultColor),
                                SizedBox(
                                  width: 15.0,
                                ),
                                Text('Update',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: defaultColor
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            signOut(context: context);
                          },
                          child: Container(
                            height: 60,
                            child: Row(
                              children: [
                                Icon(Icons.logout_outlined,color: defaultColor),
                                SizedBox(
                                  width: 15.0,
                                ),
                                Text('Log Out',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: defaultColor
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
