import 'package:flutter/material.dart';

import '../../data/seed/category_seed.dart';
import '../../domain/models/movement_category.dart';

class MovementBrowserPage extends StatefulWidget {
  const MovementBrowserPage({
    super.key,
  });

  @override
  State<MovementBrowserPage> createState() =>
      _MovementBrowserPageState();
}

class _MovementBrowserPageState
    extends State<MovementBrowserPage> {
  String _query = '';

  List<MovementCategory> get _filteredCategories {
    final query = _query.trim().toLowerCase();

    final categories =
        CategorySeed.categories.cast<MovementCategory>();

    if (query.isEmpty) {
      return categories;
    }

    return categories
        .where(
          (category) =>
              category.title.toLowerCase().contains(query),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final categories = _filteredCategories;

    return Scaffold(
      appBar: AppBar(
        title: const Text('حرکات'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                12,
                16,
                8,
              ),
              child: TextField(
                textDirection: TextDirection.rtl,
                onChanged: (value) {
                  setState(() {
                    _query = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'جستجوی دسته حرکات',
                  prefixIcon: const Icon(
                    Icons.search,
                  ),
                  suffixIcon: _query.isEmpty
                      ? null
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              _query = '';
                            });
                          },
                          icon: const Icon(
                            Icons.clear,
                          ),
                        ),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            Expanded(
              child: categories.isEmpty
                  ? const Center(
                      child: Text(
                        'دسته‌ای پیدا نشد',
                      ),
                    )
                  : ListView.separated(
                      padding:
                          const EdgeInsets.fromLTRB(
                        16,
                        8,
                        16,
                        24,
                      ),
                      itemCount: categories.length,
                      separatorBuilder:
                          (context, index) =>
                              const SizedBox(
                        height: 8,
                      ),
                      itemBuilder:
                          (context, index) {
                        final category =
                            categories[index];

                        return _CategoryTile(
                          category: category,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/movements/list',
                              arguments:
                                  category,
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

class _CategoryTile extends StatelessWidget {
  final MovementCategory category;
  final VoidCallback onTap;

  const _CategoryTile({
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 13,
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: theme
                      .colorScheme
                      .surfaceContainerHighest,
                  borderRadius:
                      BorderRadius.circular(10),
                ),
                child: Text(
                  category.icon,
                  style: const TextStyle(
                    fontSize: 21,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  category.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Icon(
                Icons.chevron_left,
                size: 22,
                color: theme
                    .colorScheme
                    .onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
