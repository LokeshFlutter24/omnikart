import 'package:flutter/material.dart';
import 'dart:ui';

class AccountUpdate extends StatefulWidget {
  const AccountUpdate({Key? key}) : super(key: key);

  @override
  State<AccountUpdate> createState() => _AccountUpdateState();
}

class _AccountUpdateState extends State<AccountUpdate> {
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController passwordController;
  bool _obscurePassword = true;
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController(text: 'Alex Rivers');
    emailController = TextEditingController(text: 'alex.rivers@omnikart.com');
    phoneController = TextEditingController(text: '+1 (555) 000-1234');
    addressController = TextEditingController(
      text: '128 Innovation Way, Suite 400\nNew York, NY 10001\nUnited States',
    );
    passwordController = TextEditingController(text: 'password123');

    // Track changes
    fullNameController.addListener(() => setState(() => _hasChanges = true));
    emailController.addListener(() => setState(() => _hasChanges = true));
    phoneController.addListener(() => setState(() => _hasChanges = true));
    addressController.addListener(() => setState(() => _hasChanges = true));
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF8F8),
      body: Stack(
        children: [
          // Main Content
          CustomScrollView(
            slivers: [
              // Glassmorphism Header
              SliverAppBar(
                elevation: 0,
                pinned: true,
                backgroundColor: Colors.transparent,
                flexibleSpace: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                leading: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.black.withOpacity(0.05),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(100),
                      child: const Icon(Icons.arrow_back, color: Color(0xFF1C1B1C)),
                    ),
                  ),
                ),
                title: const Text(
                  'ACCOUNT PROFILE',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.015,
                    color: Color(0xFF1C1B1C),
                  ),
                ),
                centerTitle: true,
                actions: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.black.withOpacity(0.05),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(100),
                        child: const Icon(Icons.tune, color: Color(0xFF1C1B1C)),
                      ),
                    ),
                  ),
                ],
              ),

              // Profile Image Section
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 48),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white,
                        Color(0xFFF6F3F3),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      // Profile Avatar with Gradient Border
                      Stack(
                        children: [
                          Container(
                            width: 144,
                            height: 144,
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFF000000),
                                  Color(0xFF76777B),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 32,
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 4,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                  color: const Color(0xFFF1EDED),
                                  child: Image.network(
                                    'https://lh3.googleusercontent.com/aida-public/AB6AXuC_vZvxMhtrTP2V6xOQXeFp3HtH16DQpWk3EYf4LISiT_IKJYLT1BZ6kO51d5POEtuXRAndBUYi3Qzi6IMYu9DildE-gHK_MGgdMgjmvS4gVXYp1gjLshSGsxbABPrXT1TjL79ph2rkIqoLkFFIxXZK8yjOdcQjDoYDrMpJfOg2bMmqD_KtUJNNdvmv4syrJlwuLe7FtBYYSOgh_e_fNut80AcWlWxAqPNnvO0NJniLUwGgM72LNYAmss2vnMapZ8Gn6pAjidio40hG',
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: const Color(0xFFF1EDED),
                                        child: const Icon(
                                          Icons.person,
                                          size: 64,
                                          color: Colors.grey,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Camera Button
                          Positioned(
                            bottom: 4,
                            right: 4,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF000000),
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 12,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.photo_camera,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Alex Rivers',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.015,
                          color: const Color(0xFF000000),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Senior Logistics Manager',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF46464B),
                          letterSpacing: 0.015,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Form Content
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Basic Information Section
                    _buildSection(
                      title: 'Basic Information',
                      children: [
                        _buildInputField(
                          label: 'ACCOUNT ID',
                          icon: Icons.fingerprint,
                          controller: TextEditingController(text: '#OMN-882194'),
                          enabled: false,
                        ),
                        const SizedBox(height: 20),
                        _buildInputField(
                          label: 'FULL NAME',
                          icon: Icons.person,
                          controller: fullNameController,
                        ),
                        const SizedBox(height: 20),
                        _buildInputField(
                          label: 'EMAIL ADDRESS',
                          icon: Icons.mail,
                          controller: emailController,
                        ),
                        const SizedBox(height: 20),
                        _buildInputField(
                          label: 'PHONE NUMBER',
                          icon: Icons.call,
                          controller: phoneController,
                        ),
                        const SizedBox(height: 20),
                        _buildTextAreaField(
                          label: 'SHIPPING ADDRESS',
                          icon: Icons.location_on,
                          controller: addressController,
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // Security Section
                    _buildSection(
                      title: 'Security',
                      children: [
                        _buildPasswordField(
                          label: 'CURRENT PASSWORD',
                          controller: passwordController,
                        ),
                        const SizedBox(height: 20),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.security_update_good,
                                    size: 18,
                                    color: Color(0xFF000000),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Change security credentials',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF000000),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 100), // Space for sticky footer
                  ]),
                ),
              ),
            ],
          ),

          // Sticky Footer with Save Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    border: Border(
                      top: BorderSide(
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: SafeArea(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _hasChanges
                            ? () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Changes saved successfully!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          setState(() => _hasChanges = false);
                        }
                            : null,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          height: 56,
                          decoration: BoxDecoration(
                            color: _hasChanges
                                ? const Color(0xFF000000)
                                : const Color(0xFF000000).withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: _hasChanges
                                ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 16,
                                spreadRadius: 0,
                              ),
                            ]
                                : [],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'SAVE CHANGES',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  letterSpacing: 0.3,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 6,
              height: 24,
              decoration: BoxDecoration(
                color: const Color(0xFF000000),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              title.toUpperCase(),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2,
                color: Color(0xFF000000),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        ...children,
      ],
    );
  }

  Widget _buildInputField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 6),
          child: Row(
            children: [
              Icon(
                icon,
                size: 14,
                color: const Color(0xFF76777B),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.015,
                  color: Color(0xFF76777B),
                ),
              ),
            ],
          ),
        ),
        TextField(
          controller: controller,
          enabled: enabled,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFE5E2E2),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: const Color(0xFFE5E2E2).withOpacity(0.4),
                width: 1,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: const Color(0xFFE5E2E2).withOpacity(0.2),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF000000),
                width: 1,
              ),
            ),
            fillColor: enabled ? Colors.white : const Color(0xFFF6F3F3),
            filled: true,
          ),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xFF1C1B1C),
          ),
        ),
      ],
    );
  }

  Widget _buildTextAreaField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 6),
          child: Row(
            children: [
              Icon(
                icon,
                size: 14,
                color: const Color(0xFF76777B),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.015,
                  color: Color(0xFF76777B),
                ),
              ),
            ],
          ),
        ),
        TextField(
          controller: controller,
          maxLines: 3,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFE5E2E2),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: const Color(0xFFE5E2E2).withOpacity(0.4),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF000000),
                width: 1,
              ),
            ),
            fillColor: Colors.white,
            filled: true,
          ),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xFF1C1B1C),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 6),
          child: Row(
            children: [
              const Icon(
                Icons.lock,
                size: 14,
                color: Color(0xFF76777B),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.015,
                  color: Color(0xFF76777B),
                ),
              ),
            ],
          ),
        ),
        TextField(
          controller: controller,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFE5E2E2),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: const Color(0xFFE5E2E2).withOpacity(0.4),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF000000),
                width: 1,
              ),
            ),
            fillColor: Colors.white,
            filled: true,
            suffixIcon: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => setState(() => _obscurePassword = !_obscurePassword),
                borderRadius: BorderRadius.circular(8),
                child: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  color: const Color(0xFF76777B),
                  size: 20,
                ),
              ),
            ),
          ),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xFF1C1B1C),
          ),
        ),
      ],
    );
  }
}