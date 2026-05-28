import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {

  String privacyPolicy = """
Privacy Policy – OmniKart

At OmniKart, your privacy and security are our top priorities. 
We are committed to protecting your personal information and ensuring a safe shopping experience.

Information We Collect:
• Name, mobile number, and email address
• Delivery and billing address
• Payment-related information
• Device and app usage data

How We Use Your Information:
• To process and deliver your orders
• To improve app performance and user experience
• To provide customer support
• To send updates, offers, and notifications

Data Security:
We use secure technologies and encryption methods to protect your personal data from unauthorized access.

Third-Party Services:
Some services such as payment gateways and delivery partners may access limited information required to complete your orders.

Your Privacy Rights:
You can update or delete your account information anytime through the app settings.

Cookies & Tracking:
OmniKart may use cookies and analytics tools to improve functionality and personalize your experience.

By using OmniKart, you agree to our Privacy Policy and Terms of Service.

For any questions or support, contact us at:
support@omnikart.com

Thank you for trusting OmniKart.
""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF111318)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.black,

              child: const Icon(
                Icons.policy_outlined,
                color: Colors.white,
                size: 22,
              ),
            ),

            const SizedBox(width: 12),

            const Text(
              "Privacy Policy",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Container(
          padding: const EdgeInsets.all(20),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
              ),
            ],
          ),
          child:
          SingleChildScrollView(
            child: Text(
                privacyPolicy ,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.7,
                  color: Colors.grey.shade700,
                ),
              ),
          ),
        ),
      ),);
  }
}
