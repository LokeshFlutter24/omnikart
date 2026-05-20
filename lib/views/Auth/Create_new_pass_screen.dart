import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isTablet = media.size.width >= 600;

    const primaryBlue = Color(0xFF1D4ED8);
    final bg = isDark ? const Color(0xFF020617) : Colors.white;
    final cardBg = isDark ? const Color(0xFF0F172A) : Colors.white;
    final textPrimary = isDark ? Colors.white : const Color(0xFF111318);
    final textSecondary =
    isDark ? Colors.white70 : const Color(0xFF616F89);
    final inputBg =
    isDark ? const Color(0xFF020617) : const Color(0xFFF0F2F4);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            /// MAIN
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isTablet ? 420 : double.infinity,
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(
                      isTablet ? 32 : 24,
                      24,
                      isTablet ? 32 : 24,
                      MediaQuery.of(context).viewInsets.bottom + 24,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        children: [
                          /// ICON
                          Container(
                            width: 96,
                            height: 96,
                            decoration: BoxDecoration(
                              color: primaryBlue
                                  .withOpacity(isDark ? 0.15 : 0.08),
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                if (!isDark)
                                  BoxShadow(
                                    color:
                                    primaryBlue.withOpacity(0.08),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                              ],
                            ),
                            child: const Icon(
                              Icons.lock_reset,
                              size: 56,
                              color: primaryBlue,
                            ),
                          ),

                          const SizedBox(height: 24),

                          /// TITLE
                          Text(
                            "Create New Password",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: isTablet ? 30 : 28,
                              fontWeight: FontWeight.w800,
                              color: textPrimary,
                              letterSpacing: -0.5,
                            ),
                          ),

                          const SizedBox(height: 8),

                          /// SUBTITLE
                          Text(
                            "Your new password must be different from previously used passwords.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              color: textSecondary,
                            ),
                          ),

                          const SizedBox(height: 28),

                          /// NEW PASSWORD
                          _label("New Password", textPrimary),
                          const SizedBox(height: 8),
                          _passwordField(
                            hint: "Enter new password",
                            icon: Icons.lock_outline,
                            isDark: isDark,
                            inputBg: inputBg,
                            textSecondary: textSecondary,
                            primaryBlue: primaryBlue,
                            obscure: _obscureNew,
                            onToggle: () =>
                                setState(() => _obscureNew = !_obscureNew),
                          ),

                          const SizedBox(height: 18),

                          /// CONFIRM PASSWORD
                          _label("Confirm Password", textPrimary),
                          const SizedBox(height: 8),
                          _passwordField(
                            hint: "Confirm your password",
                            icon: Icons.lock_clock_outlined,
                            isDark: isDark,
                            inputBg: inputBg,
                            textSecondary: textSecondary,
                            primaryBlue: primaryBlue,
                            obscure: _obscureConfirm,
                            onToggle: () => setState(
                                    () => _obscureConfirm = !_obscureConfirm),
                          ),

                          const SizedBox(height: 16),

                          /// PASSWORD STRENGTH
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "Password Strength",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF616F89),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "Strong",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF10B981),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  _strengthBar(
                                      const Color(0xFF10B981)),
                                  _strengthBar(
                                      const Color(0xFF10B981)),
                                  _strengthBar(
                                      const Color(0xFF10B981)),
                                  _strengthBar(const Color(0xFF10B981)
                                      .withOpacity(0.3)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                "Must contain at least 8 characters, one number and one special character.",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF9CA3AF),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          /// BUTTON
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: () {
                                // TODO: reset password logic
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(16),
                                ),
                                elevation: 6,
                                shadowColor:
                                primaryBlue.withOpacity(0.4),
                              ),
                              child: const Text(
                                "Reset Password",
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
              ),
            ),

            /// FOOTER
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: bg,
                border: Border(
                  top: BorderSide(
                    color: isDark
                        ? Colors.white10
                        : const Color(0xFFF1F5F9),
                  ),
                ),
              ),
              child: TextButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back,
                  color: textSecondary,
                ),
                label: Text(
                  "Back to Login",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: textSecondary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ---- Helpers ----

  Widget _label(String text, Color color) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }

  Widget _passwordField({
    required String hint,
    required IconData icon,
    required bool isDark,
    required Color inputBg,
    required Color textSecondary,
    required Color primaryBlue,
    required bool obscure,
    required VoidCallback onToggle,
  }) {
    return TextField(
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: isDark ? Colors.white38 : const Color(0xFF9CA3AF),
        ),
        prefixIcon: Icon(icon, color: textSecondary),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off : Icons.visibility,
            color: textSecondary,
          ),
          onPressed: onToggle,
        ),
        filled: true,
        fillColor: inputBg,
        contentPadding:
        const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: primaryBlue, width: 1.5),
        ),
      ),
    );
  }

  Widget _strengthBar(Color color) {
    return Expanded(
      child: Container(
        height: 6,
        margin: const EdgeInsets.only(right: 6),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }
}
