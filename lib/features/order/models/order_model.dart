import 'package:nana/features/cart/models/cart_item_model.dart';

class OrderModel {
  final List<CartItemModel> items;
  final double subtotal;
  final double shipping;
  final double total;

  const OrderModel({
    required this.items,
    required this.subtotal,
    required this.shipping,
    required this.total,
  });
}
