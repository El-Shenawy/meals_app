import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_complete_guide/providers/meal_provider.dart';
import 'package:provider/provider.dart';

import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildContainer(BuildContext context, Widget child) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var dw = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      width: isLandscape ? (dw * 0.5 - 30) : dw,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var accentColor = Theme.of(context).accentColor;
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    var listIngredients = ListView.builder(
      padding: EdgeInsets.all(0),
      itemBuilder: (ctx, index) => Card(
        color: accentColor,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          child: Text(
            selectedMeal.ingredients[index],
            style: TextStyle(
                color: useWhiteForeground(accentColor)
                    ? Colors.white
                    : Colors.black),
          ),
        ),
      ),
      itemCount: selectedMeal.ingredients.length,
    );
    var listSteps = ListView.builder(
      padding: EdgeInsets.all(0),
      itemBuilder: (ctx, index) => Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Text('# ${(index + 1)}'),
            ),
            title: Text(
              selectedMeal.steps[index],
              style: TextStyle(color: Colors.black),
            ),
          ),
          Divider()
        ],
      ),
      itemCount: selectedMeal.steps.length,
    );
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('${selectedMeal.title}'),
              background:  Hero(
                tag: mealId,
                child: InteractiveViewer(
                  child: FadeInImage(
                    width: double.infinity,
                    placeholder: AssetImage('assets/images/a2.png'),
                    image: NetworkImage(
                      selectedMeal.imageUrl,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                if (isLandscape)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          buildSectionTitle(context, 'Ingredients'),
                          buildContainer(context, listIngredients),
                        ],
                      ),
                      Column(
                        children: [
                          buildSectionTitle(context, 'Steps'),
                          buildContainer(context, listSteps),
                        ],
                      ),
                    ],
                  ),
                if (!isLandscape) buildSectionTitle(context, 'Ingredients'),
                if (!isLandscape) buildContainer(context, listIngredients),
                if (!isLandscape) buildSectionTitle(context, 'Steps'),
                if (!isLandscape) buildContainer(context, listSteps),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Provider.of<MealProvider>(context, listen: true).isFavorite(mealId)
              ? Icons.star
              : Icons.star_border,
        ),
        onPressed: () => Provider.of<MealProvider>(context, listen: false)
            .toggleFavorite(mealId),
      ),
    );
  }
}
