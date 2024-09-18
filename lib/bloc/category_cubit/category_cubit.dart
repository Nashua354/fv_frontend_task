import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fv_frontend_task/models/category_model.dart';
import 'package:fv_frontend_task/repository/category_repository.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitialState());
  final CategoryRepository _repo = CategoryRepository();

  fetchCategories() async {
    emit(CategoryLoadingState());
    CategoryList result = await _repo.fetchCategories();
    if (result.categories != null) {
      emit(CategoryLoadedState(result.categories!));
    } else {
      emit(CategoryErrorState());
    }
  }
}
