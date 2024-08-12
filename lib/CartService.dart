import 'package:flutter/foundation.dart';

class CartService {
  static final List<Map<String, dynamic>> _cartItems = [];
  static final ValueNotifier<List<Map<String, dynamic>>> cartNotifier = ValueNotifier(_cartItems);

  static void addToCart(Map<String, dynamic> product) {
    _cartItems.add(product);
    cartNotifier.value = List.from(_cartItems);
  }

  static void removeFromCart(Map<String, dynamic> product) {
    _cartItems.remove(product);
    cartNotifier.value = List.from(_cartItems); 
  }

  static void clearCart() {
    _cartItems.clear();
    cartNotifier.value = List.from(_cartItems); 
  }

  static List<Map<String, dynamic>> getCartItems() {
    return _cartItems;
  }
}
