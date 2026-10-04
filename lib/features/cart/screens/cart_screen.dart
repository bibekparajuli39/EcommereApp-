import 'dart:developer';

import 'package:khalti_checkout_flutter/khalti_checkout_flutter.dart';
import 'package:nana/core/constants/theme_color.dart';
import 'package:nana/core/utils/khalti_util.dart';
import 'package:nana/features/cart/bloc/cart_bloc.dart';
import 'package:nana/features/cart/bloc/cart_event.dart';
import 'package:nana/features/cart/bloc/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Khalti? _khalti;

  final TextEditingController promocodeController = TextEditingController();

  Future<void> payWithKhalti(int amount) async {
    final pidx = await UtilsKhaltiService.generatePidx(amount);

    print(pidx);

    if (pidx == null) {
      print('pidx is Empty');

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unable to start payment'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      final config = KhaltiPayConfig(
        publicKey: '2e1b40bd59824b8d995f0cc63a24c06d',
        pidx: pidx,
        environment: Environment.test,
        paymentUrl:
            'https://test-pay.khalti.com/?pidx=$pidx&return_url=https%3A%2F%2Fdocs.khalti.com%2Fkhalti-epayment&mode=wallet',
      );

      _khalti = await Khalti.init(
        enableDebugging: true,
        payConfig: config,
        onPaymentResult: (paymentResult, khalti) {
          log("Payment Result: ${paymentResult.payload}");
          log("Transaction ID: ${paymentResult.payload?.transactionId}");

          if (!mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Payment Successful!'),
              backgroundColor: Colors.green,
            ),
          );

          khalti.close(context);
        },
        onMessage:
            (
              khalti, {
              description,
              statusCode,
              event,
              needsPaymentConfirmation,
            }) async {
              log(
                "Message: $description, "
                "Status Code: $statusCode, "
                "Event: $event",
              );

              if (needsPaymentConfirmation == true) {
                await khalti.verify();
              }

              if (!mounted) return;

              khalti.close(context);
            },
        onReturn: () {
          log("Returned from Khalti Gateway Interface");
        },
      );

      if (!mounted) return;

      _khalti?.open(context);
    }
  }

  void _showDeleteDialog(BuildContext context, int productId) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),

          title: Text(
            'Delete Item',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          content: Text('Are you sure you want to delete'),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text('Cancel'),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeColor.primaryColor,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(dialogContext);

                context.read<CartBloc>().add(RemoveFromCart(productId));
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    promocodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: BlocListener<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartLoaded && state.promoError != null) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Expanded(
                      child: Text(
                        state.promoError!,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is CartError) {
              return Center(child: Text(state.message));
            }

            if (state is CartLoaded) {
              // final bool isPromoApplied =
              //     state.promocode != null &&
              //     state.promocode!.isNotEmpty &&
              //     state.discount > 0;

              if (state.items.isEmpty) {
                return Center(child: Text('Your cart is empty'));
              }

              final subTotalPrice = state.items.fold<double>(
                0,
                (total, item) => total + item.subtotalPrice,
              );

              final total = subTotalPrice - state.discount;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.items.length,
                      itemBuilder: (context, index) {
                        final item = state.items[index];

                        return Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.12),
                                blurRadius: 3,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            spacing: 20,
                            children: [
                              Container(
                                height: 60,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF5F2FF),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    item.product.image.toString(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.product.title.toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                    ),
                                    Text(
                                      item.product.category.toString(),
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Rs.${item.product.price?.toStringAsFixed(0)}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                spacing: 20,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      _showDeleteDialog(
                                        context,
                                        item.product.id!,
                                      );
                                    },
                                    icon: Icon(
                                      Icons.delete_outline,
                                      size: 15,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  Container(
                                    height: 35,
                                    width: 107,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(22),
                                      border: Border.all(
                                        width: 1,
                                        color: Color(0xFFE0E0E0),
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            context.read<CartBloc>().add(
                                              DecreaseQuantity(
                                                item.product.id!,
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.remove,
                                            size: 20,
                                            color: ThemeColor.primaryColor,
                                          ),
                                        ),
                                        Text(item.quantity.toString()),
                                        IconButton(
                                          onPressed: () {
                                            context.read<CartBloc>().add(
                                              IncreaseQuantity(
                                                item.product.id!,
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.add,
                                            size: 20,
                                            color: ThemeColor.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                      child: TextFormField(
                        controller: promocodeController,
                        textCapitalization: TextCapitalization.characters,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide: BorderSide(
                              width: 1,
                              color: ThemeColor.primaryColor,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                          hintText: 'Enter promo code',
                          suffixIcon: Padding(
                            padding: EdgeInsets.all(6),
                            child: ElevatedButton(
                              onPressed: () {
                                final code = promocodeController.text.trim();

                                if (code.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Please enter a promo code',
                                      ),
                                      backgroundColor: Colors.red,
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                  return;
                                }

                                context.read<CartBloc>().add(PromoCode(code));

                                promocodeController.clear();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Row(
                                      children: [
                                        Text(
                                          'Promo code applied successfully',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    backgroundColor: Colors.green.shade600,
                                    behavior: SnackBarBehavior.floating,
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ThemeColor.primaryColor,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child: Text(
                                'APPLY',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.all(12),
                      padding: EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Color(0xFFF8F6FF),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Color(0xFFE8E0FF)),
                      ),
                      child: Column(
                        spacing: 8,
                        children: [
                          Row(
                            children: [
                              Text('Subtotal', style: TextStyle(fontSize: 18)),
                              Spacer(),
                              Text(
                                'Rs.${subTotalPrice.toStringAsFixed(0)}',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Discount', style: TextStyle(fontSize: 18)),
                              Spacer(),
                              Text(
                                '-Rs.${state.discount.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Shipping', style: TextStyle(fontSize: 18)),
                              Spacer(),
                              Text(
                                'Free',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Divider(height: 10),
                          Row(
                            children: [
                              Text(
                                'Total',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              Text(
                                'Rs.${total.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(12, 5, 12, 20),
                      child: SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ThemeColor.primaryColor,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                          onPressed: () async {
                            await payWithKhalti(total.toInt());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Checkout',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward, size: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return SizedBox();
          },
        ),
      ),
    );
  }
}
