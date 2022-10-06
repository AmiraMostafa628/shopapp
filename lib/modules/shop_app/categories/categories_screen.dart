import 'package:all_tests/models/shop_model/categories_model.dart';
import 'package:all_tests/shared/components/components.dart';
import 'package:all_tests/shared/cubit/shop_cubit.dart';
import 'package:all_tests/shared/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {

  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
          return ListView.separated(
              itemBuilder: (context,index)=>buildCatItem(ShopCubit.get(context).categoriesModel!.data!.data[index]),
              separatorBuilder: (context,index)=> myDivider(),
              itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length);
        },
        );
  }


  Widget buildCatItem(DataModel model)=>Padding(
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
          style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold
          ),
        ),
        Spacer(),
        Icon(
            Icons.arrow_forward_ios),

      ],
    ),
  );

}
