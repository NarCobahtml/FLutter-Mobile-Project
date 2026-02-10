import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

// halaman kamu
import 'leaderboard.dart';
import 'profil.dart';

class MainNavigation extends StatefulWidget {
  final int initialIndex;

  const MainNavigation({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  late int _bottomNavIndex;

  @override
  void initState() {
    super.initState();
    _bottomNavIndex = widget.initialIndex;
  }

  // PATH SVG KAMU (Updated to 4 items + Center FAB logic)
  final List<String> svgIcons = [
    "assets/icon/home.svg",
    "assets/icon/leaderboard.svg",
    "assets/icon/reward.svg",
    "assets/icon/profile.svg",
  ];

  final List<String> navLabels = ["Beranda", "Papan Skor", "Hadiah", "Profil"];

  final List<Widget> pages = [
    const Scaffold(
      backgroundColor: Color(0xFF110E33),
      body: Center(
        child: Text(
          'Beranda',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    ), // Beranda 0 - Placeholder
    LeaderboardScreen(
      leaderboardData: LeaderboardData.getSampleData(),
      showNavbar: false,
    ), // Leaderboard 1
    const Scaffold(
      backgroundColor: Color(0xFF110E33),
      body: Center(
        child: Text(
          'Hadiah',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    ), // Hadiah 2 - Placeholder
    ProfileScreen(showNavbar: false), // Profile 3
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, //
      body: pages[_bottomNavIndex < pages.length ? _bottomNavIndex : 0],

      floatingActionButton: Stack(
        alignment: Alignment.center,
        children: [
          // Glow Effect
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFFFF6B9D).withValues(alpha: 0.4),
                  const Color(0xFF9B51E0).withValues(alpha: 0.4),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF1a1a4a), // Match navbar background
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF6B9D).withValues(alpha: 0.35),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
                BoxShadow(
                  color: const Color(0xFF9B51E0).withValues(alpha: 0.35),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ClipOval(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    // Action for center button
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SvgPicture.asset(
                      'assets/icon/gamemode.svg',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: svgIcons.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? const Color(0xFFF59E0B) : Colors.white;

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
              const SizedBox(height: 4),
              Text(
                navLabels[index],
                style: TextStyle(color: color, fontSize: 10),
              ),
            ],
          );
        },
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 15,
        rightCornerRadius: 15,
        backgroundColor: const Color(0xFF1a1a4a), // Deep dark navy
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
      ),
    );
  }
}
