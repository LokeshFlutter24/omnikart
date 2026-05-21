import 'package:flutter/material.dart';
import 'package:omnikart/views/Profile/Profile_screen.dart';
import 'package:omnikart/widgets/HomeContent.dart';
import 'package:omnikart/widgets/_CategoryChip.dart';
import 'package:omnikart/widgets/_ProductCard.dart';
import 'package:omnikart/widgets/_TrendCard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _currentIndex = 0;

  final List<Widget> _pages = [
    Homecontant(),
    CategoryChip(icon: Icons.import_contacts, label: 'label'),
    ProductCard(image: 'image', title: 'title', price: 'price'),
    TrendCard(image: 'image', label: 'label'),
    ProfilePage(),
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
              child: InkWell(
                onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
              },child: Icon(Icons.person, size: 16, color: Colors.white),
            ),
            ),
    ]),

      /// BODY
    body: _pages[_currentIndex],

      /// BOTTOM NAV
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(25), // 👈 Border Radius
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25), // 👈 Important
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),

              // Colors
              backgroundColor: Colors.black,
              selectedItemColor: const Color(0xFF2D63EA),
              unselectedItemColor: Colors.white70,

              // Style
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              showUnselectedLabels: true,

              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.grid_view_rounded),
                  label: "Categories",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.local_shipping_rounded),
                  label: "Orders",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart_rounded),
                  label: "Cart",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_rounded),
                  label: "Profile",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
