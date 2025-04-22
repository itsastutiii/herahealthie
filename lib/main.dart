import 'package:flutter/material.dart';
import 'package:herahealthie/splash_screen.dart';
import 'home_page.dart'; // Import the home page file
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  try {
    await dotenv.load(
        fileName:
            "/Users/sidharthasinha/Desktop/mini-project/herahealthie/.env");
    // Default
    print("✅ .env loaded successfully!");
    print("API Key: ${dotenv.env['API_KEY']}"); // Debugging
  } catch (e) {
    print("❌ ERROR: Failed to load .env file: $e");
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the debug banner
      title: 'Menstrual Health App',
      theme: ThemeData(
        dialogBackgroundColor: Colors.white,
        primarySwatch: Colors.pink,
      ),

      home: SplashScreen(), //init sc
      routes: {
        '/home': (context) => HomePage(), // 🔥 define this route
      },
    );
  }
}
