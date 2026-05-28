import 'package:flutter/material.dart';

class HelpCenter extends StatefulWidget {
  const HelpCenter({super.key});

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {

  final List<Map<String, dynamic>> helpCenterList = [

    {
      "icon": Icons.local_shipping_outlined,
      "title": "Track Your Order",
      "subtitle": "Check your order and delivery status",
    },

    {
      "icon": Icons.payment_outlined,
      "title": "Payments & Refunds",
      "subtitle": "Payment issues and refund updates",
    },

    {
      "icon": Icons.swap_horiz_rounded,
      "title": "Return & Replacement",
      "subtitle": "Easy return and exchange support",
    },

    {
      "icon": Icons.lock_outline,
      "title": "Account & Security",
      "subtitle": "Manage account and privacy settings",
    },

    {
      "icon": Icons.discount_outlined,
      "title": "Offers & Coupons",
      "subtitle": "Apply promo codes and discounts",
    },

    {
      "icon": Icons.support_agent_outlined,
      "title": "Customer Support",
      "subtitle": "24/7 customer help and assistance",
    },

    {
      "icon": Icons.location_on_outlined,
      "title": "Address Management",
      "subtitle": "Add or update delivery addresses",
    },

    {
      "icon": Icons.inventory_2_outlined,
      "title": "Product Related Queries",
      "subtitle": "Product details and availability help",
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF111318)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Help Center",style:
          TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
      body: ListView.builder(
        itemCount: helpCenterList.length,

        itemBuilder: (context, index) {

          final item = helpCenterList[index];

          return Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),

            padding: const EdgeInsets.all(16),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                ),
              ],
            ),

            child: Row(
              children: [

                Container(
                  padding: const EdgeInsets.all(12),

                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),

                  child: Icon(
                    item['icon'],
                    color: Colors.blue,
                    size: 28,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      Text(
                        item['title'],

                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        item['subtitle'],

                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),

                const Icon(Icons.arrow_forward_ios_rounded,
                    size: 18),
              ],
            ),
          );
        },
      ),
    );
  }
}
