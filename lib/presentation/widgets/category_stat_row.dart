import 'package:expenses_manager/business_logic/expense_controller.dart';
import 'package:flutter/material.dart';

Widget buildCategoryRow(
  ExpenseController controller,
  String category,
  IconData icon,
) {
  return FutureBuilder<double>(
    future: controller.getTotalByCategory(category),
    builder: (context, snapshot) {
      if (snapshot.data == 0)
        return const SizedBox.shrink(); // to hide the category if the amount is 0
      return Card(
        child: ListTile(
          leading: Icon(icon, color: Colors.green),
          title: Text(category),
          trailing: Text(
            "${snapshot.data} ر.ي",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
      );
    },
  );
}
