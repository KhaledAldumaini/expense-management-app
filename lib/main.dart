import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'business_logic/expense_controller.dart';
import 'presentation/screens/main_scaffold.dart';
import 'presentation/screens/web_budget_entry.dart';
import 'firebase_options.dart';
import 'dart:io' show platform;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ExpenseController())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'إدارة المصروفات الذكية',
      theme: ThemeData(primarySwatch: Colors.green, useMaterial3: true),
      home: kIsWeb ? const WebBudgetEntry() : const MainScaffold(),
    );
  }
}
