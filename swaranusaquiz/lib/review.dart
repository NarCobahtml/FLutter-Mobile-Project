import 'package:flutter/material.dart';

class ReviewAnswersScreen extends StatelessWidget {
  final List<QuizAnswer> answers;
  final VoidCallback? onBackToHome;

  const ReviewAnswersScreen({
    Key? key,
    required this.answers,
    this.onBackToHome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF110E33),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 12),

                    // Soal 1
                    _buildAnswerCard(
                      questionNumber: 1,
                      imagePath: answers.isNotEmpty
                          ? answers[0].imagePath
                          : null,
                      userAnswer: answers.isNotEmpty
                          ? answers[0].userAnswer
                          : '',
                      correctAnswer: answers.isNotEmpty
                          ? answers[0].correctAnswer
                          : '',
                      isCorrect: answers.isNotEmpty
                          ? answers[0].isCorrect
                          : true,
                    ),

                    const SizedBox(height: 16),

                    // Soal 2
                    _buildAnswerCard(
                      questionNumber: 2,
                      imagePath: answers.length > 1
                          ? answers[1].imagePath
                          : null,
                      userAnswer: answers.length > 1
                          ? answers[1].userAnswer
                          : '',
                      correctAnswer: answers.length > 1
                          ? answers[1].correctAnswer
                          : '',
                      isCorrect: answers.length > 1
                          ? answers[1].isCorrect
                          : true,
                    ),

                    const SizedBox(height: 16),

                    // Soal 3
                    _buildAnswerCard(
                      questionNumber: 3,
                      imagePath: answers.length > 2
                          ? answers[2].imagePath
                          : null,
                      userAnswer: answers.length > 2
                          ? answers[2].userAnswer
                          : '',
                      correctAnswer: answers.length > 2
                          ? answers[2].correctAnswer
                          : '',
                      isCorrect: answers.length > 2
                          ? answers[2].isCorrect
                          : true,
                    ),

                    const SizedBox(height: 16),

                    // Soal 4
                    if (answers.length > 3)
                      _buildAnswerCard(
                        questionNumber: 4,
                        imagePath: answers[3].imagePath,
                        userAnswer: answers[3].userAnswer,
                        correctAnswer: answers[3].correctAnswer,
                        isCorrect: answers[3].isCorrect,
                      ),

                    if (answers.length > 3) const SizedBox(height: 16),

                    // Soal 5
                    if (answers.length > 4)
                      _buildAnswerCard(
                        questionNumber: 5,
                        imagePath: answers[4].imagePath,
                        userAnswer: answers[4].userAnswer,
                        correctAnswer: answers[4].correctAnswer,
                        isCorrect: answers[4].isCorrect,
                      ),

                    if (answers.length > 4) const SizedBox(height: 16),

                    // Soal 6
                    if (answers.length > 5)
                      _buildAnswerCard(
                        questionNumber: 6,
                        imagePath: answers[5].imagePath,
                        userAnswer: answers[5].userAnswer,
                        correctAnswer: answers[5].correctAnswer,
                        isCorrect: answers[5].isCorrect,
                      ),

                    if (answers.length > 5) const SizedBox(height: 16),

                    // Soal 7
                    if (answers.length > 6)
                      _buildAnswerCard(
                        questionNumber: 7,
                        imagePath: answers[6].imagePath,
                        userAnswer: answers[6].userAnswer,
                        correctAnswer: answers[6].correctAnswer,
                        isCorrect: answers[6].isCorrect,
                      ),

                    if (answers.length > 6) const SizedBox(height: 16),

                    // Soal 8
                    if (answers.length > 7)
                      _buildAnswerCard(
                        questionNumber: 8,
                        imagePath: answers[7].imagePath,
                        userAnswer: answers[7].userAnswer,
                        correctAnswer: answers[7].correctAnswer,
                        isCorrect: answers[7].isCorrect,
                      ),

                    if (answers.length > 7) const SizedBox(height: 16),

                    // Soal 9
                    if (answers.length > 8)
                      _buildAnswerCard(
                        questionNumber: 9,
                        imagePath: answers[8].imagePath,
                        userAnswer: answers[8].userAnswer,
                        correctAnswer: answers[8].correctAnswer,
                        isCorrect: answers[8].isCorrect,
                      ),

                    if (answers.length > 8) const SizedBox(height: 16),

