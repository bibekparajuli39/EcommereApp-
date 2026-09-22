import 'package:app_project/features/image/image_ad.dart';
import 'package:app_project/features/product/screens/product_screen.dart';
import 'package:flutter/material.dart';

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
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, Bibek!',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Discover products you'll love",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),

            Spacer(),

            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkHpbyaPU2ALxd1HsLes7GoSOOPVRMyH8-BsNSgBThWQ&s=10',
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,

        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.only(top: 15),
          child: Column(
            spacing: 20,
            crossAxisAlignment: .start,
            children: [
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                    prefixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search_sharp),
                    ),
                    hintText: 'Search anything',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F3FA),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(width: 0.2, color: Colors.grey),
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: .start,
                      spacing: 10,
                      children: [
                        Text('SUMMER COLLECTION'),
                        Text(
                          'New Arrivals \nAre Here',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          onPressed: () {},
                          child: Text(
                            'Shop Now',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Expanded(child: ImageAd()),
                  ],
                ),
              ),

              ProductScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
