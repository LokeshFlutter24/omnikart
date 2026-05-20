import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:omnikart/widgets/HomeContent.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import '../../Notifier_provider/SignUp.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();

  bool _obscurePassword = true;
  bool _agreeToTerms = false;
  File? profile_image;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      var status = await Permission.photos.request();

      if (status.isGranted) {
        final pickedFile = await _imagePicker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 90,
        );

        if (pickedFile != null) {
          setState(() {
            profile_image = File(pickedFile.path);
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Permission denied")),
        );
      }
    } catch (e) {
      print(e);
    }
  }


  void _handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      if (!_agreeToTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You must agree to the terms')),
        );
        return;
      }
      // ✅ Optional: Warn if no image selected
      if (profile_image == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a profile photo')),
        );
        return;
      }

      final provider = context.read<UserProvider>();

      bool success = await provider.registerUser(
        name: _fullNameController.text,
        number: _phoneController.text,
        email: _emailController.text,
        address: _addressController.text,
        password: _passwordController.text,
        profile_image: profile_image?.path ?? '',
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Signup Successful ✅")),
        );

        // 👉 navigate to login
        Navigator.pushReplacementNamed(context, "/login");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Signup Failed ❌")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F7FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.shopping_cart,
                      color: Color(0xFF1A73E8),
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Title and Subtitle
                  const Text(
                    'OmniKart',
                    style: TextStyle(
                      color: Color(0xFF111318),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Get Started',
                    style: TextStyle(
                      color: Color(0xFF111318),
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Create your account to start shopping trends.',
                    style: TextStyle(
                      color: Color(0xFF616f89),
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            // Form Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Profile Photo Section
                    Padding(
                      padding: const EdgeInsets.only(bottom: 32),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: _pickImage,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 96,
                                  height: 96,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF8FAFC),
                                    borderRadius: BorderRadius.circular(48),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                      width: 2,
                                      strokeAlign: BorderSide.strokeAlignOutside,
                                    ),
                                  ),
                                  child: profile_image == null
                                      ? const Icon(
                                    Icons.person,
                                    size: 44,
                                    color: Color(0xFF9CA3AF),
                                  )
                                      : ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(48),
                                    child: Image.file(
                                      profile_image!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1A73E8),
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF1A73E8)
                                              .withOpacity(0.3),
                                          blurRadius: 8,
                                        ),
                                      ],
                                      border:
                                      Border.all(color: Colors.white, width: 3),
                                    ),
                                    child: const Icon(
                                      Icons.camera_alt,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'ADD PROFILE PHOTO',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF616f89),
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Full Name Field
                    _buildFormField(
                      label: 'Full Name',
                      icon: Icons.person,
                      controller: _fullNameController,
                      placeholder: 'John Doe',
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Full name is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    // Email Field
                    _buildFormField(
                      label: 'Email Address',
                      icon: Icons.mail,
                      controller: _emailController,
                      placeholder: 'john@example.com',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Email is required';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value!)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    // Phone Field
                    _buildFormField(
                      label: 'Phone Number',
                      icon: Icons.phone_iphone,
                      controller: _phoneController,
                      placeholder: '**********',
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Phone number is required';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    _buildFormField(
                      label: 'Address',
                      icon: Icons.location_on,
                      controller: _addressController,
                      placeholder: 'Enter your address',
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Address is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    // Password Field
                    _buildPasswordField(),
                    const SizedBox(height: 16),
                    // Terms Checkbox
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            value: _agreeToTerms,
                            onChanged: (value) {
                              setState(() {
                                _agreeToTerms = value ?? false;
                              });
                            },
                            fillColor: MaterialStateColor.resolveWith((states) {
                              if (states.contains(MaterialState.selected)) {
                                return const Color(0xFF1A73E8);
                              }
                              return Colors.transparent;
                            }),
                            side: const BorderSide(color: Color(0xFFD1D5DB)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'I agree to the ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF616f89),
                                  ),
                                ),
                                TextSpan(
                                  text: 'Terms of Service',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF1A73E8),
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = () {
                                      // Handle Terms tap
                                    },
                                ),
                                const TextSpan(
                                  text: ' and ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF616f89),
                                  ),
                                ),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF1A73E8),
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = () {
                                      // Handle Privacy Policy tap
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    // Sign Up Button
                Consumer<UserProvider>(
                    builder: (context, provider, child) {
                      return provider.isLoading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                      onPressed: _handleSignUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1A73E8),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 8,
                        shadowColor: const Color(0xFF1A73E8).withOpacity(0.4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Transform.rotate(
                            angle: 0,
                            child: const Icon(Icons.arrow_forward),
                          ),
                        ],
                      ),
                      );
                    },
                    ),
                    const SizedBox(height: 24),
                    // Log In Link
                    Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Already have an account? ',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF616f89),
                              ),
                            ),
                            TextSpan(
                              text: 'Log In',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF1A73E8),
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Handle Log In navigation
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required String placeholder,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF111318),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
            prefixIcon: Icon(
              icon,
              color: const Color(0xFF9CA3AF),
              size: 20,
            ),
            filled: true,
            fillColor: const Color(0xFFF8FAFC),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Color(0xFF1A73E8),
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Password',
          style: TextStyle(
            color: Color(0xFF111318),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Password is required';
            }
            if (value!.length < 8) {
              return 'Password must be at least 8 characters';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: '••••••••',
            hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
            prefixIcon: const Icon(
              Icons.lock,
              color: Color(0xFF9CA3AF),
              size: 20,
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
              child: Icon(
                _obscurePassword
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: const Color(0xFF9CA3AF),
                size: 20,
              ),
            ),
            filled: true,
            fillColor: const Color(0xFFF8FAFC),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Color(0xFF1A73E8),
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }
}