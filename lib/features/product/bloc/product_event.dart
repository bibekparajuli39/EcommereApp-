import 'package:nana/features/product/models/product/datum.dart';

abstract class ProductEvent {}

class GetProducts extends ProductEvent {}

class SearchProduct extends ProductEvent {
  final String query;

  SearchProduct(this.query);
}

class SelectProduct extends ProductEvent {
  final Datum product;

  SelectProduct(this.product);
}
