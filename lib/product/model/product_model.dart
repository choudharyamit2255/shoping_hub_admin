class Product {
  final String? id;
  final String name;
  final num price;
  final String? image;
  final String description;
  final num? discountAmount;
 final String? categoryId;
  final int stock;
  final int? created;
  final int? modified;

  Product({
    this.id,
    required this.name,
    required this.price,
    this.image,
    required this.description,
    this.discountAmount,
   this.categoryId,
    required this.stock,
    this.created,
    this.modified,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] as String?,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String?,
      description: json['description'] ??'',
      discountAmount: (  json['discountAmount'] as num?)?.toDouble(),
    //  categoryId: json['categoryId'] as String,
      stock: json['stock'] ??0,
      created: json['created'] ??0,
      modified: json['modified'] ??0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'price': price,
      'image': image,
      'description': description,
      'discountAmount': discountAmount,
    'categoryId': categoryId,
      'stock': stock,
      'created': created,
      'modified': modified,
    };
  }
}