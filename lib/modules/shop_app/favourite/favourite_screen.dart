import 'package:all_tests/models/shop_model/favorites_model.dart';
import 'package:all_tests/shared/components/components.dart';
import 'package:all_tests/shared/cubit/shop_cubit.dart';
import 'package:all_tests/shared/cubit/states.dart';
import 'package:all_tests/shared/network/style/color.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class favoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition: state is ! ShopLoadingGetFavoritesState,
          builder: (context)=>ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context,index)=>buildListItem(ShopCubit.get(context).favoritesModel!.data!.data[index].product,context),
            separatorBuilder: (context,index)=> myDivider(),
            itemCount: ShopCubit.get(context).favoritesModel!.data!.data.length,
          ),
          fallback:(context) =>Center(child: CircularProgressIndicator()),
        );
      },
    );

  }
}
