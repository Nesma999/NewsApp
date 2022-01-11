import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/search.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class NewsAppLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppCubitStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title:const Text('News App'),
              actions: [
                IconButton(
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchScreen()));
                    },
                    icon: const Icon(Icons.search),
                ),
                IconButton(
                  onPressed: (){
                    AppCubit.get(context).changAppMode();
                  },
                  icon: const Icon(Icons.brightness_4_outlined),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: AppCubit.get(context).items,
              currentIndex: AppCubit.get(context).current_index,
              onTap: (index) {
                AppCubit.get(context).changeBottomNavigation(index);
              },
            ),
            body: AppCubit.get(context)
                .screens[AppCubit.get(context).current_index],
          );
        },

    );
  }
}
