import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
     return BlocConsumer<AppCubit, AppCubitStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var list=AppCubit.get(context).search;
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration:InputDecoration(
                      label: Text(
                        'Search',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border:  const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      prefixIcon: const Icon(Icons.search,color: Colors.grey,),
                    ),
                    style:Theme.of(context).textTheme.bodyText2,
                    onChanged: (value){
                      AppCubit.get(context).getSearch(value);
                    },
                  ),
                ),
             Expanded(child: articleBuilder(list,isSearch: true)),
              ],
            ),
          );
        });

  }
}
