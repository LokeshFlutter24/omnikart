import 'package:flutter/material.dart';
import 'package:omnikart/Core/Utils/constants/constant.dart';
import 'package:omnikart/views/Profile/Account_Settings/Profile_show.dart';
import 'package:omnikart/views/Profile/Preferences/Notification.dart';
import 'package:omnikart/views/Profile/Profile_screen.dart';
import 'package:omnikart/widgets/HomeContent.dart';
import 'package:omnikart/widgets/_CategoryChip.dart';
import 'package:omnikart/widgets/_ProductCard.dart';
import 'package:omnikart/widgets/_TrendCard.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _currentIndex = 0;
  late stt.SpeechToText speech;
  bool isListening = false;
  String searchText = "";


TextEditingController searchController = TextEditingController();

final FocusNode searchFocusNode = FocusNode();

bool isSearchExpanded = false;


  final List<Widget> _pages = [
    Homecontant(),
    CategoryChip(icon: Icons.import_contacts, label: 'label'),
    ProductCard(image: 'image', title: 'title', price: 'price'),
    TrendCard(image: 'image', label: 'label'),
    ProfilePage(),
  ];

  /// POPUP DIALOG FUNCTION
  void _showMicDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// ANIMATED MIC ICON
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 1.0, end: 1.2),
                  duration: const Duration(milliseconds: 800),
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: child,
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.withOpacity(0.15),
                    ),
                    padding: const EdgeInsets.all(32),
                    child: const Icon(
                      Icons.mic,
                      size: 56,
                      color: Colors.blue,
                    ),
                  ),
                ),

                const SizedBox(height: 24),
                const Text(
                  "Listening...",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),
                Text(
                  "Speak now",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 32),

                /// LOADING INDICATOR
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                ),

                const SizedBox(height: 32),

                /// CANCEL BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      speech.stop();
                      Navigator.pop(context);
                      setState(() => isListening = false);
                    },
                    icon: const Icon(Icons.close),
                    label: const Text("Cancel"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    startListening();
  }

  void startListening() async {
    try {
      bool available = await speech.initialize();

      if (available) {
        setState(() => isListening = true);

        await speech.listen(
          onResult: (result) {
            print("Recognized: ${result.recognizedWords}");

            setState(() {
              searchController.text = result.recognizedWords;
              searchText = result.recognizedWords;
            });

            if (result.finalResult) {
              stopListening(); // ← Custom function
            }
          },
        );
      }
    } catch (e) {
      print("Error: $e");
      stopListening();
    }
  }

  void stopListening() {
    speech.stop();
    if (mounted) {
      Navigator.pop(context);
      setState(() => isListening = false);
    }
  }

  @override
  void initState() {
    super.initState();
    speech = stt.SpeechToText();
    searchFocusNode.addListener(() {
      setState(() {
        isSearchExpanded = searchFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: isDark ? Colors.black: Colors.white,
      extendBody: true, // 👈 important (bar float karega)

      /// APP BAR
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor:
        isDark ? Colors.black : Colors.white,
        elevation: 0,

        title:
         Image.asset(
           filterQuality: FilterQuality.high,
          isDark
              ? AppImage.Omnikartlight
              : AppImage.OmnikartDark,
          height: 120,
          width: 120,
        ),


        actions: [

          /// SEARCH BAR
          Flexible(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),

              width: isSearchExpanded ? 400 : 190,
              height: 42,

              margin: const EdgeInsets.only(
                top: 8,
                bottom: 8,
                left: 8,
                right: 6,
              ),

              decoration: BoxDecoration(
                color: isDark
                    ? Colors.grey.shade900
                    : Colors.grey.shade200,

                borderRadius:
                BorderRadius.circular(30),
              ),

              child: TextField(
                controller: searchController,
                focusNode: searchFocusNode,

                style: TextStyle(
                  color:
                  isDark ? Colors.white : Colors.black,
                ),

                decoration: InputDecoration(

                  hintText: "Search...",

                  border: InputBorder.none,

                  prefixIcon: Icon(
                    Icons.search,
                    color: isDark
                        ? Colors.white
                        : Colors.black,
                  ),

                  /// RIGHT SIDE ICON
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      /// MIC
                      IconButton(
                        onPressed: () {
                          _showMicDialog();
                        },

                        icon: Icon(
                          isListening
                              ? Icons.mic
                              : Icons.mic_none,
                          color: Colors.blue,
                        ),
                      ),

                      /// CLOSE ICON
                      if (isSearchExpanded)
                        IconButton(
                          onPressed: () {

                            /// CLEAR TEXT
                            searchController.clear();

                            /// CLOSE KEYBOARD
                            searchFocusNode.unfocus();

                            /// HIDE SEARCH
                            setState(() {
                              isSearchExpanded = false;
                            });
                          },

                          icon: Icon(
                            Icons.close,
                            color: isDark
                                ? Colors.red
                                : Colors.redAccent,
                          ),
                        ),
                    ],
                  ),

                  contentPadding:
                  const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                ),
              ),
            ),
          ),

          /// HIDE ICONS WHEN SEARCH OPEN
          if (!isSearchExpanded)
            IconButton(
              onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        NotificationCenter())); },
              icon: Icon(
                Icons.notifications_none,
                color: isDark
                    ? Colors.white
                    : Colors.black,
              ),
            ),

          if (!isSearchExpanded)
            Padding(
              padding: const EdgeInsets.only(
                  right: 12, left: 8),
              child: CircleAvatar(
                radius: 14,
                backgroundColor: Colors.blue,
                child: InkWell( onTap: () {
                  Navigator.push( context,
                  MaterialPageRoute( builder:
                  (context) =>
                  ProfileShowScreen(),
                  ),
                  );
                  },
                  child: Icon(
                  Icons.person,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
            ),
        ],
      ),
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
