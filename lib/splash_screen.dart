import 'package:flutter/material.dart';
import 'package:herahealthie/signup_screen.dart';
import 'login_screen.dart';
// import 'screens/auth/signup_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonStyle = OutlinedButton.styleFrom(
      side: const BorderSide(color: Colors.black),
      minimumSize: const Size(200, 48),
      foregroundColor: Colors.black,
      textStyle: const TextStyle(fontWeight: FontWeight.w600),
    ).copyWith(
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed) ||
              states.contains(MaterialState.hovered)) {
            return const Color(0xFFFFC0CB)
                .withOpacity(0.3); // light pink on press/hover
          }
          return null; // no splash otherwise
        },
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white, // mild pink
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              'assets/logo_bg.png',
              width: 180,
              height: 180,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 24),

            // Text
            const Text(
              'Welcome to HeraHealth <3',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Buttons
            OutlinedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
              ),
              style: buttonStyle,
              child: const Text('Login'),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpScreen()),
                );
              },
              // onPressed: () => Navigator.push(
              // context,
              // MaterialPageRoute(builder: (_) => SignUpScreen()),
              // ),
              style: buttonStyle,
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
