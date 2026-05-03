import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../business_logic/expense_controller.dart';
import '../widgets/expense_card.dart';
import '../widgets/delete_dialog.dart';
import 'add_expense.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _navigateToAddExpense() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddExpense()),
    );
  }

  void _confirmDelete(int id) {
    showDialog(
      context: context,
      builder: (context) => DeleteDialog(
        onConfirm: () async {
          await Provider.of<ExpenseController>(
            context,
            listen: false,
          ).deleteExpense(id);
        },
      ),
    );
  }

  void _showDetails(Map item) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item['title'],
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const Divider(),
            const SizedBox(height: 10),
            Text(
              "Amount: ${item['amount']} ر.ي",
              style: const TextStyle(fontSize: 18, color: Colors.red),
            ),
            const SizedBox(height: 10),
            Text(
              "Category: ${item['category']}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              "Description:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              item['description'] ?? "No Description",
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ExpenseController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "مدير الصروفات",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green.shade700,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade700,
        onPressed: () => _navigateToAddExpense(),
        child: const Icon(Icons.add, color: Colors.white, size: 20),
      ),
      body: FutureBuilder<List<Map>>(
        future: controller.getAllExpenses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("لا توجد أي مصاريف"));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final item = snapshot.data![index];
              return ExpenseCard(
                onTap: () => _showDetails(item),
                item: item,
                onDelete: () => _confirmDelete(item['id']),
              );
            },
          );
        },
      ),
    );
  }
}
