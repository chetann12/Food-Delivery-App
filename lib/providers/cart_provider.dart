import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];
  final List<CartItem> _orders = [];

  List<CartItem> get items => _items;
  List<CartItem> get orders => _orders;

  void addItem(CartItem item) {
    final index = _items.indexWhere((i) => i.id == item.id);
    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(item);
    }
    notifyListeners();
  }

  void increaseQty(String id) {
    final index = _items.indexWhere((i) => i.id == id);
    if (index >= 0) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  void decreaseQty(String id) {
    final index = _items.indexWhere((i) => i.id == id);
    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  double get totalPrice {
    return _items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  void checkout({
    required String address,
    required String phoneNumber,
  }) {
    // Add cart items to orders with address & phone
    for (var item in _items) {
      _orders.add(CartItem(
        id: item.id,
        name: item.name,
        image: item.image,
        price: item.price,
        quantity: item.quantity,
        description: item.description,
        deliveryAddress: address,
        phoneNumber: phoneNumber,
      ));
    }
    _items.clear();
    notifyListeners();
  }
}
