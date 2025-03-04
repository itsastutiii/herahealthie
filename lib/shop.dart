import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'cart.dart';
import 'product_page.dart';

class ShopPage extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Organic Pads',
      'price': 299,
      'rating': 4.5,
      'images': [
        'assets/shop/orgpad/organic_pad.png',
        'assets/shop/orgpad/organic_pad_1.png',
        'assets/shop/orgpad/organic_pad_2.png',
        'assets/shop/orgpad/organic_pad_3.png',
      ],
      'description':
          'Made with 100% organic bamboo on the core, biodegradable, and free from harmful chemicals. Dermatologically tested for sensitive skin.',
      'ecoScore': 90,
      'vegan': true,
      'crueltyFree': true,
    },
    {
      'name': 'Menstrual Cup',
      'price': 499,
      'rating': 4.7,
      'images': [
        'assets/shop/stru/stru_cup.png',
        'assets/shop/stru/stru_cup_1.png',
        'assets/shop/stru/stru_cup_2.png',
        'assets/shop/stru/stru_cup_3.png',
      ],
      'description':
          'Medical-grade silicone, reusable for up to 10 years. A sustainable alternative to pads and tampons.',
      'ecoScore': 95,
      'vegan': true,
      'crueltyFree': true,
    },
    {
      'name': 'Heating Pad',
      'price': 799,
      'rating': 4.2,
      'images': [
        'assets/shop/kittypad/kitty.png',
        'assets/shop/kittypad/kitty_1.png',
        'assets/shop/kittypad/kitty_2.png',
        'assets/shop/kittypad/kitty_3.png',
        'assets/shop/kittypad/kitty_4.png',
      ],
      'description':
          'Electric heating pad for menstrual cramps. Provides quick relief with adjustable temperature settings.',
      'ecoScore': 80,
      'vegan': true,
      'crueltyFree': false,
    },
    {
      'name': 'Chia & Flaxseed Seeds',
      'price': 600,
      'rating': 4.2,
      'images': [
        'assets/shop/candf/candf.png',
        'assets/shop/candf/candf_1.png',
        'assets/shop/candf/candf_2.png',
      ],
      'description':
          'Electric heating pad for menstrual cramps. Provides quick relief with adjustable temperature settings.',
      'ecoScore': 80,
      'vegan': true,
      'crueltyFree': false,
    },
    {
      'name': 'Protein Bars',
      'price': 89,
      'rating': 4.2,
      'images': [
        'assets/shop/protee/protee.png',
        'assets/shop/protee/protee_1.png',
        'assets/shop/protee/protee_2.png',
      ],
      'description':
          'Electric heating pad for menstrual cramps. Provides quick relief with adjustable temperature settings.',
      'ecoScore': 80,
      'vegan': true,
      'crueltyFree': false,
    },
    {
      'name': 'Chamomile Tea',
      'price': 400,
      'rating': 4.2,
      'images': [
        'assets/shop/tea/tea.png',
        'assets/shop/tea/tea_1.png',
        'assets/shop/tea/tea_2.png',
      ],
      'description':
          'Electric heating pad for menstrual cramps. Provides quick relief with adjustable temperature settings.',
      'ecoScore': 80,
      'vegan': true,
      'crueltyFree': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 150, // 50% of screen height
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/shop/shop_banner.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 items per row
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.9, // Adjusted for uniform size
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductPage(product: product),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsets.all(5.0), // Thin border effect
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(8), // Smooth edges
                                child: Image.asset(
                                  product['images'][0],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                Text(
                                  product['name'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.star,
                                        color: Colors.amber, size: 16),
                                    Text('${product['rating']}'),
                                  ],
                                ),
                                Text(
                                  '₹${product['price']}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                  ),
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
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(Icons.add_circle,
      //       size: 32, color: Colors.white), // Icon color white for contrast
      //   backgroundColor:
      //       const Color.fromARGB(255, 232, 62, 118), // Lighter pink shade
      //   shape: CircleBorder(), // Ensures it's perfectly circular
      //   elevation: 5, // Slight shadow effect
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
