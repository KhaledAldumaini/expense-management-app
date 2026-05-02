import 'package:expenses_manager/presentation/widgets/category_stat_row.dart';
import 'package:expenses_manager/presentation/widgets/summary_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../business_logic/expense_controller.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ExpenseController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("الإحصائيات"),
        backgroundColor: Colors.green.shade700,
        actions: [
          Consumer<ExpenseController>(
            builder: (context, controller, child) {
              return IconButton(
                icon: controller.isSyncing
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(
                        Icons.cloud_upload_outlined,
                        color: Colors.white,
                      ),
                onPressed: controller.isSyncing
                    ? null
                    : () async {
                        try {
                          await controller.syncExpensesToCloud();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("تمت المزامنة السحابية بنجاح"),
                              backgroundColor: Colors.blueAccent,
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("فشلت المزامنة، تحقق من اتصالك"),
                            ),
                          );
                        }
                      },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FutureBuilder<double>(
              future: controller.getTotalExpenses(),
              builder: (context, snapshot) {
                return buildSummaryCard(
                  "المجموع الكلي للمصروفات",
                  "${snapshot.data ?? 0} ر.ي",
                  Colors.orange.shade800,
                  Icons.account_balance_wallet,
                );
              },
            ),

            const SizedBox(height: 20),
            const Align(
              child: Text(
                "تحليل المصروفات",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),

            // list of expenses by category
            Expanded(
              child: ListView(
                children: [
                  buildCategoryRow(controller, "طعام", Icons.restaurant),
                  buildCategoryRow(controller, "مواصلات", Icons.directions_bus),
                  buildCategoryRow(controller, "فواتير", Icons.receipt_long),
                  buildCategoryRow(controller, "تسوق", Icons.shopping_cart),

                  buildCategoryRow(controller, "إيجار", Icons.house_outlined),
                  buildCategoryRow(controller, "صحة", Icons.medical_services),
                  buildCategoryRow(controller, "عمل", Icons.work),
                  buildCategoryRow(controller, "أخرى", Icons.payments),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
