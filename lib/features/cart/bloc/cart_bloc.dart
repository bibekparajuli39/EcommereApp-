import 'package:app_project/features/cart/bloc/cart_event.dart';
import 'package:app_project/features/cart/bloc/cart_state.dart';
import 'package:app_project/features/cart/repositories/cart_repositories.dart';
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
        repository.addToCart(event.product, quantity: event.quantity);
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
        final item = repository.getCartItems();
        final subtotalprice = item.fold<double>(0, (total, item) {
          return total + item.subtotalPrice;
        });

        double discount = 0;
        if (event.promocode == "SAVE10") {
          discount = subtotalprice * 0.10;
        }
        emit(
          CartLoaded(
            items: item,
            promocode: event.promocode,
            discount: discount,
          ),
        );
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });
  }
}
