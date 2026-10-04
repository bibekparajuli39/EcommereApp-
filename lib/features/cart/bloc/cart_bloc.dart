import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nana/features/cart/bloc/cart_event.dart';
import 'package:nana/features/cart/bloc/cart_state.dart';
import 'package:nana/features/cart/repositories/cart_repositories.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepositories repository;

  CartBloc(this.repository) : super(CartInitial()) {
    on<LoadCart>(_loadCart);
    on<AddToCart>(_addCart);
    on<RemoveFromCart>(_removeCart);
    on<IncreaseQuantity>(_increaseQuantity);
    on<DecreaseQuantity>(_decreaseQuantity);
    on<PromoCode>(_applyPromoCode);
  }

  Future<void> _loadCart(LoadCart event, Emitter<CartState> emit) async {
    emit(CartLoading());

    try {
      final items = await repository.getCartItems();

      emit(CartLoaded(items, discount: 0));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _addCart(AddToCart event, Emitter<CartState> emit) async {
    try {
      await repository.addToCart(event.product, quantity: event.quantity);

      final items = await repository.getCartItems();

      String? promoCode;
      double discount = 0;

      if (state is CartLoaded) {
        final currentState = state as CartLoaded;

        promoCode = currentState.promocode;
        discount = currentState.discount;
      }

      emit(CartLoaded(items, promocode: promoCode, discount: discount));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _removeCart(
    RemoveFromCart event,
    Emitter<CartState> emit,
  ) async {
    try {
      await repository.removeCart(event.productId);

      final items = await repository.getCartItems();

      String? promoCode;
      double discount = 0;

      if (state is CartLoaded) {
        final currentState = state as CartLoaded;

        promoCode = currentState.promocode;
        discount = currentState.discount;
      }

      emit(CartLoaded(items, promocode: promoCode, discount: discount));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _increaseQuantity(
    IncreaseQuantity event,
    Emitter<CartState> emit,
  ) async {
    try {
      await repository.increaseQuantity(event.productId);

      final items = await repository.getCartItems();

      String? promoCode;
      double discount = 0;

      if (state is CartLoaded) {
        final currentState = state as CartLoaded;

        promoCode = currentState.promocode;
        discount = currentState.discount;
      }

      emit(CartLoaded(items, promocode: promoCode, discount: discount));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _decreaseQuantity(
    DecreaseQuantity event,
    Emitter<CartState> emit,
  ) async {
    try {
      await repository.decreaseQuantity(event.productId);

      final items = await repository.getCartItems();

      String? promoCode;
      double discount = 0;

      if (state is CartLoaded) {
        final currentState = state as CartLoaded;

        promoCode = currentState.promocode;
        discount = currentState.discount;
      }

      emit(CartLoaded(items, promocode: promoCode, discount: discount));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _applyPromoCode(PromoCode event, Emitter<CartState> emit) async {
    if (state is! CartLoaded) {
      return;
    }

    final currentState = state as CartLoaded;

    final code = event.promocode.trim().toUpperCase();

    if (code.isEmpty) {
      emit(
        CartLoaded(
          currentState.items,
          promocode: null,
          discount: 0,
          promoError: 'Please enter a promo code',
        ),
      );
      return;
    }

    final subtotal = currentState.items.fold<double>(
      0,
      (total, item) => total + item.subtotalPrice,
    );

    double discount = 0;

    if (code == 'SAVE10') {
      discount = subtotal * 0.10;
    } else if (code == 'SAVE20') {
      discount = subtotal * 0.20;
    } else if (code == 'SAVE30') {
      discount = subtotal * 0.30;
    } else {
      emit(
        CartLoaded(
          currentState.items,
          promocode: null,
          discount: 0,
          promoError: 'Invalid promo code',
        ),
      );
      return;
    }

    emit(
      CartLoaded(
        currentState.items,
        promocode: code,
        discount: discount,
        promoError: null,
      ),
    );
  }
}
