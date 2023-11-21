import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const CategoriesScreen();

    if (_selectedPageIndex == 1) {
      activePage = const MealsScreen(title: "Favorites", meals: []);
    }

    return Scaffold(
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          // could also pass _selectedPage(index) directly into
          // onTap parameter but didn't for the sake of better understanding
          _selectedPage(index);
        }, // this value or index parameter (after renaming) is
        // provided by flutter
        currentIndex: _selectedPageIndex, // to show the current tab
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
