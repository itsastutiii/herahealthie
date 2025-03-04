import 'package:flutter/material.dart';
import 'home_page.dart'; // Import Home Page for navigation

class BlogsPage extends StatelessWidget {
  final List<Map<String, String>> blogs = [
    {
      "imagePath": "assets/blog/blog1.png",
      "title": "The Science Behind Endometriosis",
      "author": "Dr. A. Sharma"
    },
    {
      "imagePath": "assets/blog/blog2.png",
      "title": "How Nutrition Impacts Hormonal Balance",
      "author": "Sarah Lee"
    },
    {
      "imagePath": "assets/blog3.jpg",
      "title": "Managing Chronic Pain with Mindfulness",
      "author": "John Doe"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        title: Text('Blogs', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: blogs.length,
          itemBuilder: (context, index) {
            return BlogCard(
              imagePath: blogs[index]["imagePath"]!,
              title: blogs[index]["title"]!,
              author: blogs[index]["author"]!,
            );
          },
        ),
      ),

      // 🔽 Bottom Navigation Bar
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.article),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => BlogsPage()),
                );
              },
            ),
            IconButton(icon: Icon(Icons.local_hospital), onPressed: () {}),
            SizedBox(width: 40), // Space for floating action button
            IconButton(icon: Icon(Icons.chat), onPressed: () {}),
            IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add_circle, size: 32, color: Colors.white),
        backgroundColor: Colors.pink.shade300, // Lighter pink shade
        shape: CircleBorder(),
        elevation: 5,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

// 🔽 Blog Card Widget
class BlogCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String author;

  BlogCard(
      {required this.imagePath, required this.title, required this.author});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔽 Image at the top with 100% width & 60-70% height
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              imagePath,
              width: double.infinity, // Full width
              height: 160, // Adjusted for 60-70% of the card height
              fit: BoxFit.cover, // Ensures the image fits well
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, height: 1.3),
                ),
                SizedBox(height: 5),
                Text(
                  "By $author",
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
