import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/business.dart';
import 'package:news_app/modules/science.dart';
import 'package:news_app/modules/settings.dart';
import 'package:news_app/modules/sports.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppCubitStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  int current_index = 0;
  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.business_sharp),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
  ];
  List screens = [
    BusinessPage(),
    SportsPage(),
    SciencePage(),
  ];

  void changeBottomNavigation(int index) {
    current_index = index;
    if(index ==1){
      getSports();
    }
    if(index==2){
      getScience();
    }
    emit(AppChangeBottomNavigationState());
  }

  List<dynamic> business = [];
  void getBusiness() {
    emit(NewsLoadingBusinessState());
    DioHelper.getData(path: 'v2/top-headlines', query: {
      'country': 'us',
      'category': 'business',
      'apiKey': '75ed3bf0086741aab7981ce306da8049'
    }).then((value) {
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];
  void getSports() {
    emit(NewsLoadingSportState());
    if(sports.length==0) {
      DioHelper.getData(path: 'v2/top-headlines', query: {
        'country': 'us',
        'category': 'sports',
        'apiKey': '75ed3bf0086741aab7981ce306da8049'
      }).then((value) {
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportErrorState(error.toString()));
      });
    }else{
      emit(NewsGetSportSuccessState());
    }
  }

  List<dynamic> science = [];
  void getScience() {
    emit(NewsLoadingScienceState());
    if(science.length==0)
    {
      DioHelper.getData(path: 'v2/top-headlines', query: {
        'country': 'us',
        'category': 'science',
        'apiKey': '75ed3bf0086741aab7981ce306da8049'
      }).then((value) {
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }
    else{
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];
  void getSearch(String value) {
    emit(NewsLoadingSearchState());
      DioHelper.getData(
          path: 'v2/everything',
          query: {
        'q': value,
        'apiKey': '75ed3bf0086741aab7981ce306da8049'
      }).then((value) {
        search = value.data['articles'];
        emit(NewsGetSearchSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSearchErrorState(error.toString()));
      }
      );
    }
  bool isDark=false;
  void changAppMode({bool? fromShared}){
    if(fromShared != null) {
      isDark=fromShared;
      emit(NewsChangeThemeState());
    }
    else{
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value){
        emit(NewsChangeThemeState());
      }).catchError((error){
        print(error.toString());
      });
    }
  }
}
