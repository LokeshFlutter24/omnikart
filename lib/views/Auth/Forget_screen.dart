import 'package:flutter/material.dart';
import 'Create_new_pass_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryBlue = const Color(0xFF1D4ED8);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            /// MAIN CONTENT
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// ICON
                      Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Icon(
                          Icons.security,
                          size: 56,
                          color: primaryBlue,
                        ),
                      ),

                      const SizedBox(height: 24),

                      /// TITLE
                      const Text(
                        "Forgot Password?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF111318),
                          letterSpacing: -0.5,
                        ),
                      ),

                      const SizedBox(height: 8),

                      /// SUBTITLE
                      const Text(
                        "Don't worry, it happens. Please enter the email or phone number associated with your account.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          color: Color(0xFF616F89),
                        ),
                      ),

                      const SizedBox(height: 32),

                      /// INPUT
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "Email or Phone",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF111318),
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      TextField(
                        decoration: InputDecoration(
                          hintText: "Enter your email or phone",
                          hintStyle: const TextStyle(
                            color: Color(0xFF9CA3AF),
                          ),
                          prefixIcon: const Icon(
                            Icons.mail_outline,
                            color: Color(0xFF616F89),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF0F2F4),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: primaryBlue,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      /// BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPasswordScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 6,
                            shadowColor: primaryBlue.withOpacity(0.4),
                          ),
                          child: const Text(
                            "Send Instructions",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// FOOTER
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xFFF1F5F9)),
                ),
              ),
              child: TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Color(0xFF616F89),
                ),
                label: const Text(
                  "Back to Login",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF616F89),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
