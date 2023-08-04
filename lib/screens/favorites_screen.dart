import 'package:flutter/material.dart';
import 'package:mealapp/providers/meal_provider.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Meal> favoritesMeals =
        Provider.of<MealProvider>(context, listen: true).favoritesMeals;

    if (favoritesMeals.isEmpty) {
      return const Center(
        child: Text('you have no favorites yet - start adding some!'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, i) => MealItem(meal: favoritesMeals[i]),
        itemCount: favoritesMeals.length,
      );
    }
  }
}
