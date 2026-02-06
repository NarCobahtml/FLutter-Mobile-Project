import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

// halaman kamu
import 'home.dart';
import 'quiz.dart';
import 'leaderb
oard.dart';
import 'history.dart';
import 'profile.dart';

class MainNavigation extends StatefulWidget {
  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _bottomNavIndex = 0;

  // PATH SVG KAMU
  final List<String> svgIcons = [
    "assets/icons/home.svg",
    "assets/icons/quiz.svg",
    "assets/icons/leaderboard.svg",
    "assets/icons/history.svg",
    "assets/icons/profile.svg",
  ];

  final List<Widget> pages = [
    HomeScreen(),
    QuizScreen(),
    LeaderboardScreen(),
    HistoryScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_bottomNavIndex],

      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: svgIcons.length,

        tabBuilder: (int index, bool isActive) {
          final color = isActive ? Colors.blue : Colors.grey;

          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                svgIcons[index],
                color: color,
                width: 24,
                height: 24,
              ),
            ],
          );
        },

        activeIndex: _bottomNavIndex,

        gapLocation: GapLocation.none,

        notchSmoothness: NotchSmoothness.softEdge,

        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
      ),
    );
  }
}
