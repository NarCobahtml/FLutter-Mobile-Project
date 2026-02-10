import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'main_navigatian.dart';

class LeaderboardScreen extends StatelessWidget {
  final int? currentUserId;
  final List<LeaderboardUser> leaderboardData;
  final Function(int)? onNavigationTap;
  final bool showNavbar;

  static const Color backgroundColor = Color(0xFF110E33);
  static const Color gradient1 = Color(0xFF241D66);
  static const Color gradient2 = Color(0xFF141040);
  static const Color primaryOrange = Color(0xFFF59E0B);

  const LeaderboardScreen({
    Key? key,
    this.currentUserId,
    required this.leaderboardData,
    this.onNavigationTap,
    this.showNavbar = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final top3 = leaderboardData.length >= 3
        ? leaderboardData.sublist(0, 3)
        : leaderboardData;
    final rest = leaderboardData.length > 3
        ? leaderboardData.sublist(3)
        : <LeaderboardUser>[];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                const SizedBox(height: 10),
                _buildHeader(),
                const SizedBox(height: 20),
                _buildTabBar(),
                const SizedBox(height: 24),
                _buildTop3Podium(top3),
                const SizedBox(height: 20),
                Expanded(child: _buildLeaderboardList(rest)),
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
                      // Action for center button
                      if (onNavigationTap != null) onNavigationTap!(1);
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
              activeIndex: 1, // Leaderboard is index 1 in this list?
              // Wait, in 4-item list: Home(0), Leaderboard(1), Reward(2), Profile(3). Yes.
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.softEdge,
              leftCornerRadius: 32,
              rightCornerRadius: 32,
              backgroundColor: const Color(0xFF252850),
              onTap: (index) {
                if (onNavigationTap != null) {
                  onNavigationTap!(index);
                } else {
                  if (index == 1) return;
                  int mainNavIndex = 0;
                  if (index == 0) mainNavIndex = 0;
                  if (index == 2) mainNavIndex = 2;
                  if (index == 3) mainNavIndex = 3;

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

  Widget _buildHeader() {
    return const Center(
      child: Text(
        'Papan Skor',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 48,
        width: 253,

        alignment: Alignment.center,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF241D66), Color(0xFF141040)],
          ),

          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),

        child: const Text(
          'Global',
          style: TextStyle(
            color: primaryOrange,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildTop3Podium(List<LeaderboardUser> top3) {
    if (top3.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SizedBox(
        height: 160,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // #2 Maya (Kiri)
            if (top3.length >= 2)
              Expanded(
                child: _buildPodiumItem(
                  user: top3[1],

                  avatarSize: 76,
                  borderWidth: 3,
                ),
              ),
            const SizedBox(width: 20),
            // #1 Arya (Tengah)
            if (top3.isNotEmpty)
              Expanded(
                child: _buildPodiumItem(
                  user: top3[0],

                  avatarSize: 96,
                  borderWidth: 4,
                ),
              ),
            const SizedBox(width: 20),
            // #3 Budi (Kanan)
            if (top3.length >= 3)
              Expanded(
                child: _buildPodiumItem(
                  user: top3[2],

                  avatarSize: 76,
                  borderWidth: 3,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPodiumItem({
    required LeaderboardUser user,
    required double avatarSize,
    required double borderWidth,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: avatarSize,
          height: avatarSize,

          decoration: BoxDecoration(
            shape: BoxShape.circle,

            image: DecorationImage(
              image: AssetImage(
                user.avatarPath ?? 'assets/image/avatarJoko.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),

        const SizedBox(height: 10),

        Text(
          user.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          _formatScore(user.score),
          style: const TextStyle(
            color: Color(0xFFFFB020),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderboardList(List<LeaderboardUser> users) {
    return Container(
      // margin bottom removed to prevent "purple gap"
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final rank = index + 4;
          final isCurrentUser = user.id == currentUserId;

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _LeaderboardListItem(
              rank: rank,
              user: user,
              isCurrentUser: isCurrentUser,
            ),
          );
        },
      ),
    );
  }

  String _formatScore(int score) {
    return score.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}

class _LeaderboardListItem extends StatelessWidget {
  final int rank;
  final LeaderboardUser user;
  final bool isCurrentUser;

  const _LeaderboardListItem({
    required this.rank,
    required this.user,
    this.isCurrentUser = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

      decoration: BoxDecoration(
        color: isCurrentUser ? const Color(0xFF271D2F) : null,

        gradient: isCurrentUser
            ? null
            : const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF241D66), Color(0xFF141040)],
              ),

        borderRadius: BorderRadius.circular(32),

        border: Border.all(
          color: isCurrentUser
              ? const Color(0x80F59E0B)
              : const Color(0x1AFFFFFF),

          width: 1.2,
        ),
      ),

      child: Row(
        children: [
          SizedBox(
            width: 20,
            child: Text(
              '$rank',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(width: 16),

          Container(
            width: 48,
            height: 48,

            decoration: BoxDecoration(
              shape: BoxShape.circle,

              border: Border.all(color: Colors.white, width: 2),

              image: const DecorationImage(
                image: AssetImage('assets/image/avatarJoko.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  'Skor: ${_formatScore(user.score)}',
                  style: TextStyle(
                    color: Color(0x99FFFFFF),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          Text(
            _formatScore(user.score),
            style: const TextStyle(
              color: Color(0xFFFFB020),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  String _formatScore(int score) {
    return score.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}

class LeaderboardUser {
  final int id;
  final String name;
  final int score;
  final String? avatarPath;

  const LeaderboardUser({
    required this.id,
    required this.name,
    required this.score,
    this.avatarPath,
  });
}

class LeaderboardData {
  static List<LeaderboardUser> getSampleData() {
    return const [
      LeaderboardUser(
        id: 1,
        name: 'Arya',
        score: 12500,
        avatarPath: 'assets/image/juara1.png',
      ),

      LeaderboardUser(
        id: 2,
        name: 'Maya',
        score: 11800,
        avatarPath: 'assets/image/silver.png',
      ),

      LeaderboardUser(
        id: 3,
        name: 'Budi',
        score: 11200,
        avatarPath: 'assets/image/bronze.png',
      ),

      LeaderboardUser(id: 4, name: 'Citra', score: 10500),
      LeaderboardUser(id: 5, name: 'Joko', score: 9800),
      LeaderboardUser(id: 6, name: 'Rani', score: 9200),
      LeaderboardUser(id: 7, name: 'Anda', score: 8500),
      LeaderboardUser(id: 8, name: 'Rani', score: 9200),
      LeaderboardUser(id: 9, name: 'Rani', score: 9200),
      LeaderboardUser(id: 10, name: 'Rani', score: 7800),
      LeaderboardUser(id: 11, name: 'Rani', score: 5200),
      LeaderboardUser(id: 12, name: 'Rani', score: 5000),
    ];
  }
}
