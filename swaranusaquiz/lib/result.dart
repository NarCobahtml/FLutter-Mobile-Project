import 'package:flutter/material.dart';

class QuizResultScreen extends StatelessWidget {
  final int correctAnswers;
  final int wrongAnswers;
  final int totalQuestions;

  const QuizResultScreen({
    Key? key,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.totalQuestions,
  }) : super(key: key);

  double get scorePercentage {
    // guard: pastikan tidak membagi dengan 0 atau nilai negatif
    if (totalQuestions <= 0) return 0.0;
    return (correctAnswers / totalQuestions) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF110E33),
      body: SafeArea(
        child: Stack(
          children: [
            // Decorative Emojis

            // Main Content
            Column(
              children: [
                // Header
                _buildHeader(context),

                const SizedBox(height: 10),

                // Score Circle
                _buildScoreCircle(),

                const SizedBox(height: 25),

                // Congratulation Text
                const Text(
                  'Selamat User!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),

                const SizedBox(height: 90),

                // Result Cards
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      _buildResultCard(
                        icon: Icons.check_circle,
                        iconColor: const Color(0xFF4CAF50),
                        label: 'Jawaban Benar',
                        value: correctAnswers.toString(),
                      ),
                      const SizedBox(height: 16),
                      _buildResultCard(
                        icon: Icons.cancel,
                        iconColor: const Color(0xFFF44336),
                        label: 'Jawaban Salah',
                        value: wrongAnswers.toString(),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Action Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      _buildPrimaryButton(
                        context,
                        label: 'Tinjau Jawaban',
                        onPressed: () {
                          // Handle review answers
                        },
                      ),
                      const SizedBox(height: 12),
                      _buildOutlineButton(
                        context,
                        label: 'Main Ulang',
                        onPressed: () {
                          // Handle play again
                        },
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          // Handle back to mode
                        },
                        child: const Text(
                          'Balik ke Mode',
                          style: TextStyle(
                            color: Color(0xFFB8B8D4),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, color: Colors.white, size: 28),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 28),
                child: Text(
                  'Hasil Kuis',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreCircle() {
    return Container(
      width: 280,
      height: 180,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xff3f2b2b),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFFFB020),
        ),
        child: Center(
          child: Builder(
            builder: (context) {
              final pct = scorePercentage.isFinite
                  ? scorePercentage.toInt()
                  : 0;
              return Text(
                '$pct%',
                style: const TextStyle(
                  color: Color(0xFF1A1A3E),
                  fontSize: 56,
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildResultCard({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A4E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryButton(
    BuildContext context, {
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFB020),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          shadowColor: Colors.transparent,
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildOutlineButton(
    BuildContext context, {
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFFFFB020),
          side: const BorderSide(color: Color(0xFFFFB020), width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
