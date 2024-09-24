class Product {
  final int id;
  final String title;
  final String image;
  final String description;
  final String shortDescription;

  const Product({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.shortDescription,
  });

  // Метод для создания объекта из JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      description: json['description'],
      shortDescription: json['short_description'],
    );
  }
}
