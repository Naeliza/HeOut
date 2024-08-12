import 'package:flutter/material.dart';
import 'package:my_flutter_app/CartService.dart';
import 'package:my_flutter_app/checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    CartService.cartNotifier.addListener(_updateCart);
  }

  void _updateCart() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    CartService.cartNotifier.removeListener(_updateCart);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = CartService.getCartItems();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Regresa a la pantalla de productos
          },
        ),
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  title: Text(item['title']),
                  subtitle: Text('${item['price']}€'),
                );
              },
            ),
      bottomNavigationBar: cartItems.isEmpty
          ? null
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  CartService.clearCart();
                  if (mounted) {
                    setState(() {});
                  } // Refrescar la UI después de limpiar el carrito
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CheckoutScreen()),
                  );
                },
                child: const Text('Proceed to Checkout'),
              ),
            ),
    );
  }
}
