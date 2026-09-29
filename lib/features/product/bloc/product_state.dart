import 'package:nana/features/product/models/product/datum.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}

class FetchProduct extends ProductState {
  final List<Datum> product;

  FetchProduct(this.product);
}
