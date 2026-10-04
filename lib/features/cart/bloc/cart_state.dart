import 'package:nana/features/cart/models/cart_item_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemModel> items;
  final String? promocode;
  final double discount;
  final String? promoError;

  CartLoaded(this.items, {this.promocode, this.discount = 0, this.promoError});
}

class CartError extends CartState {
  final String message;

  CartError(this.message);
}
