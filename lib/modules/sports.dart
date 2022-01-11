import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class SportsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return BlocConsumer<AppCubit, AppCubitStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var list=AppCubit.get(context).sports;
          return articleBuilder(list);
        });
  }
}
