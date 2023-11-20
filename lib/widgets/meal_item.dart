import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  final Meal meal;

  const MealItem({required this.meal, super.key});

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 2, // to add some shadow around the card
      // shape property won't work without the clipBehavior property because
      // Stack widget by default ignores the shape property
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.hardEdge, // it clips the hard edges according to the
      // shape property
      child: InkWell(
        onTap: () {},
        child: Stack(
          children: [
            // FadeInImage to show an image with a fade in animation effect
            FadeInImage(
              fit: BoxFit.cover, // to make sure the image is never distorted -
              // it will use the below height and width specified to cover the
              // image without being distorted
              height: 225,
              width: double.infinity,
              // image in placeholder will be shown during the loading time of
              // the actual image
              placeholder: MemoryImage(kTransparentImage), // MemoryImage to
              // load an image locally like from local storage, an asset bundle
              image: NetworkImage(meal.imageUrl), // NetworkImage is used to
              // load images from the internet
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 44,
                ),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true, // To wrap the text in a good looking way
                      overflow: TextOverflow.ellipsis, // To handle overflow of
                      // large test by adding 3 dots (...)
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      // As we know that, below custom widget 'MealItemTrait'
                      // has also a Row inside it and when we add a Row inside
                      // a Row widget we have to wrap it with a Expanded widget
                      // but we aren't doing it here because here that thing is
                      // being handled by this Positioned widget. As we are,
                      // setting the Left and Right properties of Positioned
                      // widget. So it is not letting the Row widget to be left
                      // as an unconstrained widget means those Left and Right
                      // property are specifying a width and the inner Row is
                      // within that width. So, we don't need Expanded here.
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: '${meal.duration} mins',
                        ),
                        const SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.work,
                          label: complexityText,
                        ),
                        const SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.attach_money,
                          label: affordabilityText,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
