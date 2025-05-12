import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/cart_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final orders = cart.orders;

    return Scaffold(
      appBar: AppBar(title: const Text("Orders")),
      body: orders.isEmpty
          ? const Center(child: Text("No orders yet."))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: orders.length,
              itemBuilder: (context, orderIndex) {
                final orderItems = orders[orderIndex];
                final total = orderItems.fold(
                    0.0, (sum, item) => sum + item.price * item.quantity);

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order ${orderIndex + 1}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const Divider(),
                        ...orderItems.map((item) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Image.asset(item.image,
                                  width: 50, height: 50, fit: BoxFit.cover),
                              title: Row(
                                children: [
                                  Icon(Icons.circle,
                                      color: item.isVeg
                                          ? Colors.green
                                          : Colors.red,
                                      size: 12),
                                  const SizedBox(width: 6),
                                  Text(item.name),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Qty: ${item.quantity}"),
                                  if (item.rating != null)
                                    Row(
                                      children: [
                                        Icon(Icons.star,
                                            color: Colors.orange, size: 16),
                                        const SizedBox(width: 4),
                                        Text(item.rating!.toStringAsFixed(1)),
                                      ],
                                    ),
                                ],
                              ),
                              trailing: Text(
                                '₹${(item.price * item.quantity).toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                        const Divider(),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Total: ₹${total.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
