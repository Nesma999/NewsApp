import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

import 'layout/cubit/cubit.dart';
import 'layout/cubit/cubit_observe.dart';
import 'layout/cubit/states.dart';
import 'layout/newsAppBottomNavigation.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    ()async {
      DioHelper.init();
       await CacheHelper.init();
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool? isDark=CacheHelper.getBoolean(key: 'isDark');
    return BlocProvider(
        create: (BuildContext context) => AppCubit()..getBusiness()..changAppMode(fromShared: isDark),
        child: BlocConsumer<AppCubit, AppCubitStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.deepOrange,
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: const AppBarTheme(
                    backgroundColor: Colors.white,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark,
                    ),
                    elevation: 0.0,
                    titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    iconTheme: IconThemeData(color: Colors.black)),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.deepOrange,
                    elevation: 30.0),
                floatingActionButtonTheme: const FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange,
                ),
                textTheme: const TextTheme(
                  bodyText1: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                  bodyText2: TextStyle(
                      fontSize: 18,
                      color: Colors.grey),
                ),
              ),
              darkTheme: ThemeData(
                primarySwatch: Colors.deepOrange,
                scaffoldBackgroundColor: HexColor('333739'),
                appBarTheme: AppBarTheme(
                  backgroundColor: HexColor('333739'),
                  elevation: 0.0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: HexColor('333739'),
                    statusBarIconBrightness: Brightness.light,
                  ),
                  titleTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  iconTheme: const IconThemeData(color: Colors.white),
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  backgroundColor: HexColor('333739'),
                  unselectedItemColor: Colors.grey,
                  elevation: 30.0,
                ),
                textTheme: const TextTheme(
                  bodyText1: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                  bodyText2: TextStyle(
                      fontSize: 18,
                      color: Colors.grey),
                ),
              ),
              themeMode: AppCubit.get(context).isDark? ThemeMode.dark : ThemeMode.light,
              home: NewsAppLayout(),
            );
          },
        ),
    );
  }
}
