import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:meals_app/providers/meals_provider.dart';

// its a global variable and it a convention in flutter to add k with the name
// of the global variable its just a convention not neccessary to do so
const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

// in order to use or consume the state data from the Provider we have to change
// our StatefullWidget to ConsumerStatefulWidget to tell flutter that we want
// to consume the state of the Provider not the simple one
class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

// similarly here too. we have to change the state class from State to
// ConsumerState and add it everywhere it is being used
class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
  Map<Filter, bool> _selectedFilters = kInitialFilters;

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
          builder: ((context) =>
              FiltersScreen(currentFilters: _selectedFilters)),
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

      setState(() {
        _selectedFilters = result ?? kInitialFilters; // ?? checks if the value
      }); // is null then it assigned the value given in the right side of ??
    }
  }

  @override
  Widget build(BuildContext context) {
    // this ref is provided by the flutter_riverpod package to fetch the state
    // or to use the provider and the state in it. its a builtin keyword

    // if we want to read the data only once then we use ref.read() but if we
    // want the build method of the widget to run again whenever the state
    // changes in the provider then we have to use the ref.watch() and it is
    // recommended too

    // we should always or mostly use the ref.watch(). it
    // requires a provider as argument and we need to pass the provider which
    // want to use or consume
    final meals = ref.watch(mealsProvider);

    final availableMeals = meals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }

      return true;
    }).toList();

    String activePageTitle = "Categories";

    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleFavoriteMealStatus,
      availableMeals: availableMeals,
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
