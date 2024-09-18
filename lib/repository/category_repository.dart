import 'package:fv_frontend_task/constants/mock_responses.dart';
import 'package:fv_frontend_task/models/category_model.dart';

class CategoryRepository {
  Future<CategoryList> fetchCategories() async {
    await Future.delayed(const Duration(seconds: 1));
    return CategoryList.fromJson(categories);
  }
}
