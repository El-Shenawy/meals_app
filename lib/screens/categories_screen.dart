import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/meal_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(25),
      children: Provider.of<MealProvider>(context).availableCategories
          .map(
            (catData) => CategoryItem(
                  catData.id,
                  catData.title,
                  catData.color,
                ),
          )
          .toList(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
    );
  }
}
