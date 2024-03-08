# Meals App (with Riverpod)

The 'Meals App' is a Flutter project that allows users to browse meal categories, save their favorite meals, and apply filters for customized meal selection. And the cross widget state here is managed using Riverpod.

## Widgets learned:

- GridView
- SliverGridDelegateWithFixedCrossAxisCount
- InkWell
- Navigator.of(context).push()
- Stack
- FadeInImage
- MemoryImage
- NetworkImage
- Positioned
- ListView
- BottomNavigationBar
- BottomNavigationBarItem
- Drawer
- DrawerHeader
- ListTile
- SwitchListTile
- WillPopScope
- Riverpod Package
- Provider
- ConsumerStatefulWidget
- ConsumerState
- ProviderScope

## Things learned:

- Made a grid using GridView widget to display categories in a grid
- Passed a default value to to a parameter in case no value given to that parameter
- Used InkWell widget to make any widget tapable and to add a highlighting effect on clicking that item
- Used Navigator class to add cross screen navigations
- Used where() and contains() to filter list items
- Used Stack widget to show items on each other like a stack
- Used FadeInImage utility widget to show to show an image with a fade in animation
- Used MemoryImage class to load an image locally or from the app memory
- Used NetworkImage class to load an image from the network or internet
- Used Positioned widget to position the widgets on the Stack widget
- Used simple ListView widget to display a list
- Made a navigation bar using the BottomNavigationBar widget
- Made navigation bar tabs using the BottomNavigationBarItem widget
- Passed function as a pointer through multiple widgets
- Made a custom drawer using the builtin flutter widget named Drawer()
- Add a drawer header using the builtin flutter widget named DrawerHeader()
- Used a flutter widget named ListTile() to display drawer links inside the drawer
- Used a flutter widget named SwitchListTile() to display builtin flutter switches
- Sending some data to the previous screen using the WillPopScope()
- Passed some data using Navigator.of(context).pop() and received it using Navigator.of(context).push()
- Using Riverpod for cross widget state management instead of manually handling and passing the state
- Made a provider object to manage the cross widget state using the Provider()
- Replace the StatefullWidget to ConsumerStatefulWidget to tell flutter that I want to consume Provider data
- Replace the State class with the ConsumerState similarly to consume the state from the Provider
- Wrapped the App() with ProviderScope() to make it work and manage the state across whole application
