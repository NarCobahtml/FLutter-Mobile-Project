import 'package:flutter/material.dart';

class RewardPage extends StatelessWidget {
  const RewardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: 100, // Padding for navbar
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // Coin Balance
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF241D66), Color(0xFF141040)],
                      stops: [0.03, 1.0],
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        '2,123',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Image.asset(
                        'assets/image/icon_footer4.png',
                        width: 16,
                        height: 16,
                        color: Color(0xFFF59E0B),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Koleksi Instrumen
                const Text(
                  'Koleksi Instrumen',
                  style: TextStyle(
                    color: Color(0xFFF59E0B),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                // Instrumen Cards
                SizedBox(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _InstrumentCard(
                        imagePath: 'assets/image/gambar_angklung.png',
                        name: 'Angklung',
                        region: 'Jawa Barat',
                      ),
                      const SizedBox(width: 12),
                      _InstrumentCard(
                        imagePath: 'assets/image/gambar_gamelan.png',
                        name: 'Gamelan',
                        region: 'Jawa Tengah',
                      ),
                      const SizedBox(width: 12),
                      _InstrumentCard(
                        imagePath: 'assets/image/gambar_kolintang.png',
                        name: 'Kolintang',
                        region: 'Sulawesi Utara',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Bonus Login Harian
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        const Color(0xFFF59E0B).withValues(alpha: 0.2),
                        Colors.transparent,
                      ],
                      stops: const [0.2, 1.0],
                    ),
                    color: const Color(0xFF3D2F1F),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/image/icon_calendar.png',
                        width: 48,
                        height: 48,
                        color: const Color(0xFFF59E0B),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Bonus Login Harian',
                              style: TextStyle(
                                color: Color(0xFFF59E0B),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Klaim bonus harianmu untuk menjaga rutinitas!',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
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
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFF241D66), Color(0xFF141040)],
                            stops: [0.03, 1.0],
                          ),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: const Color(0xFFF59E0B),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Text(
                              '+100',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Image.asset(
                              'assets/image/icon_footer4.png',
                              width: 16,
                              height: 16,
                              color: Color(0xFFF59E0B),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Misi Yang Aktif Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        'Misi Yang Aktif',
                        style: TextStyle(
                          color: Color(0xFFF59E0B),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      'Reset dalam 9 jam',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Active Missions
                _MissionCard(
                  title: 'Selesaikan 3 Kuis Tebak Suara',
                  progress: 0.6,
                  reward: 50,
                ),
                const SizedBox(height: 12),
                _MissionCard(
                  title: 'Identifikasi 5 Instrumen Bambu',
                  progress: 0.2,
                  reward: 75,
                ),
                const SizedBox(height: 24),
                // Unlock Instrument Card
                _UnlockInstrumentCard(
                  imagePath: 'assets/image/gambar_sasando.png',
                  name: 'Sasando',
                  description: 'Buka alat musik khas Nusa Tenggara Timur',
                  price: 5000,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Instrument Card Widget
class _InstrumentCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String region;

  const _InstrumentCard({
    required this.imagePath,
    required this.name,
    required this.region,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF241D66), Color(0xFF141040)],
          stops: [0.03, 1.0],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            region,
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Mission Card Widget
class _MissionCard extends StatelessWidget {
  final String title;
  final double progress;
  final int reward;

  const _MissionCard({
    required this.title,
    required this.progress,
    required this.reward,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF241D66), Color(0xFF141040)],
          stops: [0.03, 1.0],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
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
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/image/icon_footer4.png',
                    width: 16,
                    height: 16,
                    color: Color(0xFFF59E0B),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '+$reward',
                    style: const TextStyle(
                      color: Color(0xFFF59E0B),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white24,
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFFF59E0B),
              ),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}

// Unlock Instrument Card Widget
class _UnlockInstrumentCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String description;
  final int price;

  const _UnlockInstrumentCard({
    required this.imagePath,
    required this.name,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF241D66), Color(0xFF141040)],
          stops: [0.03, 1.0],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Color(0xFFF59E0B),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF110E33),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: const Color(0xFFF59E0B), width: 1),
            ),
            child: Row(
              children: [
                Text(
                  '$price',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 6),
                Image.asset(
                  'assets/image/icon_footer4.png',
                  width: 16,
                  height: 16,
                  color: Color(0xFFF59E0B),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
