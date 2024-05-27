class Dish {
  final int id;
  final String name;
  final String category;
  final double price;
  final String imageUrl;
  final List<DishVariation> variations;

  Dish({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
    required this.variations,
  });

  factory Dish.fromJson(Map<String, dynamic> json) {
    var variationsFromJson = json['variations'] as List;
    List<DishVariation> variationList =
        variationsFromJson.map((v) => DishVariation.fromJson(v)).toList();

    return Dish(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      price: json['price'].toDouble(),
      imageUrl: json['image_url'],
      variations: variationList,
    );
  }
}

class DishVariation {
  final String name;
  final double extraPrice;

  DishVariation({
    required this.name,
    required this.extraPrice,
  });

  factory DishVariation.fromJson(Map<String, dynamic> json) {
    return DishVariation(
      name: json['name'],
      extraPrice: json['extra_price'].toDouble(),
    );
  }
}