                    // Soal 10
                    if (answers.length > 9)
                      _buildAnswerCard(
                        questionNumber: 10,
                        imagePath: answers[9].imagePath,
                        userAnswer: answers[9].userAnswer,
                        correctAnswer: answers[9].correctAnswer,
                        isCorrect: answers[9].isCorrect,
                      ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
            onPressed: () => Navigator.of(context).pop(),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 8),
          const Text(
            'Tinjau Jawaban',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerCard({
    required int questionNumber,
    required String? imagePath,
    required String userAnswer,
    required String correctAnswer,
    required bool isCorrect,
  }) {
    return Container(
      width: 310,
      decoration: BoxDecoration(
        color: isCorrect ? const Color(0xff332839) : const Color(0xff331f3f),

        borderRadius: BorderRadius.circular(16),
      ),

      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Soal $questionNumber',
                  style: const TextStyle(
                    color: Color(0xFF9999aa),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 12),

                // Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: imagePath != null
                      ? Image.asset(
                          imagePath,
                          width: 130,
                          height: 90,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 150,
                              height: 125,
                              decoration: BoxDecoration(
                                color: const Color(0xFF110E33),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.image,
                                color: Color(0xFF9999aa),
                              ),
                            );
                          },
                        )
                      : Container(
                          width: 130,
                          height: 90,
                          decoration: BoxDecoration(
                            color: const Color(0xFF110E33),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.image,
                            color: Color(0xFF9999aa),
                          ),
                        ),
                ),

                const SizedBox(height: 12),

                // User Answer
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: questionNumber <= 6
                            ? 'Jawabanmu: '
                            : 'Your answer: ',
                        style: const TextStyle(
                          color: Color(0xFF9999aa),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: userAnswer,
                        style: TextStyle(
                          color: isCorrect
                              ? const Color(0xFFffaa44)
                              : const Color(0xFFff6666),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                // Correct Answer (if wrong)
                if (!isCorrect) ...[
                  const SizedBox(height: 4),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: questionNumber <= 6
                              ? 'Jawaban Benar: '
                              : 'Correct answer: ',
                          style: const TextStyle(
                            color: Color(0xFF9999aa),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: correctAnswer,
                          style: const TextStyle(
                            color: Color(0xFFffaa44),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Status Icon (Top Right)
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: isCorrect
                    ? const Color(0xFFffaa44)
                    : const Color(0xFFff4444),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isCorrect ? Icons.check : Icons.close,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuizAnswer {
  final int questionNumber;
  final String userAnswer;
  final String correctAnswer;
  final bool isCorrect;
  final String? imagePath;

  const QuizAnswer({
    required this.questionNumber,
    required this.userAnswer,
    required this.correctAnswer,
    this.imagePath,
  }) : isCorrect = userAnswer == correctAnswer;
}

class ReviewAnswersData {
  static List<QuizAnswer> getSampleData() {
    return const [
      QuizAnswer(
        questionNumber: 1,
        userAnswer: 'Tifa',
        correctAnswer: 'Tifa',
        imagePath: 'assets/image/Gambar Tifa.png',
      ),
      QuizAnswer(
        questionNumber: 2,
        userAnswer: 'Sasando',
        correctAnswer: 'Gamelan',
        imagePath: 'assets/image/Gambar Gamelan.png',
      ),
      QuizAnswer(
        questionNumber: 3,
        userAnswer: 'Kolintang',
        correctAnswer: 'Kolintang',
        imagePath: 'assets/image/Gambar Kolintang.png',
      ),
      QuizAnswer(
        questionNumber: 4,
        userAnswer: 'Gambus',
        correctAnswer: 'Gambus',
        imagePath: 'assets/image/Gambar Gambus.png',
      ),
      QuizAnswer(
        questionNumber: 5,
        userAnswer: 'Sape',
        correctAnswer: 'Sasando',
        imagePath: 'assets/image/Gambar Sape.png',
      ),
      QuizAnswer(
        questionNumber: 6,
        userAnswer: 'Gamelan',
        correctAnswer: 'Rebab',
        imagePath: 'assets/image/Gambar Rebab.png',
      ),
      QuizAnswer(
        questionNumber: 7,
        userAnswer: 'Angklung',
        correctAnswer: 'Angklung',
        imagePath: 'assets/image/Gambar Angklung.png',
      ),
      QuizAnswer(
        questionNumber: 8,
        userAnswer: 'Gendang',
        correctAnswer: 'Gendang',
        imagePath: 'assets/image/Gambar Gendang.png',
      ),
      QuizAnswer(
        questionNumber: 9,
        userAnswer: 'Sape',
        correctAnswer: 'Sape',
        imagePath: 'assets/image/Gambar Sape.png',
      ),
      QuizAnswer(
        questionNumber: 10,
        userAnswer: 'Kecapi',
        correctAnswer: 'Kecapi',
        imagePath: 'assets/image/Gambar Kecapi.png',
      ),
    ];
  }
}
