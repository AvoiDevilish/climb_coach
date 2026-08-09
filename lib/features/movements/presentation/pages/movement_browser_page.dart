import 'package:flutter/material.dart';

import '../widgets/category_card.dart';
import '../widgets/movement_search_bar.dart';

import '../../data/seed/category_seed.dart';

class MovementBrowserPage extends StatelessWidget {
  const MovementBrowserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("بانک حرکات"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            MovementSearchBar(
              onChanged: (value) {},
            ),

            const SizedBox(height: 20),

            Expanded(
              child: GridView.builder(
                itemCount: CategorySeed.categories.length,

                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),

                itemBuilder: (context, index) {

                  final category =
                      CategorySeed.categories[index];

                  return CategoryCard(
                    category: category,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        "/movement/list",
                        arguments: category,
                      );
                    },
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}