import 'dart:math' as math;

import 'package:nana/core/constants/theme_color.dart';
import 'package:nana/core/routes/route.dart';
import 'package:nana/features/ad/image_ad.dart';
import 'package:nana/features/auth/bloc/auth_bloc.dart';
import 'package:nana/features/auth/bloc/auth_state.dart';
import 'package:nana/features/product/bloc/product_bloc.dart';
import 'package:nana/features/product/bloc/product_event.dart';

import 'package:nana/features/product/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthAuthenticated) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi, ${state.user!.displayName ?? "User"}!',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Discover products you'll love",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, User!',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Discover products you'll love",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.only(top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              SearchAnchor(
                builder: (context, controller) {
                  return SearchBar(
                    controller: controller,
                    hintText: 'Search products...',
                    hintStyle: WidgetStatePropertyAll(
                      TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    leading: Icon(
                      Icons.search_rounded,
                      color: ThemeColor.primaryColor,
                    ),
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                    elevation: WidgetStatePropertyAll(0),
                    padding: WidgetStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 18),
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                        side: BorderSide(
                          color: ThemeColor.primaryColor.withValues(
                            alpha: 0.25,
                          ),
                          width: 1.2,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      context.read<ProductBloc>().add(SearchProduct(value));

                      if (value.trim().isNotEmpty) {
                        controller.openView();
                      }
                    },
                  );
                },
                suggestionsBuilder: (context, controller) {
                  final bloc = context.read<ProductBloc>();

                  final query = controller.text.trim().toLowerCase();

                  if (query.isEmpty) {
                    return [];
                  }

                  final products = bloc.allProducts.where((product) {
                    final title = product.title?.toLowerCase() ?? '';
                    final category = product.category?.toLowerCase() ?? '';
                    final type = product.type?.toLowerCase() ?? '';
                    final brand = product.brand?.toLowerCase() ?? '';

                    return title.contains(query) ||
                        category.contains(query) ||
                        type.contains(query) ||
                        brand.contains(query);
                  }).toList();

                  if (products.isEmpty) {
                    return [
                      Padding(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: ThemeColor.primaryColor.withValues(
                                  alpha: 0.08,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.search_off_rounded,
                                size: 30,
                                color: ThemeColor.primaryColor,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              'No products found',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Try searching for another product',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ];
                  }

                  return products.take(6).map((product) {
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      leading: Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          color: ThemeColor.primaryColor.withValues(
                            alpha: 0.06,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: product.image ?? '',
                            fit: BoxFit.cover,
                            placeholder: (context, url) {
                              return Center(
                                child: SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: ThemeColor.primaryColor,
                                  ),
                                ),
                              );
                            },
                            errorWidget: (context, url, error) {
                              return Icon(
                                Icons.image_not_supported_outlined,
                                color: Colors.grey,
                              );
                            },
                          ),
                        ),
                      ),
                      title: Text(
                        product.title ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          product.category.toString(),
                          style: TextStyle(
                            color: ThemeColor.primaryColor,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      trailing: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: ThemeColor.primaryColor.withValues(
                            alpha: 0.08,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 13,
                          color: ThemeColor.primaryColor,
                        ),
                      ),
                      onTap: () {
                        controller.closeView(product.title ?? '');

                        context.push(Routes.productDetail, extra: product);
                      },
                    );
                  }).toList();
                },
              ),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF6A3DE8), Color(0xFF8B5CF6)],
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: SizedBox(
                  height: 200,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 10,
                          children: [
                            Text(
                              'SUMMER COLLECTION',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'New Arrivals\nAre Here',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                final products = context
                                    .read<ProductBloc>()
                                    .allProducts;
                                if (products.isEmpty) {
                                  return;
                                }
                                final random = math.Random();
                                final randomProduct =
                                    products[random.nextInt(products.length)];
                                context.push(
                                  Routes.productDetail,
                                  extra: randomProduct,
                                );
                              },
                              child: Text('Shop Now'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(flex: 4, child: ImageAd()),
                    ],
                  ),
                ),
              ),
              Text(
                'Popular Products',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ProductScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
