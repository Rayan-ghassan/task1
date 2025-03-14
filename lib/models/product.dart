class Product {
  final int id;
  final String title;
  final String description; // Full description
  final String shortDescription; // Short description
  final String image;
  final double price;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.shortDescription,
    required this.image,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? '', // Handle null value for description
      shortDescription: (json['description'] ?? '')
          .length > 50
          ? (json['description'] ?? '').substring(0, 50) + "..." // Handle null value and limit to 50 chars
          : (json['description'] ?? ''),
      image: json['thumbnail'] ?? '', // Handle null value for image
      price: json['price']?.toDouble() ?? 0.0, // Handle null value for price
    );
  }
}