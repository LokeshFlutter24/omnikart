import 'package:flutter/material.dart';
import 'package:omnikart/views/Profile/Profile_screen.dart';
import 'package:omnikart/widgets/HomeContent.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _currentIndex = 0;

  final List<Widget> _pages = [
    Homecontant(),
    //CategoryScreen(),
    // OrdersScreen(),
    // CartScreen(),
    ProfilePage(),
   // ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true, // 👈 important (bar float karega)

      /// APP BAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white, // ✅ pixel fix
        elevation: 0,
        title: Text(
          "OmniKart",
          style: TextStyle(fontSize: 30,
            fontWeight: FontWeight.w700,
            color: theme.textTheme.titleLarge?.color,
          ),
        ),
        actions: [
          Icon(Icons.search, size: 24, color: isDark ? Colors.white : Colors.black),
            const SizedBox(width: 12),
            Icon(Icons.mic, size: 24, color: isDark ? Colors.white : Colors.black),
            const SizedBox(width: 12),
            Icon(Icons.notifications_none, size: 24, color: isDark ? Colors.white : Colors.black),
            const SizedBox(width: 12),
            CircleAvatar(
              radius: 14,
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, size: 16, color: Colors.white),
            ),
        ],
      ),

      /// BODY
    body: _pages[_currentIndex],

      /// BOTTOM NAV
      bottomNavigationBar: SafeArea(
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap:  (index) => setState(() => _currentIndex = index),
          selectedItemColor: const Color(0xFF2D63EA),
          unselectedItemColor:
          isDark ? Colors.white54 : Colors.black,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.category), label: "Categories"),
            BottomNavigationBarItem(icon: Icon(Icons.local_shipping), label: "Orders"),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
