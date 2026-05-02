import 'package:expenses_manager/data/remote/dbfirebase_methods.dart';
import 'package:flutter/material.dart';

import '../data/local/sqldb.dart';
import '../data/models/expense_model.dart';

class ExpenseController with ChangeNotifier {
  final SqlDb _sqlDb = SqlDb();
  bool _isSyncing = false;
  bool get isSyncing => _isSyncing;

  final Databasemethods _firebaseDb = Databasemethods();

  Future<bool> addExpense(
    String title,
    String description,
    String amount,
    String category,
  ) async {
    if (title.isEmpty || description.isEmpty || amount.isEmpty) return false;

    double? parsedAmount = double.tryParse(amount);
    if (parsedAmount == null) return false;

    ExpenseModel newExpense = ExpenseModel(
      title: title,
      description: description,
      amount: parsedAmount,
      category: category,
      date: DateTime.now().toString(),
    );

    int response = await _sqlDb.insertData('''
      INSERT INTO 'expenses' ('title', 'amount', 'category', 'date', 'description')
      VALUES ("${newExpense.title}", "${newExpense.amount}", "${newExpense.category}", "${newExpense.date}", "${newExpense.description}")
    ''');
    if (response > 0) {
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> deleteExpense(int id) async {
    int response = await _sqlDb.deleteData(
      "DELETE FROM 'expenses' WHERE id = $id",
    );

    if (response > 0) {
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<List<Map>> getAllExpenses() async {
    return await _sqlDb.readData("SELECT * FROM 'expenses' ORDER BY id DESC");
  }

  // count total expenses
  Future<double> getTotalExpenses() async {
    var result = await _sqlDb.readData(
      "SELECT SUM(amount) as total FROM 'expenses'",
    );
    return result[0]['total'] != null
        ? double.parse(result[0]['total'].toString())
        : 0.0;
  }

  // count expenses by category
  Future<double> getTotalByCategory(String category) async {
    var result = await _sqlDb.readData(
      "SELECT SUM(amount) as total FROM 'expenses' WHERE category = '$category'",
    );
    return result[0]['total'] != null
        ? double.parse(result[0]['total'].toString())
        : 0.0;
  }

  Future<void> syncExpensesToCloud() async {
    _isSyncing = true;
    notifyListeners();

    try {
      List<Map> localExpenses = await getAllExpenses();

      for (var expense in localExpenses) {
        String docId = expense['id'].toString();

        Map<String, dynamic> dataToUpload = {
          "title": expense['title'],
          "amount": expense['amount'],
          "category": expense['category'],
          "description": expense['description'],
          "date": expense['date'],
          "syncedAt": DateTime.now().toString(),
        };

        await _firebaseDb.addData(dataToUpload, docId, "user_expenses");
      }
    } catch (e) {
      debugPrint("Sync Error: $e");
      rethrow;
    } finally {
      _isSyncing = false;
      notifyListeners();
    }
  }
}
