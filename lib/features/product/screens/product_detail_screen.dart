import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:nana/core/constants/theme_color.dart';
import 'package:nana/core/routes/route.dart';

import 'package:nana/features/cart/bloc/cart_bloc.dart';
import 'package:nana/features/cart/bloc/cart_event.dart';
import 'package:nana/features/product/models/product/datum.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nana/features/services/local_notification_service.dart';

class ProductDetailScreen extends StatefulWidget {
  final Datum product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Details',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              SingleChildScrollView(
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: .start,
                  children: [
                    Center(
                      child: Hero(
                        tag: 'Product-${widget.product.id}',
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(12),
                          child: SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.width * 0.8,
                            child: CachedNetworkImage(
                              imageUrl: widget.product.image.toString(),
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      widget.product.title.toString(),
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    Text(
                      'Rs.${widget.product.price?.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      spacing: 5,
                      children: [
                        Row(
                          spacing: 5,
                          children: [
                            Icon(Icons.star, color: Colors.orange),
                            Text('${widget.product.rating}'),
                            // ${widget.product.rating!.count}
                            Text('(review)'),
                          ],
                        ),

                        Text(
                          'In Stock: ${widget.product.stock}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),

                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 12,
                            spreadRadius: 1,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 4,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: ThemeColor.primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),

                              SizedBox(width: 10),

                              Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 12),

                          Text(
                            widget.product.description.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.6,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.only(top: 12, bottom: 12),
                color: Color(0xfff8f9fb),
                child: Row(
                  children: [
                    // Quantity
                    Container(
                      height: 52,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: quantity > 1
                                ? () {
                                    setState(() {
                                      quantity--;
                                    });
                                  }
                                : null,
                            icon: Icon(Icons.remove, size: 18),
                          ),

                          Text(
                            quantity.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          IconButton(
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                            icon: Icon(Icons.add, size: 18),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 12),

                    // Add to Cart
                    Expanded(
                      child: SizedBox(
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () async {
                            context.read<CartBloc>().add(
                              AddToCart(widget.product, quantity: quantity),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.green.shade600,
                                behavior: SnackBarBehavior.floating,
                                duration: Duration(seconds: 2),
                                content: Text(
                                  'Successfully Added to Cart',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                            Future.delayed(Duration(seconds: 2), () {
                              if (context.mounted) {
                                context.push(Routes.cart);
                              }
                            });
                            savePendingCartProduct(
                              productName: widget.product.title.toString(),
                            );
                            await scheduleCartNotification(
                              productName:
                                  widget.product.title ?? 'Your product',
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ThemeColor.primaryColor,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.shopping_cart_outlined, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Add to Cart',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
