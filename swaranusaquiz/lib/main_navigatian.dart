import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:swaranusaquiz/home_page.dart';
import 'package:swaranusaquiz/reward_page.dart';
import 'package:swaranusaquiz/mode_page.dart';

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
  int? _pressedIndex;
  bool _isFabPressed = false;

  @override
  void initState() {
    super.initState();
    _bottomNavIndex = widget.initialIndex;
  }

  // PNG Icons from design
  final List<String> footerIcons = [
    "assets/image/icon_footer1.png",
    "assets/image/icon_footer2.png",
    "assets/image/icon_footer4.png",
    "assets/image/icon_footer5.png",
  ];

  final List<String> navLabels = ["Beranda", "Papan Skor", "Hadiah", "Profil"];

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(
        onNavigateToMode: () {
          setState(() {
            _bottomNavIndex = 4; // Switch to ModePage (index 4)
          });
        },
      ), // 0
      LeaderboardScreen(
        leaderboardData: LeaderboardData.getSampleData(),
        showNavbar: false,
      ), // 1
      const RewardPage(), // 2
      ProfileScreen(
        showNavbar: false,
        onRewardTap: () {
          setState(() {
            _bottomNavIndex = 2; // Index for RewardPage
          });
        },
      ), // 3
      const ModePage(), // 4
    ];

    return Scaffold(
      extendBody: true,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: pages[_bottomNavIndex < pages.length ? _bottomNavIndex : 0],
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
      floatingActionButton: Stack(
        alignment: Alignment.center,
        children: [
          // Theme-matching Glow Effect
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFFF59E0B).withAlpha(100),
                  const Color(0xFFF59E0B).withAlpha(50),
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
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF241D66), Color(0xFF141040)],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFF59E0B).withAlpha(80),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
              border: Border.all(
                color: _bottomNavIndex == 4
                    ? const Color(0xFFF59E0B)
                    : const Color(0xFFF59E0B).withAlpha(100),
                width: 2,
              ),
            ),
            child: ClipOval(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onHighlightChanged: (val) {
                    setState(() {
                      _isFabPressed = val;
                    });
                  },
                  onTap: () {
                    setState(() {
                      _bottomNavIndex = 4;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: AnimatedScale(
                      scale: _isFabPressed ? 0.85 : 1.0,
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.easeOut,
                      child: Image.asset(
                        'assets/image/icon_footer3.png',
                        color: _bottomNavIndex == 4
                            ? const Color(0xFFF59E0B)
                            : Colors.white,
                      ),
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
        itemCount: footerIcons.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? const Color(0xFFF59E0B) : Colors.white;

          return Listener(
            onPointerDown: (_) => setState(() => _pressedIndex = index),
            onPointerUp: (_) => setState(() => _pressedIndex = null),
            onPointerCancel: (_) => setState(() => _pressedIndex = null),
            child: AnimatedScale(
              scale: _pressedIndex == index ? 0.85 : 1.0,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeOut,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    footerIcons[index],
                    color: color,
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    navLabels[index],
                    style: TextStyle(
                      color: color,
                      fontSize: 10,
                      fontWeight: isActive
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        activeIndex: _bottomNavIndex >= 4 ? -1 : _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 20,
        rightCornerRadius: 20,
        backgroundColor: const Color(0xff0d0a27),
        splashColor: Colors.transparent, // Disable splash bubble
        splashRadius: 0,
        splashSpeedInMilliseconds: 0,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
      ),
    );
  }
}
