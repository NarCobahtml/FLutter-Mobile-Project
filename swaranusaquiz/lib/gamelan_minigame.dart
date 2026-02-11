import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class GamelanMinigamePage extends StatefulWidget {
  const GamelanMinigamePage({super.key});

  @override
  State<GamelanMinigamePage> createState() => _GamelanMinigamePageState();
}

class _GamelanMinigamePageState extends State<GamelanMinigamePage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int? _activePotIndex;

  // Placeholder sound
  final List<String> _notes = [
    'audio/n1.mp3',
    'audio/n2.mp3',
    'audio/n3.mp3',
    'audio/n4.mp3',
    'audio/n5.mp3',
    'audio/n6.mpeg',
  ];

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playNote(int index) async {
    setState(() {
      _activePotIndex = index;
    });

    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource(_notes[index]));
    } catch (e) {
      debugPrint('Error playing sound: $e');
    }

    // Reset active state after a short delay
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        setState(() {
          _activePotIndex = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF110E33),
      body: Stack(
        children: [
          // Background Glow Effects
          Positioned(
            top: 100,
            left: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFF59E0B).withAlpha(20),
              ),
            ),
          ),
          Positioned(
            bottom: 200,
            right: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.indigo.withAlpha(20),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                _buildHeader(context),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Center(child: _buildGamelanBoard()),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCircleButton(
            icon: Icons.chevron_left,
            onTap: () => Navigator.pop(context),
          ),
          const Text(
            'Gamelan',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(width: 44),
        ],
      ),
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withAlpha(20),
        ),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
    );
  }

  Widget _buildGamelanBoard() {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 400),
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFF3E2723), Color(0xFF5D4037), Color(0xFF3E2723)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(120),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: Colors.white.withAlpha(20)),
      ),
      child: Stack(
        children: [
          // Vertical lines
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(width: 2, color: Colors.black.withAlpha(50)),
                Container(width: 2, color: Colors.black.withAlpha(50)),
              ],
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 30,
              crossAxisSpacing: 30,
              childAspectRatio: 1,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return _buildGamelanPot(index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGamelanPot(int index) {
    bool isActive = _activePotIndex == index;

    return GestureDetector(
      onTapDown: (_) => _playNote(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        transform: Matrix4.identity()..scale(isActive ? 0.94 : 1.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer pot
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isActive
                      ? [const Color(0xFFFBBF24), const Color(0xFFD97706)]
                      : [const Color(0xFFB45309), const Color(0xFF78350F)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(isActive ? 150 : 80),
                    blurRadius: isActive ? 15 : 6,
                    offset: Offset(0, isActive ? 4 : 2),
                  ),
                  if (isActive)
                    BoxShadow(
                      color: const Color(0xFFF59E0B).withAlpha(100),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                ],
                border: Border.all(
                  color: Colors.white.withAlpha(isActive ? 60 : 30),
                  width: 1.5,
                ),
              ),
            ),
            // Inner circle
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withAlpha(20),
                border: Border.all(color: Colors.black.withAlpha(40), width: 1),
              ),
            ),
            // Center
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  center: const Alignment(-0.2, -0.2),
                  colors: isActive
                      ? [Colors.white, const Color(0xFFFBBF24)]
                      : [
                          const Color(0xFFFBBF24).withAlpha(200),
                          const Color(0xFF92400E),
                        ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(isActive ? 100 : 60),
                    blurRadius: 3,
                    offset: const Offset(0, 1.5),
                  ),
                ],
              ),
            ),
            // Note number
            Text(
              '${index + 1}',
              style: TextStyle(
                color: Colors.white.withAlpha(isActive ? 255 : 100),
                fontWeight: FontWeight.bold,
                fontSize: 14,
                shadows: [
                  Shadow(
                    color: Colors.black.withAlpha(150),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
