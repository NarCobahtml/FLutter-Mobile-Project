import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final int correct;
  final int wrong;
  final String username;

  const ResultPage({
    super.key,
    this.correct = 7,
    this.wrong = 3,
    this.username = "User",
  });

  int get total => correct + wrong;
  int get percent => total == 0 ? 0 : ((correct / total) * 100).round();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0B0B2A), Color(0xFF0A0F3D)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // App Bar
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: Colors.white),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          "Hasil Kuis",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),

                const SizedBox(height: 20),

                //Icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(
                      Icons.celebration,
                      color: Colors.orange,
                      size: 28,
                    ), // 🎉 placeholder
                    Icon(
                      Icons.emoji_events,
                      color: Colors.orange,
                      size: 28,
                    ), // 🏆 placeholder
                  ],
                ),

                const SizedBox(height: 10),

                // Score Circle
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Ring luar
                    Container(
                      width: 190,
                      height: 190,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.orange.withOpacity(0.25),
                      ),
                    ),

                    // Lingkaran utama
                    Container(
                      width: 150,
                      height: 150,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.orange,
                      ),
                      child: Center(
                        child: Text(
                          "$percent%",
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Text(
                  "Selamat $username!",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                // Benar
                resultCard(
                  icon: Icons.check_circle,
                  iconColor: Colors.green,
                  text: "Jawaban Benar",
                  value: correct.toString(),
                ),

                const SizedBox(height: 12),

                //Salah
                resultCard(
                  icon: Icons.cancel,
                  iconColor: Colors.red,
                  text: "Jawaban Salah",
                  value: wrong.toString(),
                ),

                const Spacer(),

                // Button tinjau
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Tinjau Jawaban",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Button ulang
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.orange),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      //
                    },
                    child: const Text(
                      "Main Ulang",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Back
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Balik ke Mode",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Component Result Card
  static Widget resultCard({
    required IconData icon,
    required Color iconColor,
    required String text,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(color: Colors.white)),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
