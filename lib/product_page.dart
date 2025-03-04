import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'cart.dart';

class ProductPage extends StatelessWidget {
  final Map<String, dynamic> product;

  ProductPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['name']),
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 300.0,
                enableInfiniteScroll: true,
                autoPlay: true,
              ),
              items: (product['images'] as List<String>).map((image) {
                return Image.asset(image,
                    fit: BoxFit.cover, width: double.infinity);
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              product['name'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 20),
                Text(' ${product['rating']}'),
                Spacer(),
                Text(
                  '₹${product['price']}',
                  style: TextStyle(fontSize: 24, color: Colors.green),
                ),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: Text('Add to Cart'),
            ),
            Divider(),
            Text(
              'Product Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(product['description']),
            SizedBox(height: 10),
            Text(
              'Eco-Friendliness: ${product['ecoScore']}%',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Vegan: ${product['vegan'] ? "Yes" : "No"}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Cruelty-Free: ${product['crueltyFree'] ? "Yes" : "No"}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
