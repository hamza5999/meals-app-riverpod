import 'package:flutter/material.dart';
import 'package:meals_app/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  final Category category;
  final void Function() onSelectCategory;

  const CategoryGridItem({
    required this.category,
    required this.onSelectCategory,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Used InkWell to add tap gesture and a tapping affect to the widget
    // Could use GestureDetector widget as well for this purpose but that won't
    // have any tapping affect thats why used InkWell widget
    return InkWell(
      onTap: onSelectCategory,
      // this borderRadius is for the tapping affect
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          // this borderRadius is for the grid item container
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.55),
              category.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
