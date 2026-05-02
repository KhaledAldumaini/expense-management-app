import 'package:expenses_manager/business_logic/expense_controller.dart';
import 'package:expenses_manager/data/local/sqldb.dart';
import 'package:expenses_manager/presentation/widgets/build_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  SqlDb sqlDb = SqlDb();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  String? selectedCategory = "أخرى"; // default value

  final List<String> categories = [
    "طعام",
    "مواصلات",
    "إيجار",
    "فواتير",
    "صحة",
    "تسوق",
    "عمل",
    "أخرى",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Expense"),
        backgroundColor: Colors.green.shade700,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text(
              "Enter expense details",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            buildTextField("Expense Title", titleController, Icons.title),
            const SizedBox(height: 15),

            buildTextField(
              "Description",
              descriptionController,
              Icons.description,
            ),
            const SizedBox(height: 15),

            buildTextField(
              "Amount",
              amountController,
              Icons.money,
              isNumber: true,
            ),
            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Category",
                prefixIcon: const Icon(Icons.category, color: Colors.green),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items: categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue;
                });
              },
            ),
            const SizedBox(height: 30),

            MaterialButton(
              color: Colors.green.shade700,
              textColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () async {
                final controller = Provider.of<ExpenseController>(context, listen: false);

                bool success = await controller.addExpense(
                  titleController.text,
                  descriptionController.text,
                  amountController.text,
                  selectedCategory!,
                );

                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Expense added successfully"),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pop(context);
                } else {
                  // تنبيه في حالة وجود خطأ في البيانات
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Failed to add expense"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text("Add Expense", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
