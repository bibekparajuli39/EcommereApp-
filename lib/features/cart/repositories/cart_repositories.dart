import 'package:app_project/features/cart/models/cart_item_model.dart';
import 'package:app_project/features/product/models/product_model/product_model.dart';

class CartRepositories {
  final List<CartItemModel> _items = [];

  List<CartItemModel> getCartItems() {
    return List.unmodifiable(_items);
  }

  void addToCart(ProductModel product, {int quantity = 1}) {
    final item = _items.indexWhere((item) => item.product.id == product.id);
    // if product exists
    if (item != -1) {
      _items[item] = _items[item].copyWith(
        quantity: _items[item].quantity + quantity,
      );
    } else {
      // product doesn;t exits then add
      _items.add(CartItemModel(product: product, quantity: quantity));
    }
  }

  void removeCart(int productId) {
    _items.removeWhere((item) => item.product.id == productId);
  }

  void increaseQuantity(int productId) {
    final item = _items.indexWhere((item) => item.product.id == productId);
    if (item != -1) {
      _items[item] = _items[item].copyWith(quantity: _items[item].quantity + 1);
    }
  }

  void decreaseQuantity(int productId) {
    final item = _items.indexWhere((item) => item.product.id == productId);
    if (item != -1) {
      if (_items[item].quantity > 1) {
        _items[item] = _items[item].copyWith(
          quantity: _items[item].quantity - 1,
        );
      } else {
        _items.removeAt(item);
      }
    }
  }

  double getTotalPrice() {
    return _items.fold(0, (total, item) {
      return total + item.subtotalPrice;
    });
  }
}
