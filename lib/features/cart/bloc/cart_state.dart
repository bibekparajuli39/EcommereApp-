import 'package:app_project/features/cart/models/cart_item_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemModel> items;
  final String? promocode;
  final double discount;

  CartLoaded({this.promocode, this.discount = 0, required this.items});
}

class CartError extends CartState {
  final String message;

  CartError(this.message);
}
