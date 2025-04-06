import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_item.dart';
import '../providers/cart_provider.dart';

class MenuScreen extends StatelessWidget {
  MenuScreen({super.key});

  final List<CartItem> menuItems = [
    CartItem(
      id: '1',
      name: 'Margherita Pizza',
      image: 'assets/pizza1.jpg',
      price: 249.00,
      description: 'Classic cheesy Margherita with a hint of basil.',
    ),
    CartItem(
      id: '2',
      name: 'Veg Burger',
      image: 'assets/vegburger.jpeg',
      price: 129.00,
      description: 'Grilled veggie patty with fresh lettuce & sauces.',
    ),
    CartItem(
      id: '3',
      name: 'White Sauce Pasta',
      image: 'assets/pasta.jpg',
      price: 199.00,
      description: 'Creamy white sauce pasta with veggies & herbs.',
    ),
    CartItem(
      id: '4',
      name: 'Veg Sushi Rolls',
      image: 'assets/sushi.jpeg',
      price: 299.00,
      description: 'Rice rolls stuffed with fresh veggies & avocado.',
    ),
    CartItem(
      id: '5',
      name: 'Green Salad',
      image: 'assets/salad.jpg',
      price: 99.00,
      description: 'Healthy salad mix with cucumber, lettuce & olives.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Menu")),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Image.asset(item.image, width: 60, height: 60),
              title: Text(item.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.description ?? '',
                      style: const TextStyle(fontSize: 12)),
                  const SizedBox(height: 4),
                  Text('₹${item.price.toStringAsFixed(2)}'),
                ],
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  cart.addItem(CartItem(
                    id: item.id,
                    name: item.name,
                    image: item.image,
                    price: item.price,
                    description: item.description,
                  ));

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${item.name} added to cart'),
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: const Text("Add to cart"),
              ),
            ),
          );
        },
      ),
    );
  }
}
