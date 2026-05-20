import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Notifier_provider/SignUp.dart';

class OmniKartSplash extends StatefulWidget {
  const OmniKartSplash({super.key});

  @override
  State<OmniKartSplash> createState() => _OmniKartSplashState();
}

class _OmniKartSplashState extends State<OmniKartSplash>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    final userProvider = context.read<UserProvider>();

    if (userProvider.isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (userProvider.isFirstTime) {
      Navigator.pushReplacementNamed(context, '/onboarding');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF061A33),
              Color(0xFF0A2C4F),
              Color(0xFF041424),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),

            /// Cart Icon with Glow
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyanAccent.withOpacity(0.4),
                    blurRadius: 30,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(
                Icons.shopping_cart_outlined,
                size: 90,
                color: Colors.white.withOpacity(0.9),
              ),
            ),

            const SizedBox(height: 20),

            /// App Name
            const Text(
              "OmniKart",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),

            const Spacer(),

            /// Loader Ring
            RotationTransition(
              turns: _controller,
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.cyanAccent,
                    width: 3,
                  ),
                ),
                child: const Center(
                  child: CircleAvatar(
                    radius: 6,
                    backgroundColor: Color(0xFF041424),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Tagline
            const Text(
              "EXPERIENCE THE FUTURE OF SHOPPING",
              style: TextStyle(
                fontSize: 12,
                letterSpacing: 3,
                color: Colors.white60,
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
