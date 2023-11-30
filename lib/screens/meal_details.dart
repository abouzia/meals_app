import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/favourites_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouriteMeals = ref.watch(favouriteMealsProvider);
    final isFavourite = favouriteMeals.contains(meal);

    void showMessage(bool wasAdded) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            wasAdded ? 'Added to favourites!' : 'Removed from favourites!',
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .watch(favouriteMealsProvider.notifier)
                  .toggleMealFavouriteStatus(meal);

              showMessage(wasAdded);
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween(
                    begin: 0.5,
                    end: 1.0,
                  ).animate(animation),
                  child: child,
                );
              },
              child: Icon(
                isFavourite ? Icons.star : Icons.star_border,
                key: ValueKey(isFavourite),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: meal.id,
              child: Image.network(
                meal.imageUrl,
                height: 250,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 10),
            for (final ingredient in meal.ingredients)
              Text(
                ingredient,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            const SizedBox(height: 16),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 10),
            for (final step in meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
