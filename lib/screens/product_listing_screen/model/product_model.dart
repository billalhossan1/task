class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final ProductRating rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id'] as int,
    title: json['title'] as String,
    price: (json['price'] as num).toDouble(),
    description: json['description'] as String,
    category: json['category'] as String,
    image: json['image'] as String,
    rating: ProductRating.fromJson(json['rating'] as Map<String, dynamic>),
  );
}

class ProductRating {
  final double rate;
  final int count;

  ProductRating({required this.rate, required this.count});

  factory ProductRating.fromJson(Map<String, dynamic> json) => ProductRating(
    rate: (json['rate'] as num).toDouble(),
    count: json['count'] as int,
  );
}
