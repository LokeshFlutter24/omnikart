import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../connectivity_service/connectivity_service.dart';

class ConnectionStatusWidget extends StatelessWidget {
  final Widget child;

  const ConnectionStatusWidget({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityService>(
      builder: (context, connectivityService, _) {
        return Stack(
          children: [
            child,
            // ❌ No Internet Banner
            if (!connectivityService!.isConnected)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.red.shade600,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      const SizedBox(width: 16),
                      const Icon(Icons.wifi_off, color: Colors.white),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          "No Internet Connection",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Retry logic
                        },
                        child: const Text(
                          "Retry",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}