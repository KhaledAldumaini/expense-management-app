import 'package:flutter/material.dart';

class ExpenseCard extends StatelessWidget {
  final Map item;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const ExpenseCard({
    super.key,
    required this.item,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: Colors.green.shade100,
          child: Icon(
            _getCategoryIcon(item['category']),
            color: Colors.green.shade800,
          ),
        ),
        title: Text(
          "${item['title']}",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          "${item['category']} • ${item['date'].toString().substring(0, 10)}",
          style: TextStyle(color: Colors.grey.shade600),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${item['amount']} ر.ي",
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "طعام":
        return Icons.restaurant;
      case "مواصلات":
        return Icons.directions_bus;
      case "إيجار":
        return Icons.home;
      case "فواتير":
        return Icons.receipt_long;
      case "صحة":
        return Icons.medical_services;
      case "تسوق":
        return Icons.shopping_cart;
      case "عمل":
        return Icons.work;
      case "أخرى":
      default:
        return Icons.payments;
    }
  }
}
