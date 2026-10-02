import 'package:nana/features/cart/bloc/cart_event.dart';
import 'package:nana/features/cart/bloc/cart_state.dart';
import 'package:nana/features/cart/repositories/cart_repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepositories repository;

  CartBloc(this.repository) : super(CartInitial()) {
    on<LoadCart>((event, emit) async {
      emit(CartLoading());

      try {
        final items = repository.getCartItems();
        emit(CartLoaded(items: items));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });

    on<AddToCart>((event, emit) async {
      try {
        repository.addToCart(
          event.product as dynamic,
          quantity: event.quantity,
        );
        final item = repository.getCartItems();
        emit(CartLoaded(items: item));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });
    on<IncreaseQuantity>((event, emit) {
      try {
        repository.increaseQuantity(event.productId);
        final item = repository.getCartItems();
        emit(CartLoaded(items: item));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });

    on<DecreaseQuantity>((event, emit) {
      try {
        repository.decreaseQuantity(event.productId);
        final item = repository.getCartItems();
        emit(CartLoaded(items: item));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });
    on<RemoveFromCart>((event, emit) {
      try {
        repository.removeCart(event.productId);
        final item = repository.getCartItems();
        emit(CartLoaded(items: item));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });

    on<PromoCode>((event, emit) {
      try {
        final items = repository.getCartItems();

        final subtotalPrice = items.fold<double>(
          0,
          (total, item) => total + item.subtotalPrice,
        );

        final promocode = event.promocode.trim().toUpperCase();

        double discount = 0;

        if (promocode == 'SAVE10') {
          discount = subtotalPrice * 0.10;
        }

        emit(
          CartLoaded(items: items, promocode: promocode, discount: discount),
        );
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });
  }
}
