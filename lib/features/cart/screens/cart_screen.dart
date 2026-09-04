import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(22),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 2),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              spacing: 20,
              children: [
                Image.network(
                  'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png',
                  width: 100,
                ),
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text('title'),
                    Text('Category'),
                    Text('desciption'),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Text('\$ 1233'),
                    IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
