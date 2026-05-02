class ExpenseModel {
  int? id;
  String? title;
  String? description;
  double? amount;
  String? category;
  String? date;

  ExpenseModel({this.id, required this.title, this.description, required this.amount, this.category, this.date});

  // this for converting map to object
  ExpenseModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    description = map['description'];
    amount = map['amount'];
    category = map['category'];
    date = map['date'];
  }

  // this for converting object to map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'category': category,
      'date': date,
      'description': description
    };
  }
}