import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];
  final List<List<CartItem>> _orders = []; // Each order is a list of CartItems

  List<CartItem> get items => _items;

  List<List<CartItem>> get orders => _orders;

  double get totalPrice =>
      _items.fold(0, (sum, item) => sum + item.price * item.quantity);

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  void addItem(CartItem item) {
    final index = _items.indexWhere((element) => element.id == item.id);
    if (index != -1) {
      _items[index].quantity += 1;
    } else {
      _items.add(item);
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  void increaseQty(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index != -1) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  void decreaseQty(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index != -1 && _items[index].quantity > 1) {
      _items[index].quantity--;
    } else if (index != -1) {
      _items.removeAt(index);
    }
    notifyListeners();
  }

  void checkout({required String address, required String phoneNumber}) {
    // Clone current cart items into an order
    final newOrder = _items
        .map((item) => CartItem(
              id: item.id,
              name: item.name,
              image: item.image,
              price: item.price,
              description: item.description,
              isVeg: item.isVeg,
              rating: item.rating,
              quantity: item.quantity,
            ))
        .toList();

    _orders.add(newOrder);
    _items.clear();
    notifyListeners();
  }
}
