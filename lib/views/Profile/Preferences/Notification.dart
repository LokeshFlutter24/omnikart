import 'package:flutter/material.dart';

class NotificationCenter extends StatefulWidget {
  const NotificationCenter({Key? key}) : super(key: key);

  @override
  State<NotificationCenter> createState() => _NotificationCenterState();
}

class _NotificationCenterState extends State<NotificationCenter> {
  int _selectedIndex = 4; // Updates tab selected by default

  final List<NotificationItem> todayNotifications = [
    NotificationItem(
      title: 'Order Shipped',
      description: 'Your order #24982 containing "Smartwatch Series 5" has been shipped and is on its way!',
      timeAgo: '2m ago',
      icon: Icons.local_shipping,
      iconBgColor: const Color(0xFFEFF6FF),
      iconColor: const Color(0xFF2563EB),
      isUnread: true,
    ),
    NotificationItem(
      title: 'Flash Sale Alert',
      description: 'Hurry! 50% off on all Electronics ends in 3 hours. Don\'t miss out.',
      timeAgo: '2h ago',
      icon: Icons.bolt,
      iconBgColor: const Color(0xFFFEF3C7),
      iconColor: const Color(0xFFA16207),
      isUnread: true,
    ),
  ];

  final List<NotificationItem> yesterdayNotifications = [
    NotificationItem(
      title: 'Price Drop',
      description: 'Good news! An item in your wishlist "Leather Backpack" is now \$20 cheaper.',
      timeAgo: '1d ago',
      icon: Icons.local_offer,
      iconBgColor: const Color(0xFFDCFCE7),
      iconColor: const Color(0xFF16A34A),
      isUnread: false,
    ),
    NotificationItem(
      title: 'Order Delivered',
      description: 'Order #24980 has been successfully delivered. Rate your experience!',
      timeAgo: '1d ago',
      icon: Icons.local_shipping,
      iconBgColor: const Color(0xFFEFF6FF),
      iconColor: const Color(0xFF2563EB),
      isUnread: false,
    ),
  ];

  final List<NotificationItem> olderNotifications = [
    NotificationItem(
      title: 'Summer Sale is Live',
      description: 'Get up to 70% off on summer collection. Shop now before stock runs out.',
      timeAgo: '3d ago',
      icon: Icons.percent,
      iconBgColor: const Color(0xFFEDE9FE),
      iconColor: const Color(0xFF9333EA),
      isUnread: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF111318)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Color(0xFF111318),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF2563EB),
            ),
            child: const Text(
              'Mark all as read',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Today Section
          _buildNotificationSection('Today', todayNotifications),
          const SizedBox(height: 16),

          // Yesterday Section
          _buildNotificationSection('Yesterday', yesterdayNotifications),
          const SizedBox(height: 16),

          // Older Section
          _buildNotificationSection('Older', olderNotifications),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildNotificationSection(
      String sectionTitle,
      List<NotificationItem> notifications,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            sectionTitle.toUpperCase(),
            style: const TextStyle(
              color: Color(0xFF616F89),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
        ),
        Column(
          children: List.generate(
            notifications.length,
                (index) => Padding(
              padding: EdgeInsets.only(
                bottom: index < notifications.length - 1 ? 12 : 0,
              ),
              child: _buildNotificationCard(notifications[index]),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationCard(NotificationItem notification) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left colored border (unread indicator)
                  if (notification.isUnread)
                    Container(
                      width: 4,
                      height: 80,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2563EB),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          bottomLeft: Radius.circular(4),
                        ),
                      ),
                      margin: const EdgeInsets.only(right: 12),
                    )
                  else
                    const SizedBox(width: 16),

                  // Icon
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: notification.iconBgColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      notification.icon,
                      color: notification.iconColor,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              notification.title,
                              style: const TextStyle(
                                color: Color(0xFF111318),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              notification.timeAgo,
                              style: const TextStyle(
                                color: Color(0xFF9CA3AF),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          notification.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFF4B5563),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Unread dot
                  if (notification.isUnread)
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 4),
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2563EB),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NotificationItem {
  final String title;
  final String description;
  final String timeAgo;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final bool isUnread;

  NotificationItem({
    required this.title,
    required this.description,
    required this.timeAgo,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.isUnread,
  });
}