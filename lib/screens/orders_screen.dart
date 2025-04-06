import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Orders")),
      body: cart.orders.isEmpty
          ? const Center(child: Text("No orders yet."))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: cart.orders.length,
              itemBuilder: (context, index) {
                final item = cart.orders[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Image.asset(item.image, width: 60, height: 60),
                    title: Text(item.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Qty: ${item.quantity}"),
                        if (item.deliveryAddress != null)
                          Text("To: ${item.deliveryAddress}"),
                        if (item.phoneNumber != null)
                          Text("Phone: ${item.phoneNumber}"),
                      ],
                    ),
                    trailing: Text(
                      '₹${(item.price * item.quantity).toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
