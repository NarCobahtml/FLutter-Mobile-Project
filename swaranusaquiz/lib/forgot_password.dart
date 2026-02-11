import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // 0 = Email Input, 1 = OTP Input
  int _currentStep = 0;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  static const Color primaryOrange = Color(0xFFF59E0B);
  static const Color inputFill = Color(0xff282647);

  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _goToOtp() {
    if (_emailController.text.isNotEmpty) {
      setState(() {
        _currentStep = 1;
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Harap masukkan email')));
    }
  }

  void _verifyOtp() {
    // In a real app, verify OTP here
    if (_otpController.text.length >= 4) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('OTP Terverifikasi!')));
      // Navigate to Reset Password or Back to Login
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Masukkan kode OTP valid')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF110E33),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (_currentStep == 1) {
              setState(() {
                _currentStep = 0;
              });
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Illustration/Icon placeholder
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  margin: const EdgeInsets.only(bottom: 30),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF110E33),
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    _currentStep == 0
                        ? 'assets/icon/email_icon.svg' // Placeholder
                        : 'assets/icon/otp_icon.svg',

                    placeholderBuilder: (context) => Icon(
                      _currentStep == 0
                          ? Icons.email_outlined
                          : Icons.lock_clock_outlined,
                      color: primaryOrange,
                      size: 50,
                    ),
                  ),
                ),
              ),

              // Title & Description
              Text(
                _currentStep == 0 ? 'Lupa Password?' : 'Verifikasi OTP',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                _currentStep == 0
                    ? 'Jangan khawatir! Masukkan email yang terdaftar akun anda.'
                    : 'Kami telah mengirimkan kode verifikasi ke email\n${_emailController.text}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.7),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),

              // Input Field
              if (_currentStep == 0)
                _buildInputField(
                  controller: _emailController,
                  hint: 'Masukkan Email',
                  icon: Icons.email_outlined,
                )
              else
                _buildInputField(
                  controller: _otpController,
                  hint: 'Masukkan Kode OTP',
                  icon: Icons.lock_outline,
                  isOtp: true,
                ),

              const SizedBox(height: 40),

              // Action Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _currentStep == 0 ? _goToOtp : _verifyOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    _currentStep == 0 ? 'Kirim Kode' : 'Verifikasi',
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              if (_currentStep == 1) ...[
                const SizedBox(height: 24),
                Center(
                  child: TextButton(
                    onPressed: () {
                      // Resend logic
                    },
                    child: RichText(
                      text: const TextSpan(
                        text: 'Belum terima kode? ',
                        style: TextStyle(color: Colors.white60),
                        children: [
                          TextSpan(
                            text: 'Kirim Ulang',
                            style: TextStyle(
                              color: primaryOrange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isOtp = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: inputFill,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
      ),
      child: TextField(
        controller: controller,
        keyboardType: isOtp ? TextInputType.number : TextInputType.emailAddress,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          letterSpacing: isOtp ? 2.0 : 0.0,
        ),
        textAlign: isOtp ? TextAlign.center : TextAlign.start,
        decoration: InputDecoration(
          prefixIcon: isOtp ? null : Icon(icon, color: Colors.white54),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white38),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
        ),
      ),
    );
  }
}
