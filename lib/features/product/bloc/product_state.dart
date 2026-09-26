import 'package:app_project/features/product/models/product_model/product_model.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}

class FetchProduct extends ProductState {
  final List<ProductModel> product;

  FetchProduct(this.product);
}
