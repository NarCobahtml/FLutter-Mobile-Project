import 'package:swaranusaquiz/kuis/kuis_pertanyaan/kuis_pertanyaan1.dart';
import 'package:flutter/material.dart';

class _Colors {
  static const bgDeep = Color(0xFF110E33);
  static const brandOrange = Color(0xFFF59E0B);
  static const brandOrangeDark = Color(0xFFB47B00);
  static const gradientTop = Color(0xFF241D66);
  static const gradientBottom = Color(0xFF141040);
}

class LevelData {
  final int number;
  final String status;
  final int stars;

  const LevelData({
    required this.number,
    this.status = 'locked',
    this.stars = 0,
  });

  bool get isLocked => status == 'locked';
  bool get isCompleted => status == 'completed';
}

// --- Level Data ---

const List<LevelData> _levels = [
  LevelData(number: 1, status: 'completed', stars: 2),
  LevelData(number: 2),
  LevelData(number: 3),
  LevelData(number: 4),
  LevelData(number: 5),
  LevelData(number: 6),
  LevelData(number: 7),
  LevelData(number: 8),
  LevelData(number: 9),
  LevelData(number: 10),
];

// --- Main Page ---

class LevelTebakGambar extends StatelessWidget {
  const LevelTebakGambar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 1.0,
            colors: [Color(0xFF1E1A55), _Colors.bgDeep],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const _Header(),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 32,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: _levels.length,
                  itemBuilder: (context, index) {
                    return _LevelCard(level: _levels[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [_Colors.gradientTop, _Colors.gradientBottom],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withAlpha(13)),
                ),
                child: const Icon(
                  Icons.chevron_left,
                  color: Colors.white70,
                  size: 28,
                ),
              ),
            ),
          ),
          const Text(
            'Pilih Level',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}

// --- Level Card ---

class _LevelCard extends StatefulWidget {
  final LevelData level;

  const _LevelCard({required this.level});

  @override
  State<_LevelCard> createState() => _LevelCardState();
}

class _LevelCardState extends State<_LevelCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.92,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (!widget.level.isLocked) {
      _controller.forward();
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (!widget.level.isLocked) {
      _controller.reverse();
      if (widget.level.number == 1) {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const KuisPertanyaan1(),
            transitionDuration: const Duration(milliseconds: 150),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
          ),
        );
      }
    }
  }

  void _onTapCancel() {
    if (!widget.level.isLocked) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: widget.level.isLocked
                  ? _buildLockedCard()
                  : _buildActiveCard(),
            ),
            const SizedBox(height: 12),
            Text(
              'LEVEL ${widget.level.number.toString().padLeft(2, '0')}',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                color: widget.level.isLocked
                    ? Colors.white.withAlpha(51)
                    : _Colors.brandOrange.withAlpha(204),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _Colors.brandOrange,
            _Colors.brandOrange.withAlpha(200),
            _Colors.brandOrangeDark,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(128),
            blurRadius: 10,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: _Colors.brandOrange.withAlpha(51),
            blurRadius: 20,
            spreadRadius: -2,
          ),
        ],
        border: Border.all(color: Colors.white.withAlpha(51), width: 1.5),
      ),
      child: Center(
        child: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withAlpha(51), width: 3),
            color: Colors.white.withAlpha(26),
          ),
          child: const Icon(Icons.image, color: Colors.white, size: 32),
        ),
      ),
    );
  }

  Widget _buildLockedCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [_Colors.gradientTop, _Colors.gradientBottom],
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(38),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.white.withAlpha(13), width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(5),
                border: Border.all(color: Colors.white.withAlpha(13)),
              ),
            ),
            const Center(
              child: Icon(Icons.lock, color: Colors.white12, size: 30),
            ),
          ],
        ),
      ),
    );
  }
}
