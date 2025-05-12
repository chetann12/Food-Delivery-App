import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_item.dart';
import '../providers/cart_provider.dart';
import 'cart_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<CartItem> _allMenuItems = [
    CartItem(
      id: '1',
      name: 'Margherita Pizza',
      image: 'assets/pizza1.jpg',
      price: 249.00,
      description: 'Classic cheesy Margherita with a hint of basil.',
      isVeg: true,
      rating: 4.2,
    ),
    CartItem(
      id: '2',
      name: 'Veg Burger',
      image: 'assets/vegburger.jpeg',
      price: 129.00,
      description: 'Grilled veggie patty with fresh lettuce & sauces.',
      isVeg: true,
      rating: 4.0,
    ),
    CartItem(
      id: '3',
      name: 'White Sauce Pasta',
      image: 'assets/pasta.jpg',
      price: 199.00,
      description: 'Creamy white sauce pasta with veggies & herbs.',
      isVeg: true,
      rating: 4.4,
    ),
    CartItem(
      id: '4',
      name: 'Chicken Sushi Rolls',
      image: 'assets/sushi.jpeg',
      price: 299.00,
      description: 'Rice rolls with chicken, veggies & avocado.',
      isVeg: false,
      rating: 4.5,
    ),
    CartItem(
      id: '5',
      name: 'Green Salad',
      image: 'assets/salad.jpg',
      price: 99.00,
      description: 'Healthy salad with cucumber, lettuce & olives.',
      isVeg: true,
      rating: 3.8,
    ),
    CartItem(
      id: '6',
      name: 'Chocolate Shake',
      image: 'assets/shake.png',
      price: 99.00,
      description: 'Rich and creamy chocolate milkshake.',
      isVeg: true,
      rating: 4.7,
    ),
    CartItem(
      id: '7',
      name: 'Chicken Wings (6pcs)',
      image: 'assets/wings.jpg',
      price: 199.75,
      description: 'Crispy and flavorful chicken wings.',
      isVeg: false,
      rating: 3.8,
    ),
  ];

  List<CartItem> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = _allMenuItems;
  }

  void _filterItems(String query) {
    setState(() {
      _filteredItems = _allMenuItems
          .where((item) =>
              item.name.toLowerCase().contains(query.toLowerCase()) ||
              item.description!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Menu")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              onChanged: _filterItems,
              decoration: InputDecoration(
                hintText: 'Search food items...',
                prefixIcon: const Icon(Icons.search),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                final item = _filteredItems[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            item.image,
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    item.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Icon(
                                    item.isVeg
                                        ? Icons.circle
                                        : Icons.circle_outlined,
                                    color:
                                        item.isVeg ? Colors.green : Colors.red,
                                    size: 12,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(item.description ?? '',
                                  style: const TextStyle(fontSize: 12)),
                              const SizedBox(height: 4),
                              Text('₹${item.price.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500)),
                              Row(
                                children: [
                                  const Icon(Icons.star,
                                      size: 14, color: Colors.amber),
                                  const SizedBox(width: 4),
                                  Text('${item.rating ?? 0.0}/5',
                                      style: const TextStyle(fontSize: 12)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            cart.addItem(CartItem(
                              id: item.id,
                              name: item.name,
                              image: item.image,
                              price: item.price,
                              description: item.description,
                              isVeg: item.isVeg,
                              rating: item.rating,
                            ));

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CartScreen()),
                                  ),
                                  child: const Text(
                                    "1 item added – View Cart",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                backgroundColor: Colors.green,
                                duration: const Duration(seconds: 2),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          child: const Text("Add"),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
