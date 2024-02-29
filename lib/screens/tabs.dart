import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _toggleFavoriteMealStatus(Meal meal) {
    setState(() {
      if (_favoriteMeals.contains(meal)) {
        _favoriteMeals.remove(meal);

        _showSnackBar("Meal removed from Favorites");
      } else {
        _favoriteMeals.add(meal);

        _showSnackBar("Meal added to Favorites");
      }
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Text(message),
      ),
    );
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop(); // just close the drawer as we are already
    // in the tabs screen. We don't need to navigate to the tabs screen as
    // doing that would be redundent

    // we want to close the drawer everytime before going to any screen so
    // adding it at the start of the function - code improvement
    if (identifier == 'filters') {
      // we can also use Navigator.of(context).pushReplacement() instead of this
      // Navigator.of(context).push() if we dont want to go back on back button
      // press it will simply replace the screen instead of adding it on top of
      // the stack so the back button won't move us to the previous screen

      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: ((context) => const FiltersScreen()),
        ),
      );
      // as we are passing some data from Navigator.of(context).pop() inside
      // the FiltersScreen we have to receive it too. And in here we are
      // receiving it a final variable. Had to add await before the
      // Navigator.of(context).push() and async with the _setScreen method
      // because we are getting a Future from the FiltersScreen widget

      // we have to specify the data of the returned object in the push()
      // because Navigator.of(context).push() is a generic method. We were
      // returning a map so we added <Map> but Map is also a generic type so we
      // have to tell dart the type keys and values too. So we added
      // <Filter, bool> with the <Map> making it to <Map<Filter, bool>>

      print(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    String activePageTitle = "Categories";

    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleFavoriteMealStatus,
    );

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleFavoriteMealStatus,
      );

      activePageTitle = "Favorites";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ), // we could also use the flutter's builtin default Drawer() widget but
      // in this case there were too many customizations so we decided to make
      // our own sidebar drawer "MainDrawer"

      // sidebar or drawer is added on screen to screen basis, so if you
      // want to show it on both the categories and favorites screen then add
      // it on the common screen containing both the above mentioned screens
      // that is tabsscreen
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
