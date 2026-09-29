import 'datum.dart';

class Product {
  List<Datum>? data;
  int? totalProducts;
  int? totalPages;
  int? currentPage;
  int? perPage;

  Product({
    this.data,
    this.totalProducts,
    this.totalPages,
    this.currentPage,
    this.perPage,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    data: (json['data'] as List<dynamic>?)
        ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
        .toList(),
    totalProducts: json['totalProducts'] as int?,
    totalPages: json['totalPages'] as int?,
    currentPage: json['currentPage'] as int?,
    perPage: json['perPage'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'data': data?.map((e) => e.toJson()).toList(),
    'totalProducts': totalProducts,
    'totalPages': totalPages,
    'currentPage': currentPage,
    'perPage': perPage,
  };
}
