import 'package:app_project/core/networks/api_end_point.dart';
import 'package:app_project/core/services/api_service.dart';

import 'package:app_project/features/product/models/product_model/product_model.dart';

class ProudctRepository {
  final ApiService _apiService;

  ProudctRepository(this._apiService);

  Future<List<ProductModel>> getProducts() async {
    final response = await _apiService.get(ApiEndPoint.product);
    final List data = response.data;
    return data.map((e) => ProductModel.fromJson(e)).toList();
  }
}
