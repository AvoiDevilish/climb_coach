import 'package:flutter/material.dart';

import '../../data/seed/movement_seed.dart';
import '../../domain/models/movement.dart';
import '../../domain/models/movement_category.dart';

class MovementListPage extends StatefulWidget {
  const MovementListPage({
    super.key,
  });

  @override
  State<MovementListPage> createState() =>
      _MovementListPageState();
}

class _MovementListPageState
    extends State<MovementListPage> {
  String _searchQuery = '';

  List<Movement> _filteredMovements(
    MovementCategory category,
  ) {
    final query = _searchQuery.trim().toLowerCase();

    return MovementSeed.movements
        .where(
          (movement) =>
              movement.category == category.id &&
              !movement.isDeleted,
        )
        .where(
          (movement) =>
              query.isEmpty ||
              movement.name
                  .toLowerCase()
                  .contains(query),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final argument =
        ModalRoute.of(context)?.settings.arguments;

    if (argument is! MovementCategory) {
      return const Scaffold(
        body: Center(
          child: Text(
            'دسته حرکات قابل بارگذاری نیست',
          ),
        ),
      );
    }

    final category = argument;
    final movements = _filteredMovements(category);

    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
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
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'جستجوی حرکت...',
                  prefixIcon: const Icon(
                    Icons.search,
                  ),
                  suffixIcon:
                      _searchQuery.isEmpty
                          ? null
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  _searchQuery = '';
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
              child: movements.isEmpty
                  ? _EmptyState(
                      hasSearchQuery:
                          _searchQuery
                              .trim()
                              .isNotEmpty,
                    )
                  : ListView.separated(
                      padding:
                          const EdgeInsets.fromLTRB(
                        16,
                        8,
                        16,
                        24,
                      ),
                      itemCount: movements.length,
                      separatorBuilder:
                          (context, index) =>
                              const SizedBox(
                        height: 8,
                      ),
                      itemBuilder:
                          (context, index) {
                        final movement =
                            movements[index];

                        return _MovementTile(
                          movement: movement,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/movement/detail',
                              arguments: movement,
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

class _MovementTile extends StatelessWidget {
  final Movement movement;
  final VoidCallback onTap;

  const _MovementTile({
    required this.movement,
    required this.onTap,
  });

  String _measurementLabel(String type) {
    switch (type) {
      case 'reps':
        return 'تکرار';

      case 'time':
        return 'زمان';

      case 'weight':
        return 'وزنه';

      case 'distance':
        return 'مسافت';

      case 'angle':
        return 'زاویه';

      default:
        return type;
    }
  }

  IconData _measurementIcon(String type) {
    switch (type) {
      case 'reps':
        return Icons.repeat;

      case 'time':
        return Icons.timer_outlined;

      case 'weight':
        return Icons.fitness_center;

      case 'distance':
        return Icons.straighten;

      case 'angle':
        return Icons.architecture;

      default:
        return Icons.analytics_outlined;
    }
  }

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
            vertical: 12,
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
                child: Icon(
                  _measurementIcon(
                    movement.measurementType,
                  ),
                  size: 21,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      movement.name,
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      movement.bodyRegion,
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
                      style: theme
                          .textTheme
                          .bodySmall
                          ?.copyWith(
                            color: theme
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.end,
                children: [
                  Text(
                    _measurementLabel(
                      movement.measurementType,
                    ),
                    style: theme
                        .textTheme
                        .bodySmall
                        ?.copyWith(
                          color: theme
                              .colorScheme
                              .onSurfaceVariant,
                        ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    movement.measurementUnit,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 6),

              Icon(
                Icons.chevron_left,
                size: 21,
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

class _EmptyState extends StatelessWidget {
  final bool hasSearchQuery;

  const _EmptyState({
    required this.hasSearchQuery,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              hasSearchQuery
                  ? Icons.search_off
                  : Icons.fitness_center_outlined,
              size: 42,
              color: Theme.of(context)
                  .colorScheme
                  .onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            Text(
              hasSearchQuery
                  ? 'حرکتی با این نام پیدا نشد'
                  : 'حرکتی در این دسته وجود ندارد',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
