class Dish {
  final String name;
  final String category;
  final double price;
  final String imageUrl;

  Dish({
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
  });

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      name: json['name'],
      category: json['category'],
      price: json['price'].toDouble(),
      imageUrl: json['image_url'],
    );
  }
}
