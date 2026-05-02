import 'package:flutter/material.dart';

Widget buildSummaryCard(
  String title,
  String amount,
  Color color,
  IconData icon,
) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(25),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.3),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(icon, color: Colors.white, size: 40),
        const SizedBox(height: 10),
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 18)),
        Text(
          amount,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
