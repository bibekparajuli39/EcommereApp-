import 'package:nana/features/product/models/product/datum.dart';

class CartItemModel {
  final Datum product;
  final int quantity;

  CartItemModel({required this.product, required this.quantity});
  CartItemModel copyWith({Datum? product, int? quantity}) {
    return CartItemModel(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  double get subtotalPrice {
    return product.price! * quantity;
  }
}
