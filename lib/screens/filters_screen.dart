import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/meal_provider.dart';
import 'package:flutter_complete_guide/providers/theme_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final bool fromOnBoarding;

  const FiltersScreen({Key? key,  required this.fromOnBoarding}) : super(key: key);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  Widget _buildSwitchListTile(
    String title,
    String description,
    bool currentValue,
    Function(bool) updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(
        description,
      ),
      onChanged: updateValue,
      inactiveTrackColor:
          Provider.of<ThemeProvider>(context, listen: true).tm ==
                  ThemeMode.light
              ? null
              : Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, bool> currentFilters =
        Provider.of<MealProvider>(context, listen: true).filters;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                  'Gluten-free',
                  'Only include gluten-free meals.',
                  currentFilters['gluten']!,
                  (newValue) {
                    setState(
                      () {
                        currentFilters['gluten'] = newValue;
                      },
                    );
                    Provider.of<MealProvider>(context, listen: false)
                        .setFilters();
                  },
                ),
                _buildSwitchListTile(
                  'Lactose-free',
                  'Only include lactose-free meals.',
                  currentFilters['lactose']!,
                  (newValue) {
                    setState(
                      () {
                        currentFilters['lactose'] = newValue;
                      },
                    );
                    Provider.of<MealProvider>(context, listen: false)
                        .setFilters();
                  },
                ),
                _buildSwitchListTile(
                  'Vegetarian',
                  'Only include vegetarian meals.',
                  currentFilters['vegetarian']!,
                  (newValue) {
                    setState(
                      () {
                        currentFilters['vegetarian'] = newValue;
                      },
                    );
                    Provider.of<MealProvider>(context, listen: false)
                        .setFilters();
                  },
                ),
                _buildSwitchListTile(
                  'Vegan',
                  'Only include vegan meals.',
                  currentFilters['vegan']!,
                  (newValue) {
                    setState(
                      () {
                        currentFilters['vegan'] = newValue;
                      },
                    );
                    Provider.of<MealProvider>(context, listen: false)
                        .setFilters();
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
