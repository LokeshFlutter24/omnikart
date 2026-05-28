import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:omnikart/views/Auth/login_screen.dart';
import 'package:omnikart/views/Profile/Preferences/Notification.dart';
import 'package:omnikart/views/Profile/Support/Help_Center.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../Notifier_provider/Provider_profile.dart';
import '../../Notifier_provider/Theme_provider.dart';
import '../../connectivity_service/connectivity_service.dart';
import 'Account_Settings/Profile_show.dart';
import 'Support/About_omnikart.dart';
import 'Support/Privacy_policy.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedNavIndex = 4;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProfileProvider>(context, listen: false).fetchUsers();
    });
  }

  // ❌ No Internet Widget
  Widget _noInternetWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wifi_off, size: 80, color: Colors.red.shade400),
          const SizedBox(height: 20),
          const Text(
            "No Internet Connection",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            "Please check your internet connection",
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            ),
            onPressed: () {
              Provider.of<ProfileProvider>(context, listen: false).fetchUsers();
            },
            icon: const Icon(Icons.refresh, color: Colors.white),
            label: const Text(
              "Retry",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // ❌ Error Widget
  Widget _errorWidget(String errorMessage, ProfileProvider provider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 80, color: Colors.red.shade400),
          const SizedBox(height: 20),
          const Text(
            "Error",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            ),
            onPressed: () => provider.fetchUsers(),
            icon: const Icon(Icons.refresh, color: Colors.white),
            label: const Text(
              "Retry",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // 📭 No Data Widget
  Widget _noDataWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/Animations/Progess_indicater.json',
            width: 300,
            height: 300,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ✅ GET DARK MODE FROM PROVIDER
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,  // ✅ UPDATE
      body: Consumer2<ProfileProvider, ConnectivityService>(
        builder: (context, provider, connectivityService, child) {
          // ❌ No Internet
          if (!connectivityService.isConnected) {
            return _noInternetWidget();
          }

          // ❌ Error State
          if (provider.errorMessage.isNotEmpty) {
            return _errorWidget(provider.errorMessage, provider);
          }

          // 📭 No Data
          if (provider.users.isEmpty) {
            return _noDataWidget();
          }

          // ⏳ Loading + ✅ Success
          final user = provider.users.isNotEmpty ? provider.users.first : null;

          return Skeletonizer(
            enabled: provider.isLoading,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 32,
                  horizontal: 16,
                ),
                child: Column(
                  children: [
                    // Profile Section
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isDark ? Colors.grey[800]! : Colors.white,  // ✅ UPDATE
                              width: 4,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 70,
                            backgroundImage: provider.users.isNotEmpty &&
                                provider.users.first.profileImage != null
                                ? NetworkImage(
                              "https://verifyrealestateandservices.in/Second%20PHP%20FILE/e-commerce/${provider.users.first.profileImage}",
                            )
                                : null,
                            child: provider.users.isEmpty
                                ? const Icon(Icons.person, size: 60)
                                : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      provider.users.isNotEmpty
                          ? provider.users.first.name
                          : "Loading Name",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      provider.users.isNotEmpty
                          ? provider.users.first.email
                          : "loading@email.com",
                      style: TextStyle(
                        color: isDark ? Colors.grey[400] : Colors.grey[600],  // ✅ UPDATE
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Order Summary Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'My Orders',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                _OrderStatusCard(
                                  icon: Icons.local_shipping,
                                  label: 'Delivered',
                                ),
                                const SizedBox(width: 16),
                                _OrderStatusCard(
                                  icon: Icons.local_shipping,
                                  label: 'Shipped',
                                ),
                                const SizedBox(width: 16),
                                _OrderStatusCard(
                                  icon: Icons.sync,
                                  label: 'Processing',
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),

                    // Account Settings
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Account Settings',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,  // ✅ UPDATE
                              border: Border.all(
                                color: isDark ? Colors.grey[700]! : Colors.grey[300]!,  // ✅ UPDATE
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                _SettingsMenuItem(
                                  icon: Icons.location_on,
                                  title: 'Saved Addresses',
                                  onTap: () {},
                                ),
                                Divider(
                                  height: 1,
                                  color: isDark ? Colors.grey[700] : Colors.grey[300],  // ✅ UPDATE
                                ),
                                _SettingsMenuItem(
                                  icon: Icons.payment,
                                  title: 'Payment Methods',
                                  onTap: () {},
                                ),
                                Divider(
                                  height: 1,
                                  color: isDark ? Colors.grey[700] : Colors.grey[300],  // ✅ UPDATE
                                ),
                                _SettingsMenuItem(
                                  icon: Icons.dashboard,
                                  title: 'Dropshipping Dashboard',
                                  onTap: () {},
                                ),
                                Divider(
                                  height: 1,
                                  color: isDark ? Colors.grey[700] : Colors.grey[300],  // ✅ UPDATE
                                ),
                                _SettingsMenuItem(
                                  icon: Icons.security,
                                  title: 'Security & Password',
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),

                    // Preferences
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Preferences',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,  // ✅ UPDATE
                              border: Border.all(
                                color: isDark ? Colors.grey[700]! : Colors.grey[300]!,  // ✅ UPDATE
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                _SettingsMenuItem(
                                  icon: Icons.notifications,
                                  title: 'Notifications',
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NotificationCenter(),
                                      ),
                                    );
                                  },
                                ),
                                Divider(
                                  height: 1,
                                  color: isDark ? Colors.grey[700] : Colors.grey[300],  // ✅ UPDATE
                                ),

                                // Language Setting
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: isDark ? Colors.grey[800] : Colors.grey[200],  // ✅ UPDATE
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Icon(
                                          Icons.language,
                                          size: 20,
                                          color: isDark ? Colors.grey[300] : Colors.grey[700],  // ✅ UPDATE
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      const Expanded(
                                        child: Text(
                                          'Language',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'English',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: isDark ? Colors.grey[400] : Colors.grey[600],  // ✅ UPDATE
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Icon(
                                        Icons.chevron_right,
                                        color: isDark ? Colors.grey[600] : Colors.grey,  // ✅ UPDATE
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                  color: isDark ? Colors.grey[700] : Colors.grey[300],  // ✅ UPDATE
                                ),

                                // Dark Mode Toggle ✅ UPDATE THIS
                                Consumer<ThemeProvider>(
                                  builder: (context, themeProvider, _) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 16,
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: isDark
                                                  ? Colors.grey[800]
                                                  : Colors.grey[200],
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            child: Icon(
                                              Icons.dark_mode,
                                              size: 20,
                                              color: isDark
                                                  ? Colors.grey[300]
                                                  : Colors.grey[700],
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          const Expanded(
                                            child: Text(
                                              'Dark Mode',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Switch(
                                            value: themeProvider.isDarkMode,
                                            onChanged: (value) {
                                              themeProvider?.setTheme(value);
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),

                    // Support
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Support',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,  // ✅ UPDATE
                              border: Border.all(
                                color: isDark ? Colors.grey[700]! : Colors.grey[300]!,  // ✅ UPDATE
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                _SupportMenuItem(
                                  title: 'Help Center',
                                  icon: Icons.help_outline,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                        const HelpCenter(),
                                      ),
                                    );
                                  },
                                ),
                                Divider(
                                  height: 1,
                                  color: isDark ? Colors.grey[700] : Colors.grey[300],  // ✅ UPDATE
                                ),
                                _SupportMenuItem(
                                  title: 'About OmniKart',
                                  icon: Icons.info,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                        const AboutOmnikart(),
                                      ),
                                    );
                                  },
                                ),
                                Divider(
                                  height: 1,
                                  color: isDark ? Colors.grey[700] : Colors.grey[300],  // ✅ UPDATE
                                ),
                                _SupportMenuItem(
                                  title: 'Privacy Policy',
                                  icon: Icons.policy,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                        const PrivacyPolicy(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),

                    // Logout Button
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 32,
                      ),
                      child: SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isDark ? Colors.grey[900] : Colors.black,  // ✅ UPDATE
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  content: Container(
                                    padding: const EdgeInsets.all(24),
                                    decoration: BoxDecoration(
                                      color: isDark
                                          ? Color(0xFF1E293B).withOpacity(0.95)
                                          : Colors.white.withOpacity(0.95),
                                      borderRadius:
                                      BorderRadius.circular(28),
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
                                        Container(
                                          height: 90,
                                          width: 90,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.red.shade50,
                                            border: Border.all(
                                              color: isDark
                                                  ? Color(0xFF1E293B)
                                                  : Colors.white,
                                              width: 6,
                                            ),
                                          ),
                                          child: const Center(
                                            child: Icon(
                                              Icons.logout_rounded,
                                              color: Colors.red,
                                              size: 45,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 22),
                                        const Text(
                                          "Logout",
                                          style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF111827),
                                          ),
                                        ),
                                        const SizedBox(height: 14),
                                        const Text(
                                          "Are you sure you want to logout from your account?",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 17,
                                            height: 1.5,
                                            color: Color(0xFF6B7280),
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  height: 55,
                                                  decoration: BoxDecoration(
                                                    color: isDark
                                                        ? Colors.grey[800]
                                                        : Colors.grey.shade200,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        18),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "No",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        color: isDark
                                                            ? Colors.white
                                                            : Colors.black87,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 14),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () async {
                                                  SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                                  await prefs.clear();
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (_) =>
                                                      const LoginScreen(),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  height: 55,
                                                  decoration: BoxDecoration(
                                                    gradient:
                                                    const LinearGradient(
                                                      colors: [
                                                        Color(0xFFFF3D00),
                                                        Color(0xFFFF7A00),
                                                      ],
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        18),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.orange
                                                            .withOpacity(0.4),
                                                        blurRadius: 12,
                                                        offset:
                                                        const Offset(0, 6),
                                                      ),
                                                    ],
                                                  ),
                                                  child: const Center(
                                                    child: Text(
                                                      "Yes",
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
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.logout),
                              SizedBox(width: 8),
                              Text(
                                'Log Out',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedNavIndex,
        onTap: (index) {
          setState(() {
            _selectedNavIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// ✅ UPDATE _OrderStatusCard
class _OrderStatusCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const _OrderStatusCard({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 128,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(
          color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isDark ? Colors.blue[900] : Colors.blue[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isDark ? Colors.blue[300] : Colors.blue[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.grey[300] : Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ✅ UPDATE _SettingsMenuItem
class _SettingsMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _SettingsMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[800] : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: isDark ? Colors.grey[300] : Colors.grey[600],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: isDark ? Colors.grey[600] : Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ✅ UPDATE _SupportMenuItem
class _SupportMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _SupportMenuItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(
                icon,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ],
          ),
        ),
      ),
    );
  }
}