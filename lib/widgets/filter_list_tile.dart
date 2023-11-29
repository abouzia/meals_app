import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';

class FilterListTile extends ConsumerWidget {
  const FilterListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.filter,
  });

  final String title;
  final String subtitle;
  final Filter filter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedFilters = ref.watch(filtersProvider);

    return SwitchListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      value: savedFilters[filter]!,
      onChanged: (isChecked) {
        ref.read(filtersProvider.notifier).updateFilter(filter, isChecked);
      },
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
    );
  }
}
