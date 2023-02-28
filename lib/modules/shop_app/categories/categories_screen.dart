import 'package:all_tests/models/shop_model/categories_model.dart';
import 'package:all_tests/shared/components/components.dart';
import 'package:all_tests/shared/cubit/shop_cubit.dart';
import 'package:all_tests/shared/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../shared/components/constant.dart';

class CategoriesScreen extends StatelessWidget {

  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
          return ConditionalBuilder(
            condition: ShopCubit.get(context).categoriesModel != null,
            builder: (context)=>ListView.separated(
                itemBuilder: (context,index)=>buildCatItem(ShopCubit.get(context).categoriesModel!.data!.data[index],context),
                separatorBuilder: (context,index)=> myDivider(),
                itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length),
            fallback: (context)=>Center(child: CircularProgressIndicator()),
          );
        },
        );
  }


  Widget buildCatItem(DataModel model,context)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage('${model.image}'),
          height: 80,
          width: 80,
          fit: BoxFit.cover,

        ),
        SizedBox(
          width: 20,
        ),
        Text(
          '${model.name}',
          style: Theme.of(context).textTheme.bodyText1!,
        ),
        Spacer(),
        Icon(
            Icons.arrow_forward_ios,
          color: ShopCubit.get(context).isDark? Colors.white:HexColor('333739'),

        ),

      ],
    ),
  );

}
