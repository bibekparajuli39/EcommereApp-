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
      appBar: AppBar(automaticallyImplyLeading: true, title: Text('Cart')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),

              itemCount: 3,
              itemBuilder: (context, index) {
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
                        height: 100,
                        width: 90,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 234, 224, 224),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Image.network(
                          'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            'Title',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Category',
                            style: TextStyle(color: Colors.grey),
                          ),

                          Text('desciption'),
                          SizedBox(height: 10),
                          Text(
                            '\$1233',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        spacing: 20,
                        crossAxisAlignment: .end,
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,

                            onPressed: () {},
                            icon: Icon(Icons.delete_outline, size: 21),
                          ),

                          Container(
                            height: 35,
                            width: 107,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              border: BoxBorder.all(width: 1),
                            ),
                            child: Row(
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
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),

              child: TextFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                  hintText: 'Enter promo code',
                  suffixIcon: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text('APPLY'),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Column(
                spacing: 8,
                children: [
                  Row(
                    children: [
                      Text('Subtotal', style: TextStyle(fontSize: 18)),
                      Spacer(),
                      Text(
                        '\$256',
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
                        '-\$56',
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
                        '\$200',
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
          ],
        ),
      ),
    );
  }
}
