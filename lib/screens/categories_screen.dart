import 'package:flutter/material.dart';
import '../widgets/categories_item.dart';
import '../dummy_categories.dart';

class CategoriesScreenW extends StatelessWidget {
  @override
  Widget build(BuildContext contex) {
    return GridView(
        padding: const EdgeInsets.all(15),
        children: DUMMY_CATEGORIES
            .map(
              (e) => CategoryItemW(
                e.id,
                e.title,
                e.color,
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
