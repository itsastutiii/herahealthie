import 'package:flutter/material.dart';
import 'home_page.dart'; // Import the home page file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the debug banner
      title: 'Menstrual Health App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: HomePage(), // Set HomePage as the initial screen
    );
  }
}
