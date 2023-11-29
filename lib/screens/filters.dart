import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/widgets/filter_list_tile.dart';

class FiltersScreen extends StatelessWidget {
  const FiltersScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      body: const Column(
        children: [
          FilterListTile(
            title: 'Gluten-free',
            subtitle: 'Only include gluten-free meals',
            filter: Filter.glutenFree,
          ),
          FilterListTile(
            title: 'Lactose-free',
            subtitle: 'Only include lactose-free meals',
            filter: Filter.lactoseFree,
          ),
          FilterListTile(
            title: 'Vegetarian',
            subtitle: 'Only include vegetarian meals',
            filter: Filter.vegetarian,
          ),
          FilterListTile(
            title: 'Vegan',
            subtitle: 'Only include vegan meals',
            filter: Filter.vegan,
          ),
        ],
      ),
    );
  }
}
