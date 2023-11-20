import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  final Meal meal;

  const MealItem({required this.meal, super.key});

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
                    const Row(
                      children: [],
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
