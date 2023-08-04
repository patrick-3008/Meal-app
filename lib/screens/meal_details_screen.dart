import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mealapp/dummy_data.dart';
import 'package:mealapp/providers/meal_provider.dart';

class MealDetailsScreen extends StatelessWidget {
  static const routeName = '/meal_detail_screen';

  const MealDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => mealId == meal.id);

    return Scaffold(
      appBar: AppBar(title: Text(selectedMeal.title)),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 300,
            child: Image.network(selectedMeal.imageUrl, fit: BoxFit.cover),
          ),
          buildTitle(context, 'Ingredients'),
          buildContainer(
            ListView.builder(
              itemBuilder: (ctx, i) => Card(
                color: Colors.amber,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(selectedMeal.ingredients[i]),
                ),
              ),
              itemCount: selectedMeal.ingredients.length,
            ),
          ),
          buildTitle(context, 'Steps'),
          buildContainer(
            ListView.builder(
              itemBuilder: (ctx, i) => Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Text('#${i + 1}'),
                    ),
                    title: Text(selectedMeal.steps[i]),
                  ),
                  const Divider(),
                ],
              ),
              itemCount: selectedMeal.steps.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Provider.of<MealProvider>(context, listen: false)
            .toggleFavorite(mealId),
        child: Icon(
          Provider.of<MealProvider>(context, listen: true)
                  .isMealFavorite(mealId)
              ? Icons.star
              : Icons.star_border,
        ),
      ),
    );
  }

  Container buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  buildTitle(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
