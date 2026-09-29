class Datum {
  int? id;
  String? title;
  bool? isNew;
  String? oldPrice;
  double? price;
  double? discountedPrice;
  String? description;
  String? category;
  String? type;
  int? stock;
  String? brand;
  List<String>? size;
  String? image;
  int? rating;

  Datum({
    this.id,
    this.title,
    this.isNew,
    this.oldPrice,
    this.price,
    this.discountedPrice,
    this.description,
    this.category,
    this.type,
    this.stock,
    this.brand,
    this.size,
    this.image,
    this.rating,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json['_id'] as int?,
    title: json['title'] as String?,
    isNew: json['isNew'] as bool?,
    oldPrice: json['oldPrice'] as String?,
    price: (json['price'] as num?)?.toDouble(),
    discountedPrice: (json['discountedPrice'] as num?)?.toDouble(),
    description: json['description'] as String?,
    category: json['category'] as String?,
    type: json['type'] as String?,
    stock: json['stock'] as int?,
    brand: json['brand'] as String?,
    size: (json['size'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
    image: json['image'] as String?,
    rating: json['rating'] as int?,
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'title': title,
    'isNew': isNew,
    'oldPrice': oldPrice,
    'price': price,
    'discountedPrice': discountedPrice,
    'description': description,
    'category': category,
    'type': type,
    'stock': stock,
    'brand': brand,
    'size': size,
    'image': image,
    'rating': rating,
  };
}
