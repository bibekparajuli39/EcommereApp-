import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nana/features/cart/models/cart_item_model.dart';
import 'package:nana/features/product/models/product/datum.dart';

class CartRepositories {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  CartRepositories(this.firestore, this.auth);

  CollectionReference<Map<String, dynamic>> get cartCollection {
    final user = auth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in');
    }

    return firestore.collection('users').doc(user.uid).collection('cart');
  }

  Future<List<CartItemModel>> getCartItems() async {
    final snapshot = await cartCollection.get();

    return snapshot.docs.map((doc) {
      final data = doc.data();

      final product = Datum(
        id: data['productId'],
        title: data['title'],
        price: (data['price'] as num?)?.toDouble(),
        image: data['image'],
        description: data['description'],
        category: data['category'],
      );

      return CartItemModel(
        product: product,
        quantity: (data['quantity'] as num?)?.toInt() ?? 1,
      );
    }).toList();
  }

  Future<void> addToCart(Datum product, {int quantity = 1}) async {
    final productId = product.id.toString();
    final cartDoc = cartCollection.doc(productId);

    final existingItem = await cartDoc.get();

    if (existingItem.exists) {
      final data = existingItem.data();

      final currentQuantity = (data?['quantity'] as num?)?.toInt() ?? 0;

      await cartDoc.update({'quantity': currentQuantity + quantity});
    } else {
      await cartDoc.set({
        'productId': product.id,
        'title': product.title,
        'price': product.price,
        'image': product.image,
        'description': product.description,
        'category': product.category,
        'quantity': quantity,
      });
    }
  }

  Future<void> removeCart(int productId) async {
    await cartCollection.doc(productId.toString()).delete();
  }

  Future<void> increaseQuantity(int productId) async {
    final cartDoc = cartCollection.doc(productId.toString());

    final snapshot = await cartDoc.get();

    if (!snapshot.exists) {
      return;
    }

    final data = snapshot.data();

    final currentQuantity = (data?['quantity'] as num?)?.toInt() ?? 1;

    await cartDoc.update({'quantity': currentQuantity + 1});
  }

  Future<void> decreaseQuantity(int productId) async {
    final cartDoc = cartCollection.doc(productId.toString());

    final snapshot = await cartDoc.get();

    if (!snapshot.exists) {
      return;
    }

    final data = snapshot.data();

    final currentQuantity = (data?['quantity'] as num?)?.toInt() ?? 1;

    if (currentQuantity > 1) {
      await cartDoc.update({'quantity': currentQuantity - 1});
    } else {
      await cartDoc.delete();
    }
  }

  Future<void> clearCart() async {
    final snapshot = await cartCollection.get();

    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  Future<double> getTotalPrice() async {
    final items = await getCartItems();

    return items.fold<double>(0.0, (total, item) {
      return total + item.subtotalPrice;
    });
  }
}
