import 'package:flutter/material.dart';
import 'package:map_my_habits/pages/daily_check_page.dart';
import 'package:map_my_habits/pages/manage_page.dart';
import 'package:map_my_habits/pages/map_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  int _currentIndex = 2;

  final List<Widget> _children = const [
    DailyCheckPage(title: "Daily Check"),
    MapPage(title: "Map My Habits"),
    ManagePage(title: "Manage"),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'May My Habits',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.check_box_outlined), label: "CHECK"),
            BottomNavigationBarItem(
                icon: Icon(Icons.map_outlined), label: "MAP"),
            BottomNavigationBarItem(
                icon: Icon(Icons.manage_search_outlined), label: "SEARCH"),
          ],
        ),
      ),
    );
  }
}
