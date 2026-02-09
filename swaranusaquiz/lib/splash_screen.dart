import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'main.dart';

class SplashScreenSvg extends StatefulWidget {
  const SplashScreenSvg({super.key});

  @override
  State<SplashScreenSvg> createState() => _SplashScreenSvgState();
}

class _SplashScreenSvgState extends State<SplashScreenSvg>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _quizController;
  late AnimationController _titleController;
  late AnimationController _fadeOutController;

  late Animation<double> _logoFadeAnimation;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _quizFadeAnimation;
  late Animation<double> _titleFadeAnimation;
  late Animation<Offset> _titleSlideAnimation;
  late Animation<double> _screenFadeOutAnimation;

  @override
  void initState() {
    super.initState();

    // Logo Animation Controller
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Quiz Text Animation Controller
    _quizController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Title Animation Controller
    _titleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Screen Fade Out Animation Controller
    _fadeOutController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Logo Fade Animation
    _logoFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeIn));

    // Logo Scale Animation
    _logoScaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );

    // Quiz Fade Animation
    _quizFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _quizController, curve: Curves.easeIn));

    // Title Fade Animation
    _titleFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _titleController, curve: Curves.easeIn));

    // Title Slide Animation
    _titleSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _titleController, curve: Curves.easeOut));

    // Screen Fade Out Animation
    _screenFadeOutAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _fadeOutController, curve: Curves.easeOut),
    );

    // Start Animation Sequence
    _startAnimationSequence();
  }

  void _startAnimationSequence() async {
    // Step 1: Logo animation (0ms - 800ms)
    await Future.delayed(const Duration(milliseconds: 300));
    _logoController.forward();

    // Step 2: Quiz text animation (800ms - 1300ms)
    await Future.delayed(const Duration(milliseconds: 600));
    _quizController.forward();

    // Step 3: Title animation (1300ms - 1900ms)
    await Future.delayed(const Duration(milliseconds: 300));
    _titleController.forward();

    // Step 4: Hold and navigate
    await Future.delayed(const Duration(milliseconds: 2500));

    // Step 5: Fade out before navigation
    if (mounted) {
      await _fadeOutController.forward();
    }

    // Navigate to next screen
    if (mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const HomePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 800),
        ),
      );
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _quizController.dispose();
    _titleController.dispose();
    _fadeOutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a2e),
      body: FadeTransition(
        opacity: _screenFadeOutAnimation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Animation
              FadeTransition(
                opacity: _logoFadeAnimation,
                child: ScaleTransition(
                  scale: _logoScaleAnimation,
                  child: Column(
                    children: [
                      // Logo SVG Placeholder
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: SvgPicture.asset(
                          'assets/icon/logo2.svg',
                          fit: BoxFit.contain,
                          // Placeholder jika SVG tidak ada
                          placeholderBuilder: (context) => Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFffa726),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.music_note,
                              size: 60,
                              color: Color(0xFF1a1a2e),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Quiz Text Animation
                      FadeTransition(
                        opacity: _quizFadeAnimation,
                        child: const Text(
                          'Quiz',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Title Animation
              SlideTransition(
                position: _titleSlideAnimation,
                child: FadeTransition(
                  opacity: _titleFadeAnimation,
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Swara',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                        TextSpan(
                          text: 'Nusa',
                          style: TextStyle(
                            color: Color(0xFFffa726),
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
