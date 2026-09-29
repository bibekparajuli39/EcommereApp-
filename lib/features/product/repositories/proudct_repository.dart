import 'package:nana/core/networks/api_end_point.dart';
import 'package:nana/core/services/api_service.dart';
import 'package:nana/features/product/models/product/datum.dart';

class ProudctRepository {
  final ApiService _apiService;

  ProudctRepository(this._apiService);

  Future<List<Datum>> getProducts() async {
    final response = await _apiService.get(ApiEndPoint.product);
    final Map<String, dynamic> data = response.data;
    return (data['data'] as List)
        .map((json) => Datum.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
