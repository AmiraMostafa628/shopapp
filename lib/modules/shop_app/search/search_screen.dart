import 'package:all_tests/modules/shop_app/search/cubit/searchCubit.dart';
import 'package:all_tests/modules/shop_app/search/cubit/states.dart';
import 'package:all_tests/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();
  var formKey =GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> ShopSearch(),
      child: BlocConsumer<ShopSearch,SearchStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                        controller: searchController,
                        type: TextInputType.text,
                        validate: (value)
                        {
                          if(value.isEmpty)
                            return 'Enter text to search';
                        },
                        onSubmit:(text)
                        {
                           ShopSearch.get(context).SearchProduct(text);
                        },
                        label: 'Search',
                        prefix: Icons.search
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    if(state is SearchLoadingStates)
                         LinearProgressIndicator(),

                    if(state is SearchSuccessStates)
                        Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context,index)=>buildListItem(ShopSearch.get(context).model!.data!.data[index],context,isfavScreen:false),
                          separatorBuilder: (context,index)=> myDivider(),
                          itemCount: ShopSearch.get(context).model!.data!.data.length,
                        ),
                        ),



                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
