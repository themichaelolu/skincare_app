import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skincare_app/src/core/domain/cart/cart.dart';
import 'package:skincare_app/src/core/domain/products/products.dart';

class CartNotifier extends StateNotifier<Cart> {
  CartNotifier() : super(Cart());

  void addProduct(Product product) {
    state = Cart(products: [...state.products, product]);
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, Cart>((ref) {
  return CartNotifier();
});



