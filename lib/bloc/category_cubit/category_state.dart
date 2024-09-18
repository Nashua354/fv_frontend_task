part of 'category_cubit.dart';

class CategoryState {}

class CategoryInitialState extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryLoadedState extends CategoryState {
  List<CategoryModel> categories;
  CategoryLoadedState(this.categories);
}

class CategoryErrorState extends CategoryState {}
