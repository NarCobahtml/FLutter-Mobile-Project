import 'package:flutter/material.dart';

class RewardScreen extends StatelessWidget {
  const RewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0d1129),
      body: SafeArea(
        child: Stack(
          children: [
            // Main Content
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    // Coin Balance
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _buildCoinBalance(),
                    ),

                    const SizedBox(height: 24),

                    // Koleksi Instrumen
                    _buildKoleksiInstrumen(),

                    const SizedBox(height: 24),

                    // Bonus Login
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _buildBonusLogin(),
                    ),

                    const SizedBox(height: 24),

                    // Misi Yang Aktif
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _buildMisiAktif(),
                    ),

                    const SizedBox(height: 24),

                    // Sasando Card
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _buildSasandoCard(),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom Navigation
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildBottomNavigation(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoinBalance() {
    return Container(
      width: 90,
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1a1d3e),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Coin icon placeholder
          Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              color: Color(0xFFffa726),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                '◎',
                style: TextStyle(
                  color: Color(0xFF0d1129),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 6),
          const Text(
            '2,123',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKoleksiInstrumen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Koleksi Instrumen',
            style: TextStyle(
              color: Color(0xFFffa726),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 140,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              _buildInstrumentCard(
                imagePath: 'assets/images/angklung.png',
                name: 'Angklung',
                subtitle: 'Jawa Barat',
                isLocked: false,
              ),
              const SizedBox(width: 12),
              _buildInstrumentCard(
                imagePath: 'assets/images/gamelan.png',
                name: 'Gamelan',
                subtitle: 'Jawa Tengah',
                isLocked: false,
              ),
              const SizedBox(width: 12),
              _buildInstrumentCard(
                imagePath: 'assets/images/kolintang.png',
                name: 'Kolintang',
                subtitle: 'Sulawesi',
                isLocked: true,
              ),
              const SizedBox(width: 12),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInstrumentCard({
    required String imagePath,
    required String name,
    required String subtitle,
    required bool isLocked,
  }) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: const Color(0xFF1a1d3e),
        borderRadius: BorderRadius.circular(12),
        border: isLocked
            ? Border.all(color: const Color(0xFFffa726), width: 1.5)
            : null,
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image placeholder
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF2a2d4e),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: isLocked
                    ? const Icon(Icons.lock, color: Color(0xFFffa726), size: 30)
                    : Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.image,
                            color: Color(0xFF666688),
                            size: 30,
                          );
                        },
                      ),
              ),
              const SizedBox(height: 8),
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFF888899),
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          if (isLocked)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: Color(0xFFffa726),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.lock,
                  color: Color(0xFF0d1129),
                  size: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBonusLogin() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Bonus Login',
          style: TextStyle(
            color: Color(0xFFffa726),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF2a1f3d),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // Calendar icon placeholder
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFffa726),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.calendar_today,
                  color: Color(0xFF2a1f3d),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Harian',
                      style: TextStyle(
                        color: Color(0xFFffa726),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Klaim bonus harianmu untuk menjaga tuntutan!',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF1a1d3e),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Text(
                      '+100',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                        color: Color(0xFFffa726),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          '◎',
                          style: TextStyle(
                            color: Color(0xFF0d1129),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMisiAktif() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Misi Yang Aktif',
              style: TextStyle(
                color: Color(0xFFffa726),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  color: Color(0xFF888899),
                  size: 16,
                ),
                const SizedBox(width: 4),
                const Text(
                  'Reset dalam 9 jam',
                  style: TextStyle(
                    color: Color(0xFF888899),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildMissionItem(
          title: 'Selesaikan 3 Kuis Tebak Suara',
          progress: 0.6,
          reward: '+50',
        ),
        const SizedBox(height: 12),
        _buildMissionItem(
          title: 'Identifikasi 5 Instrumen Bambu',
          progress: 0.4,
          reward: '+75',
        ),
      ],
    );
  }

  Widget _buildMissionItem({
    required String title,
    required double progress,
    required String reward,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                    color: Color(0xFFffa726),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '◎',
                      style: TextStyle(
                        color: Color(0xFF0d1129),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  reward,
                  style: const TextStyle(
                    color: Color(0xFFffa726),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: const Color(0xFF1a1d3e),
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFffa726),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSasandoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1a1d3e),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Image placeholder
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFF2a2d4e),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              'assets/images/sasando.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.image,
                  color: Color(0xFF666688),
                  size: 40,
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sasando',
                  style: TextStyle(
                    color: Color(0xFFffa726),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Buka alat musik khas Jawa Tengah.',
                  style: TextStyle(
                    color: Color(0xFF888899),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0d1129),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        '5000',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        width: 18,
                        height: 18,
                        decoration: const BoxDecoration(
                          color: Color(0xFFffa726),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text(
                            '◎',
                            style: TextStyle(
                              color: Color(0xFF0d1129),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: const Color(0xFF1a1d3e),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.home_outlined,
                label: 'Beranda',
                isActive: false,
              ),
              _buildNavItem(
                icon: Icons.bar_chart,
                label: 'Papan Skor',
                isActive: false,
              ),
              const SizedBox(width: 60), // Space for center button
              _buildNavItem(
                icon: Icons.verified_outlined,
                label: 'Hadiah',
                isActive: true,
              ),
              _buildNavItem(
                icon: Icons.person_outline,
                label: 'Profil',
                isActive: false,
              ),
            ],
          ),
          // Center elevated button
          Positioned(
            top: -20,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFFff6b6b), Color(0xFFff8e53)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFff6b6b).withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.card_giftcard,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isActive ? const Color(0xFFffa726) : const Color(0xFF888899),
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? const Color(0xFFffa726) : const Color(0xFF888899),
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
