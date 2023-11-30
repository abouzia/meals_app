import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
    required this.onSelectMeal,
  });
  final Meal meal;
  final void Function() onSelectMeal;

  String get complexityText =>
      meal.complexity.name[0].toUpperCase() + meal.complexity.name.substring(1);

  String get affordabilityText =>
      meal.affordability.name[0].toUpperCase() +
      meal.affordability.name.substring(1);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 3,
      child: InkWell(
        onTap: onSelectMeal,
        child: Stack(
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                height: 200,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: const Color.fromARGB(213, 255, 255, 255),
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MealTrait(
                          icon: Icons.timelapse,
                          label: '${meal.duration} min',
                        ),
                        const SizedBox(width: 16),
                        MealTrait(
                          icon: Icons.work,
                          label: complexityText,
                        ),
                        const SizedBox(width: 16),
                        MealTrait(
                          icon: Icons.attach_money,
                          label: affordabilityText,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
