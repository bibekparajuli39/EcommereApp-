import 'package:app_project/core/routes/route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.go(Routes.home);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(''),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          spacing: 10,
          crossAxisAlignment: .start,
          children: [
            Center(
              child: Hero(
                tag: 'hero',
                child: Image.network(
                  'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png',
                  height: 200,
                ),
              ),
            ),
            Text(
              'Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '\$109.95',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Row(
              spacing: 5,
              children: [
                Icon(Icons.star, color: Colors.orange),
                Text('4.9'),
                Text('(200 review)'),
              ],
            ),
            Text(
              'Description',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: const Color.fromARGB(255, 132, 128, 128)),
            ),
            Spacer(),

            Row(
              spacing: 15,
              children: [
                Container(
                  height: 50,
                  width: 130,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    border: BoxBorder.all(width: 1),
                  ),
                  child: Row(
                    spacing: 10,
                    crossAxisAlignment: .center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.remove, size: 20),
                      ),

                      Text('1'),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.add, size: 20),
                      ),
                    ],
                  ),
                ),

                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 50,
                    width: 199,
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 13),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      border: BoxBorder.all(width: 1),
                      color: Colors.black,
                    ),
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
