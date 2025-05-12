class CartItem {
  final String id;
  final String name;
  final String image;
  final double price;
  final String? description;
  final bool isVeg;
  final double? rating;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    this.description,
    required this.isVeg,
    this.rating,
    this.quantity = 1,
  });
}
