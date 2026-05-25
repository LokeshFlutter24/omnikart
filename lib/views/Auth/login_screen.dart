import 'dart:convert';
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:omnikart/views/Auth/signup_screen.dart';
import 'package:omnikart/views/home/HomeScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Core/Utils/constants/constant.dart';
import '../../Notifier_provider/Provider_SignUp.dart';
import 'Forget_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;



  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _animationController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      final provider = context.read<UserProvider>();

      bool success = await provider.loginUser(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (success) {
        /// SAVE LOGIN
        SharedPreferences prefs =
        await SharedPreferences.getInstance();

        await prefs.setBool('isLogin', true);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Login Successful ✅"),
          ),
        );

        Navigator.pushReplacementNamed(context, "/home");

      } else {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              title: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.800),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// TOP ICON
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFFFF3E8),
                        border: Border.all(
                          color: Colors.white,
                          width: 6,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.orange,
                          size: 45,
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    /// TITLE
                    const Text(
                      "Login Failed",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF111827),
                      ),
                    ),

                    const SizedBox(height: 14),

                    /// MESSAGE
                    const Text(
                      "Invalid email or password. Please try again.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        height: 1.5,
                        color: Color(0xFF6B7280),
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// BUTTONS
                    Row(
                      children: [
                        /// OK BUTTON
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 55,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFFF3D00),
                                    Color(0xFFFF7A00),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.orange.withOpacity(0.4),
                                    blurRadius: 12,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  "OK",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // ✅ BACKGROUND IMAGE WITH GRADIENT OVERLAY
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4),
                  BlendMode.difference,
                ),
                image: AssetImage(
                  'assets/images/loginimage.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.6),
                  ],
                ),
              ),
            ),
          ),
          // ✅ MAIN CONTENT
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 200),

                  // ✅ HEADER SECTION
                  FadeTransition(
                    opacity: _animationController,
                    child: Column(
                      children: [
                        Text(
                          "OmniKart",
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "Welcome back!",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white.withOpacity(0.9),
                            shadows: [
                              Shadow(
                                blurRadius: 5,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ],
                          ),
                        ),
                      ],/////
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ✅ LOGIN CARD WITH BLUR EFFECT
                  SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _animationController,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.500),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.5),  // Border add kiya
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 30,
                              offset: const Offset(0, 20),
                            ),
                            BoxShadow(
                              color: const Color(0xFF2D63EA).withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ✅ EMAIL FIELD
                              _label("Email Address", true),
                              _inputField(
                                controller: _emailController,
                                hint: "you@example.com",
                                icon: Icons.email_outlined,
                                isDark: false,
                                validator: (v) {
                                  if (v == null || v.isEmpty) {
                                    return "Enter email address";
                                  }
                                  if (!v.contains("@")) {
                                    return "Enter valid email";
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 22),

                              // ✅ PASSWORD FIELD
                              _label("Password", true),
                              _inputField(
                                controller: _passwordController,
                                hint: "••••••••",
                                icon: _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                obscure: _obscurePassword,
                                isDark: false,
                                validator: (v) {
                                  if (v == null || v.isEmpty) {
                                    return "Enter password";
                                  }
                                  if (v.length < 6) {
                                    return "Password must be 6+ characters";
                                  }
                                  return null;
                                },
                                onIconTap: () {
                                  setState(
                                          () => _obscurePassword = !_obscurePassword);
                                },
                              ),

                              // ✅ FORGOT PASSWORD
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ForgotPasswordScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                      color: Color(0xFF2D63EA),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 16),

                              // ✅ LOGIN BUTTON WITH GRADIENT
                              SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: Consumer<UserProvider>(
                                  builder: (context, provider, child) {
                                    return provider.isLoading
                                        ? Center(
                                      child: SizedBox(
                                        width: 24,
                                        height: 24,
                                        child:
                                        CircularProgressIndicator(
                                          strokeWidth: 2.5,
                                          valueColor:
                                          const AlwaysStoppedAnimation<
                                              Color>(
                                            Color(0xFF2D63EA),
                                          ),
                                        ),
                                      ),
                                    )
                                        : Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(28),
                                        gradient: const LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Color(0xFF2D63EA),
                                            Color(0xFF1F45B0),
                                          ],
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFF2D63EA)
                                                .withOpacity(0.4),
                                            blurRadius: 15,
                                            offset: const Offset(0, 8),
                                          ),
                                        ],
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: _handleLogin,
                                          borderRadius:
                                          BorderRadius.circular(28),
                                          child: const Center(
                                            child: Text(
                                              'Log In',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight:
                                                FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ✅ DIVIDER WITH TEXT
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.white.withOpacity(0.3),
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            "OR CONTINUE WITH",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withOpacity(0.8),
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.white.withOpacity(0.3),
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ✅ SOCIAL LOGIN BUTTONS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _socialButton(
                        onTap: () {},
                        label: "",
                        image: "assets/images/google.png"),

                      const SizedBox(width: 16),
                      _socialButton(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Apple Sign-In coming soon"),
                              backgroundColor: Colors.black87,
                            ),
                          );
                        },
                        label: "",
                        image:"assets/images/apple.png"),
                      ],
                  ),

                  const SizedBox(height: 28),

                  // ✅ SIGN UP LINK
                  RichText(
                    text: TextSpan(
                      text: "New User? ",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 15,
                      ),
                      children: [
                        TextSpan(
                          text: "Create Account",
                          style: const TextStyle(
                            color: Color(0xFFFF9500),
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const SignUpScreen(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /* ================= HELPER WIDGETS ================= */

  Widget _label(String text, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
    bool isDark = false,
    String? Function(String?)? validator,
    VoidCallback? onIconTap,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.black.withOpacity(0.4),
          fontWeight: FontWeight.bold,
        ),
        /// CLICKABLE ICON
        suffixIcon: IconButton(
          onPressed: onIconTap,
          icon: Icon(
            icon,
            color: Color(0xFF2D63EA),
          ),
        ),
        suffixIconConstraints: const BoxConstraints(minWidth: 50),
        filled: true,
        fillColor: Colors.white.withOpacity(0.7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.1),
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.08),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFF2D63EA),
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.5,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      ),
    );
  }

  Widget _socialButton({
    required VoidCallback onTap,
    required String label,
    required String image,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        width: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white.withOpacity(0.8000),
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
                image,
              height: 30,
              width: 30,
         // color: color,
          fit: BoxFit.contain),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}