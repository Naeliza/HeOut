import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_flutter_app/CardNumberInputFormatter.dart';
import 'package:my_flutter_app/CartService.dart';
import 'package:my_flutter_app/ExpiryDateInputFormatter.dart';
import 'package:my_flutter_app/PurchaseSuccessScreen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController cardNumberController = TextEditingController();
    final TextEditingController expiryDateController = TextEditingController();
    final TextEditingController cvvController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: cardNumberController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(16),
                CardNumberInputFormatter(),
              ],
              decoration: const InputDecoration(
                labelText: 'Card Number',
                prefixIcon: Icon(Icons.credit_card), 
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: expiryDateController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                      ExpiryDateInputFormatter(),
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Expiry Date',
                      prefixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: cvvController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3),
                    ],
                    decoration: const InputDecoration(
                      labelText: 'CVV',
                      prefixIcon: Icon(Icons.lock), // Icono de candado
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                CartService.clearCart();
                
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const PurchaseSuccessScreen()),
                );
              },
              child: const Text('Pay Now'),
            ),
          ],
        ),
      ),
    );
  }
}
