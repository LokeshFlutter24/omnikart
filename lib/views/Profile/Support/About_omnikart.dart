import 'package:flutter/material.dart';

class AboutOmnikart extends StatefulWidget {
  const AboutOmnikart({super.key});

  @override
  State<AboutOmnikart> createState() => _AboutOmnikartState();
}

class _AboutOmnikartState extends State<AboutOmnikart> {

  String aboutUs = """
Welcome to OmniKart — your trusted online shopping destination.

At OmniKart, we believe shopping should be simple, fast, and enjoyable. 
Our platform offers a wide range of quality products including fashion, 
electronics, beauty, lifestyle, home essentials, and much more at affordable prices.

We are committed to providing:

• High-quality products  
• Secure payments  
• Fast delivery  
• Easy returns & refunds  
• 24/7 customer support  

Our mission is to deliver the best online shopping experience with 
modern technology, trusted services, and customer satisfaction.

Thank you for choosing OmniKart.
Happy Shopping!
""";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.black,

              child: const Icon(
                Icons.shopping_bag_outlined,
                color: Colors.white,
                size: 22,
              ),
            ),

            const SizedBox(width: 12),

            const Text(
              "About OmniKart",
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Text(
              aboutUs,
              style: TextStyle(
                fontSize: 16,
                height: 1.7,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    ),);
  }
}
