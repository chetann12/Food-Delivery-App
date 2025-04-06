class CartItem {
  final String id;
  final String name;
  final String image;
  final double price;
  final String? description;
  int quantity;
  final String? deliveryAddress;
  final String? phoneNumber;

  CartItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    this.description,
    this.quantity = 1,
    this.deliveryAddress,
    this.phoneNumber,
  });
}
