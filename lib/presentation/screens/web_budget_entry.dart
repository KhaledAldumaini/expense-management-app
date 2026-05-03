import 'package:expenses_manager/presentation/screens/web_budget_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../business_logic/expense_controller.dart';

class WebBudgetEntry extends StatefulWidget {
  const WebBudgetEntry({super.key});

  @override
  State<WebBudgetEntry> createState() => _WebBudgetEntryState();
}

class _WebBudgetEntryState extends State<WebBudgetEntry> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  String _selectedCategory = 'تخطيط مالي';

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ExpenseController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "مدير المصروفات",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 16, 32, 39),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 38, 50, 56),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),

          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                const Text(
                  "إضافة ميزانية جديدة",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "اسم الهدف أو المشروع",
                    prefixIcon: Icon(Icons.track_changes),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "يرجى إدخال اسم الميزانية";
                    if (value.length < 3) return "الاسم قصير جداً";
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "المبلغ المرصود (ر.ي)",
                    prefixIcon: Icon(Icons.account_balance_wallet),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "يرجى إدخال المبلغ";
                    if (double.tryParse(value) == null)
                      return "يرجى إدخال أرقام فقط";
                    if (double.parse(value) <= 0)
                      return "المبلغ يجب أن يكون أكبر من صفر";
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                TextFormField(
                  controller: _notesController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: "ملاحظات إضافية (اختياري)",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 30),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    backgroundColor: Colors.green.shade700,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Map<String, dynamic> budgetData = {
                        "name": _nameController.text,
                        "amount": double.parse(_amountController.text),
                        "notes": _notesController.text,
                        "category": _selectedCategory,
                        "createdAt": DateTime.now().toString(),
                      };

                      try {
                        await controller.addBudgetCloud(budgetData);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("تم رفع الميزانية بنجاح!"),
                            backgroundColor: Colors.blue,
                          ),
                        );
                        _formKey.currentState!.reset();
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("حدث خطأ أثناء الرفع")),
                        );
                      }
                    }
                  },
                  child: const Text(
                    "حفظ ومزامنة مع السحابة",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WebBudgetDashboard()),
          );
        },
        label: Text("عرض السجلات"),
        icon: Icon(Icons.visibility),
        backgroundColor: Colors.orangeAccent,
      ),
    );
  }
}
