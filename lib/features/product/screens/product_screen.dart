import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,

      child: GridView.builder(
        itemCount: 10,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0, // Horizontal spacing between product
          mainAxisSpacing: 8.0, // Vertical spacing between product
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          return Container(
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
            margin: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(22),
              child: Column(
                crossAxisAlignment: .start,

                children: [
                  Center(
                    child: Image.network(
                      'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png',
                      height: 120,
                      width: 90,

                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.all(10),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: .start,
                              children: [
                                Text(
                                  'title',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('price'),
                                Text('description'),
                              ],
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.shopping_cart),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
