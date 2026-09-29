import 'package:nana/features/product/models/product/datum.dart';

abstract class CartEvent {}

class LoadCart extends CartEvent {}

// it added the item in cart

class AddToCart extends CartEvent {
  final Datum product;
  final int quantity;

  AddToCart(this.product, {this.quantity = 1});
}

// It removes item from cart
class RemoveFromCart extends CartEvent {
  final int productId;

  RemoveFromCart(this.productId);
}

// Increases the quantity
class IncreaseQuantity extends CartEvent {
  final int productId;

  IncreaseQuantity(this.productId);
}

class DecreaseQuantity extends CartEvent {
  final int productId;

  DecreaseQuantity(this.productId);
}

class PromoCode extends CartEvent {
  final String promocode;

  PromoCode(this.promocode);
}
