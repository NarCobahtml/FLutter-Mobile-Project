import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'main_navigatian.dart';

class ProfileScreen extends StatelessWidget {
  // Internal dummy profile data — no need to pass anything from caller
  static const String _dummyUserName = 'John Doe';
  static const String _dummyUserHandle = '@DoeMusic';
  static const String _dummyAvatarPath = 'assets/image/profile.png';
  static const int _dummyQuizCompleted = 67;
  static const int _dummyCorrectAnswerPercentage = 84;
  static const int _dummyBadgesEarned = 6;
  static const Color statColor = Color(0xff1d1a3d);

  // exposed as getters so existing widget code continues to work unchanged
  String get userName => _dummyUserName;
  String get userHandle => _dummyUserHandle;
  String? get avatarPath => _dummyAvatarPath;
  int get quizCompleted => _dummyQuizCompleted;
  int get correctAnswerPercentage => _dummyCorrectAnswerPercentage;
  int get badgesEarned => _dummyBadgesEarned;

  final VoidCallback? onRewardsAndMissionsTap;
  final Function(int)? onNavigationTap;

  /// Optional: daftar asset SVG untuk ikon bottom nav (urut: beranda, papan skor, hadiah, profil)
  final List<String>? bottomNavIconAssets;

  /// Optional: asset SVG untuk ikon tengah (floating action)
  final String centerNavIconAsset = 'assets/icon/gamemode.svg';

  /// index aktif untuk mewarnai navbar (default = Profil)
  final int currentIndex;
  final bool showNavbar;

