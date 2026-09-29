import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nana/features/product/bloc/product_event.dart';
import 'package:nana/features/product/bloc/product_state.dart';
import 'package:nana/features/product/repositories/proudct_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProudctRepository _repository;

  ProductBloc(this._repository) : super(ProductInitial()) {
    on<GetProducts>((event, emit) async {
      emit(ProductLoading());

      try {
        final response = await _repository.getProducts();

        emit(FetchProduct(response));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
  }
}
