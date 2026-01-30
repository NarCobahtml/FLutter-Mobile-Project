import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SwaraNusa',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF110E33), // dark purple/navy
        fontFamily: 'Roboto',
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  // Color palette chosen to closely match the mockup
  static const Color primaryOrange = Color(0xFFF59E0B);
  static const Color secondaryBrown = Color(0xFF3E2A26);
  static const Color inputFill = Color(0xff3f2b2b); // darker translucent

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final width = mq.size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 50, 24, 36),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logo
              SizedBox(
                child: Column(
                  children: [
                    // Use SVG if provided; fall back to PNG placeholder
                    SizedBox(
                      width: width * 0.25,
                      height: width * 0.25,

                      child: SvgPicture.asset(
                        'assets/icon/logo.svg',
                        semanticsLabel: 'Logo',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Title
              const Text(
                'Selamat Datang di\nSwaraNusa',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.15,
                ),
              ),

              const SizedBox(height: 55),

              // Email field
              _buildInputField(hint: 'Email or Username'),
              const SizedBox(height: 14),

              // Password field
              _buildInputField(hint: 'Password', obscure: true),

              const SizedBox(height: 63),

              // Primary button - Log In
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Log In',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Secondary button - Sign Up
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: secondaryBrown,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    side: BorderSide.none,
                  ),

                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Color(0xFFF5A21A),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 35),

              // Divider with center label
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.white24)),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(color: const Color(0xFF2E2540)),
                    child: const Text(
                      'Atau lanjut dengan',
                      style: TextStyle(fontSize: 12, color: Colors.white70),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.white24)),
                ],
              ),

              const SizedBox(height: 25),

              // Social buttons
              Row(
                children: [
                  Expanded(
                    child: _socialButton(
                      context,
                      'Facebook',
                      'assets/icons/facebook.svg',
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _socialButton(
                      context,
                      'Google',
                      'assets/icons/google.svg',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildInputField({required String hint, bool obscure = false}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff282647),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        obscureText: obscure,
        style: const TextStyle(color: Colors.white70),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white54),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 18,
          ),
        ),
      ),
    );
  }

  Widget _socialButton(BuildContext context, String label, String assetName) {
    return SizedBox(
      height: 51,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3E2A26),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            // Icon (SVG preferred)
            SizedBox(
              width: 22,
              height: 22,
              child: SvgPicture.asset(
                assetName,
                placeholderBuilder: (context) =>
                    SvgPicture.asset('assets/icons/placeholder.svg'),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFFF5A21A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
