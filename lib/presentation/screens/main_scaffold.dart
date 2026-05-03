import 'package:expenses_manager/presentation/screens/web_budget_dashboard.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'dashboard_screen.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [const HomeScreen(), const DashboardScreen(), const WebBudgetDashboard()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack is for saving state when switching pages
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(20), // to make the navigation bar floating
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            backgroundColor: Colors.white,
            selectedItemColor: Colors.green.shade700,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.list_alt_rounded),
                activeIcon: Icon(Icons.list_alt_rounded, size: 30),
                label: 'المصروفات',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.pie_chart_outline_rounded),
                activeIcon: Icon(Icons.pie_chart_rounded, size: 30),
                label: 'الإحصائيات',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.pie_chart_outline_rounded),
                activeIcon: Icon(Icons.pie_chart_rounded, size: 30),
                label: 'الميزانيات',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
