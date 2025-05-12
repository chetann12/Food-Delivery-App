import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';

import '../providers/cart_provider.dart';
import 'orders_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _formKey = GlobalKey<FormState>();
  final apartmentController = TextEditingController();
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final pincodeController = TextEditingController();
  final phoneController = TextEditingController();

  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 2));

  @override
  void dispose() {
    apartmentController.dispose();
    streetController.dispose();
    cityController.dispose();
    pincodeController.dispose();
    phoneController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          cart.items.isEmpty
              ? const Center(
                  child: Text(
                    "Your cart is empty.",
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cart.items.length,
                        itemBuilder: (context, index) {
                          final item = cart.items[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      item.image,
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              color: item.isVeg
                                                  ? Colors.green
                                                  : Colors.red,
                                              size: 12,
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              item.name,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "₹${(item.price * item.quantity).toStringAsFixed(2)}",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        if (item.rating != null)
                                          Row(
                                            children: [
                                              const Icon(Icons.star,
                                                  color: Colors.orange,
                                                  size: 16),
                                              const SizedBox(width: 4),
                                              Text(
                                                item.rating!.toStringAsFixed(1),
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                            icon:
                                                const Icon(Icons.remove_circle),
                                            onPressed: () =>
                                                cart.decreaseQty(item.id),
                                          ),
                                          Text('${item.quantity}'),
                                          IconButton(
                                            icon: const Icon(Icons.add_circle),
                                            onPressed: () =>
                                                cart.increaseQty(item.id),
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () =>
                                            cart.removeItem(item.id),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 4,
                            offset: const Offset(0, -2),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Total: ₹${cart.totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {
                              _showCheckoutDialog(context, cart);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text("Proceed to Checkout",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              emissionFrequency: 0.06,
              numberOfParticles: 20,
              maxBlastForce: 10,
              minBlastForce: 4,
              gravity: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  void _showCheckoutDialog(BuildContext context, CartProvider cart) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Enter Delivery Details"),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField(apartmentController, "Apartment",
                      "Enter apartment name/number"),
                  const SizedBox(height: 10),
                  _buildTextField(
                      streetController, "Street", "Enter street or area"),
                  const SizedBox(height: 10),
                  _buildTextField(cityController, "City", "Enter city name"),
                  const SizedBox(height: 10),
                  _buildTextField(
                      pincodeController, "Pincode", "Enter 6-digit pincode",
                      keyboardType: TextInputType.number, validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Pincode is required";
                    } else if (!RegExp(r'^\d{6}$').hasMatch(value.trim())) {
                      return "Enter valid 6-digit pincode";
                    }
                    return null;
                  }),
                  const SizedBox(height: 10),
                  _buildTextField(
                      phoneController, "Phone Number", "Enter phone number",
                      keyboardType: TextInputType.phone, validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Phone number is required";
                    } else if (!RegExp(r'^[6-9]\d{9}$')
                        .hasMatch(value.trim())) {
                      return "Enter valid Indian phone number";
                    }
                    return null;
                  }),
                  const SizedBox(height: 12),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Payment Mode: Cash on Delivery (COD)",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.green)),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final address =
                      "${apartmentController.text.trim()}, ${streetController.text.trim()}, ${cityController.text.trim()}, ${pincodeController.text.trim()}";
                  final phone = phoneController.text.trim();

                  cart.checkout(address: address, phoneNumber: phone);

                  final validContext =
                      context; // capture valid context before pop
                  Navigator.pop(context);
                  _confettiController.play();

                  ScaffoldMessenger.of(validContext).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      content: const Text(
                        "1 order placed successfully!",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text("Place Order"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    String hint, {
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      keyboardType: keyboardType,
      validator: validator ??
          (value) {
            if (value == null || value.trim().isEmpty) {
              return "$label is required";
            }
            return null;
          },
    );
  }
}
