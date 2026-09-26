import 'package:app_project/core/routes/route.dart';
import 'package:app_project/features/cart/bloc/cart_bloc.dart';
import 'package:app_project/features/cart/bloc/cart_event.dart';
import 'package:app_project/features/product/bloc/product_bloc.dart';
import 'package:app_project/features/product/bloc/product_event.dart';
import 'package:app_project/features/product/bloc/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetProducts());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 10),
            child: Text(
              'Products',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),

          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is ProductError) {
                return Center(child: Text(state.message));
              }
              if (state is FetchProduct) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.product.length,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 18,
                    childAspectRatio: 0.57,
                  ),
                  itemBuilder: (context, index) {
                    final product = state.product[index];

                    return InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () {
                        context.go(Routes.productDetail, extra: product);
                      },
                      child: Card(
                        elevation: 3,
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image
                            Expanded(
                              flex: 5,
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(8),
                                child: Hero(
                                  tag: 'Product-${product.id}',
                                  child: Image.network(
                                    product.image.toString(),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),

                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(12, 8, 8, 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.title.toString(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),

                                    SizedBox(height: 5),

                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: 16,
                                          color: Colors.amber,
                                        ),
                                        SizedBox(width: 3),
                                        Text(
                                          product.rating!.rate.toString(),
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(width: 3),
                                        Text(
                                          '(${product.rating!.count.toString()})',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ),

                                    Spacer(),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '\$${product.price}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        Container(
                                          height: 36,
                                          width: 36,
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: IconButton(
                                            padding: EdgeInsets.zero,
                                            onPressed: () {
                                              context.read<CartBloc>().add(
                                                AddToCart(product),
                                              );
                                            },
                                            icon: Icon(
                                              Icons.shopping_cart_outlined,
                                              size: 19,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return SizedBox();
            },
          ),

          // GridView.builder(
          //   shrinkWrap: true,
          //   physics: NeverScrollableScrollPhysics(),
          //   itemCount: 10,
          //   padding: EdgeInsets.symmetric(horizontal: 10),
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 2,
          //     crossAxisSpacing: 15,
          //     mainAxisSpacing: 18,
          //     childAspectRatio: 0.57,
          //   ),
          //   itemBuilder: (context, index) {
          //     return InkWell(
          //       borderRadius: BorderRadius.circular(18),
          //       onTap: () {
          //         context.go(Routes.productDetail);
          //       },
          //       child: Card(
          //         elevation: 3,
          //         margin: EdgeInsets.zero,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(18),
          //         ),
          //         clipBehavior: Clip.antiAlias,
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             // Image
          //             Expanded(
          //               flex: 5,
          //               child: Container(
          //                 width: double.infinity,
          //                 decoration: const BoxDecoration(
          //                   image: DecorationImage(
          //                     image: NetworkImage(
          //                       'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png',
          //                     ),
          //                     fit: BoxFit.contain,
          //                   ),
          //                 ),
          //               ),
          //             ),

          //             Expanded(
          //               flex: 4,
          //               child: Padding(
          //                 padding: EdgeInsets.fromLTRB(12, 8, 8, 8),
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Text(
          //                       'Fjallraven - Foldsack No. 1 Backpack',
          //                       style: TextStyle(
          //                         fontSize: 14,
          //                         fontWeight: FontWeight.w600,
          //                       ),
          //                       maxLines: 2,
          //                       overflow: TextOverflow.ellipsis,
          //                     ),

          //                     SizedBox(height: 5),

          //                     Row(
          //                       children: [
          //                         Icon(
          //                           Icons.star,
          //                           size: 16,
          //                           color: Colors.amber,
          //                         ),
          //                         SizedBox(width: 3),
          //                         Text(
          //                           '4.9',
          //                           style: TextStyle(
          //                             fontSize: 12,
          //                             fontWeight: FontWeight.w500,
          //                           ),
          //                         ),
          //                         SizedBox(width: 3),
          //                         Text(
          //                           '(200)',
          //                           style: TextStyle(
          //                             fontSize: 11,
          //                             color: Colors.grey.shade600,
          //                           ),
          //                         ),
          //                       ],
          //                     ),

          //                     Spacer(),

          //                     Row(
          //                       mainAxisAlignment:
          //                           MainAxisAlignment.spaceBetween,
          //                       crossAxisAlignment: CrossAxisAlignment.center,
          //                       children: [
          //                         const Text(
          //                           '\$109.95',
          //                           style: TextStyle(
          //                             fontSize: 16,
          //                             fontWeight: FontWeight.bold,
          //                           ),
          //                         ),

          //                         Container(
          //                           height: 36,
          //                           width: 36,
          //                           decoration: BoxDecoration(
          //                             color: Colors.blue,
          //                             borderRadius: BorderRadius.circular(10),
          //                           ),
          //                           child: IconButton(
          //                             padding: EdgeInsets.zero,
          //                             onPressed: () {},
          //                             icon: Icon(
          //                               Icons.shopping_cart_outlined,
          //                               size: 19,
          //                               color: Colors.white,
          //                             ),
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
