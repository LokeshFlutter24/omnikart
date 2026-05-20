import 'package:flutter/material.dart';

class TrendCard extends StatelessWidget {
  final String image;
  final String label;

  const TrendCard({required this.image, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
      ),
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(10),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          shadows: [Shadow(blurRadius: 10)],
        ),
      ),
    );
  }
}