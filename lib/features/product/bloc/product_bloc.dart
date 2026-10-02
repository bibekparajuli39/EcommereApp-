import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nana/features/product/bloc/product_event.dart';
import 'package:nana/features/product/bloc/product_state.dart';
import 'package:nana/features/product/models/product/datum.dart';
import 'package:nana/features/product/repositories/proudct_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProudctRepository _repository;

  static const double usdToNpr = 154.877;

  List<Datum> allProducts = [];

  ProductBloc(this._repository) : super(ProductInitial()) {
    on<GetProducts>((event, emit) async {
      emit(ProductLoading());

      try {
        final response = await _repository.getProducts();

        final List<Datum> convertedProducts = response.map<Datum>((product) {
          return product.copyWith(price: (product.price ?? 0) * usdToNpr);
        }).toList();

        allProducts = convertedProducts;

        emit(FetchProduct(convertedProducts));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    on<SearchProduct>((event, emit) {
      final query = event.query.trim().toLowerCase();

      if (query.isEmpty) {
        emit(FetchProduct(allProducts));
        return;
      }

      final List<Datum> result = allProducts.where((product) {
        final title = product.title?.toLowerCase() ?? '';
        final category = product.category?.toLowerCase() ?? '';
        final type = product.type?.toLowerCase() ?? '';
        final brand = product.brand?.toLowerCase() ?? '';

        return title.contains(query) ||
            category.contains(query) ||
            type.contains(query) ||
            brand.contains(query);
      }).toList();

      emit(FetchProduct(result));
    });
  }
}