  const ProfileScreen({
    Key? key,
    this.onRewardsAndMissionsTap,
    this.onNavigationTap,
    this.bottomNavIconAssets,

    this.currentIndex = 3,
    this.showNavbar = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF110E33),
      body: Stack(
        children: [
          // Scrollable Content
          SafeArea(
            bottom: false,
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.only(bottom: 40),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      const SizedBox(height: 12),
                      // Header
                      const Center(
                        child: Text(
                          'Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                      const SizedBox(height: 36),
                      // Avatar Section
                      _buildAvatarSection(),
                      const SizedBox(height: 24),
                      // Stats Cards
                      _buildStatsCards(),
                      const SizedBox(height: 15),
                      // Rewards & Missions Card
                      _buildRewardsCard(),
                      const SizedBox(height: 32),
                      // Badges Section
                      _buildBadgesSection(),
                      const SizedBox(height: 20),
                    ]),
                  ),
                ),
              ],
            ),
          ),
          // Fixed Bottom Navigation deleted
        ],
      ),
      floatingActionButton: showNavbar
          ? Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF6B9D), Color(0xFF9B51E0)],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ClipOval(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      // Action for center button (e.g. Gamemode)
                      if (onNavigationTap != null)
                        onNavigationTap!(1); // Index 1 is gamemode usually?
                      // Wait, in the image list: Home(0), Leaderboard(1), Reward(2), Profile(3)
                      // But main_nav has 5 pages.
                      // Let's assume Middle button does nothing or goes to GameMode?
                      // User said "without changing page content".
                      // I will leave onTap empty or link to something safe.
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        'assets/icon/gamemode.svg',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: showNavbar
          ? AnimatedBottomNavigationBar.builder(
              itemCount: 4,
              tabBuilder: (int index, bool isActive) {
                final icons = [
                  "assets/icon/home.svg",
                  "assets/icon/leaderboard.svg",
                  "assets/icon/reward.svg",
                  "assets/icon/profile.svg",
                ];
                final labels = ["Beranda", "Papan Skor", "Hadiah", "Profil"];
                final color = isActive ? const Color(0xFFF59E0B) : Colors.white;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      icons[index],
                      color: color,
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      labels[index],
                      style: TextStyle(color: color, fontSize: 10),
                    ),
                  ],
                );
              },
              activeIndex: 3, // Profile is index 3 in this 4-item list
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.softEdge,
              leftCornerRadius: 32,
              rightCornerRadius: 32,
              backgroundColor: const Color(0xFF252850),
              onTap: (index) {
                if (onNavigationTap != null) {
                  onNavigationTap!(index);
                } else {
                  if (index == 3) return; // Already on Profile
                  int mainNavIndex = 0;
                  if (index == 0) mainNavIndex = 0; // Home
                  if (index == 1) mainNavIndex = 1; // Leaderboard
                  if (index == 2) mainNavIndex = 2; // Reward

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MainNavigation(initialIndex: mainNavIndex),
                    ),
                  );
                }
              },
            )
          : null,
    );
  }

  Widget _buildAvatarSection() {
    return Column(
      children: [
        // Avatar
        Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFFFB020), width: 5),
          ),
          child: ClipOval(
            child: avatarPath != null
                ? Image.asset(
                    'assets/image/profil3.png',
                    width: 10000,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildAvatarPlaceholder();
                    },
                  )
                : _buildAvatarPlaceholder(),
          ),
        ),
        const SizedBox(height: 4),
        // Name
        Text(
          userName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 1),
        // Handle
        Text(
          userHandle,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w100,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }

  Widget _buildAvatarPlaceholder() {
    return Container(
      color: const Color(0xFF3D3F73),
      child: const Center(
        child: Icon(Icons.person, color: Color(0xFF6E70A8), size: 60),
      ),
    );
  }

  Widget _buildStatsCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: _StatCard(
              value: quizCompleted.toString(),
              label: 'Kuis\nDiselesaikan',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _StatCard(
              value: '$correctAnswerPercentage%',
              label: 'Jawaban\nBenar',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _StatCard(
              value: badgesEarned.toString(),
              label: 'Lencana\nDidapatkan',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardsCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onRewardsAndMissionsTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),

            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,

                colors: [Color(0xFF241D66), Color(0xFF141040)],

                stops: [0.03, 1.0],
              ),

              borderRadius: BorderRadius.circular(32),

              border: Border.all(color: Color(0x1AFFFFFF), width: 1),
            ),

            child: Row(
              children: [
                // Trophy Icon
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: SvgPicture.asset(
                    'assets/icon/piala.svg',
                    width: 15,
                    height: 15,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFFFFB020),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hadiah & Misi',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Cek progressmu dan klaim hadiah',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                // Arrow Icon
                Icon(Icons.chevron_right, color: Colors.white, size: 28),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBadgesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Lencana',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 16),
          // Badges Grid
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 20,
            crossAxisSpacing: 16,
            childAspectRatio: 0.85,
            children: [
              _BadgeItem(stars: 1, label: 'Buat Akun', fontSize: 14),
              _BadgeItem(stars: 3, label: 'Suling Virtuoso', fontSize: 14),
              _BadgeItem(stars: 4, label: 'Angklung Pro', fontSize: 14),
              _BadgeItem(stars: 2, label: 'Pemula', fontSize: 14),
              _BadgeItem(stars: 5, label: 'Kolektor', fontSize: 14),
              _BadgeItem(stars: 4, label: 'Skor 100%', fontSize: 14),
            ],
          ),
        ],
      ),
    );
  }
}

/// Stat Card Widget
class _StatCard extends StatelessWidget {
  final String value;
  final String label;

  const _StatCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xff1d1a3d),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFFFFB020),
              fontSize: 30,
              fontWeight: FontWeight.bold,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

/// Badge Item Widget
class _BadgeItem extends StatelessWidget {
  final int stars;
  final String label;

  final double fontSize;

  const _BadgeItem({
    required this.stars,
    required this.label,

    this.fontSize = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Badge Circle
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFFFB020), width: 3),
          ),
          child: Center(child: _buildStars()),
        ),
        const SizedBox(height: 8),
        // Label
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            height: 1.2,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildStars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        stars > 3 ? 3 : stars,
        (index) => Padding(
          padding: EdgeInsets.symmetric(
            horizontal: stars == 1 ? 0 : (stars == 2 ? 2 : 1),
          ),
          child: Icon(
            Icons.star,
            color: const Color(0xFFFFB020),
            size: stars == 1
                ? 32
                : stars == 2
                ? 24
                : stars == 3
                ? 20
                : stars == 4
                ? 18
                : 16,
          ),
        ),
      ),
    );
  }
}
