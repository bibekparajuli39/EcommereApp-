import 'package:app_project/features/product/bloc/product_event.dart';
import 'package:app_project/features/product/bloc/product_state.dart';
import 'package:app_project/features/product/repositories/proudct_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProudctRepository _repository;

  ProductBloc(this._repository) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        final response = await _repository.getProducts();
        emit(FetchProduct(response));
      } catch (e) {
        print(e);
      }
    });
  }
}
