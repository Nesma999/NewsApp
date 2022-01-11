abstract class AppCubitStates{}

class AppInitialState extends AppCubitStates{}

class AppChangeBottomNavigationState extends AppCubitStates{}

class NewsGetBusinessSuccessState extends AppCubitStates{}

class NewsGetBusinessErrorState extends AppCubitStates{
  late final String error;
  NewsGetBusinessErrorState(this.error);
}

class NewsLoadingBusinessState extends AppCubitStates{}

class NewsGetSportSuccessState extends AppCubitStates{}

class NewsGetSportErrorState extends AppCubitStates{
  late final String error;
  NewsGetSportErrorState(this.error);
}

class NewsLoadingSportState extends AppCubitStates{}

class NewsGetScienceSuccessState extends AppCubitStates{}

class NewsGetScienceErrorState extends AppCubitStates{
  late final String error;
  NewsGetScienceErrorState(this.error);
}

class NewsLoadingScienceState extends AppCubitStates{}

class NewsGetSearchSuccessState extends AppCubitStates{}

class NewsGetSearchErrorState extends AppCubitStates{
  late final String error;
  NewsGetSearchErrorState(this.error);
}

class NewsLoadingSearchState extends AppCubitStates{}


class NewsChangeThemeState extends AppCubitStates{}