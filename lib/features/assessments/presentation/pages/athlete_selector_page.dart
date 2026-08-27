import 'package:flutter/material.dart';

import '../../../athletes/domain/models/athlete.dart';
import '../../../athletes/presentation/controllers/athlete_controller.dart';

class AthleteSelectorPage extends StatefulWidget {
  const AthleteSelectorPage({
    super.key,
  });

  @override
  State<AthleteSelectorPage> createState() =>
      _AthleteSelectorPageState();
}

class _AthleteSelectorPageState
    extends State<AthleteSelectorPage> {
  final AthleteController _controller =
      AthleteController();

  final TextEditingController _searchController =
      TextEditingController();

  String _searchQuery = '';

  @override
  void initState() {
    super.initState();

    _controller.loadAthletes();

    _controller.addListener(_refresh);

    _searchController.addListener(
      _onSearchChanged,
    );
  }

  void _refresh() {
    if (!mounted) {
      return;
    }

    setState(() {});
  }

  void _onSearchChanged() {
    if (!mounted) {
      return;
    }

    setState(() {
      _searchQuery =
          _searchController.text.trim().toLowerCase();
    });
  }

  List<Athlete> get _filteredAthletes {
    final query = _searchQuery;

    if (query.isEmpty) {
      return _controller.athletes;
    }

    return _controller.athletes.where((athlete) {
      final firstName =
          athlete.firstName.toLowerCase();

      final lastName =
          athlete.lastName.toLowerCase();

      final fullName =
          '$firstName $lastName';

      return firstName.contains(query) ||
          lastName.contains(query) ||
          fullName.contains(query);
    }).toList();
  }

  void _selectAthlete(Athlete athlete) {
    if (athlete.id == null ||
        athlete.id!.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'شناسه ورزشکار معتبر نیست',
          ),
        ),
      );

      return;
    }

    Navigator.pop(
      context,
      athlete.id,
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_refresh);

    _searchController.removeListener(
      _onSearchChanged,
    );

    _searchController.dispose();

    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final athletes = _filteredAthletes;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'انتخاب ورزشکار',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              textInputAction:
                  TextInputAction.search,
              decoration: InputDecoration(
                hintText:
                    'جستجوی ورزشکار...',
                prefixIcon: const Icon(
                  Icons.search,
                ),
                suffixIcon:
                    _searchQuery.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              _searchController
                                  .clear();
                            },
                            icon: const Icon(
                              Icons.clear,
                            ),
                          )
                        : null,
                border:
                    const OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: athletes.isEmpty
                  ? const Center(
                      child: Text(
                        'ورزشکاری پیدا نشد.',
                      ),
                    )
                  : ListView.separated(
                      itemCount:
                          athletes.length,
                      separatorBuilder:
                          (_, _) =>
                              const SizedBox(
                        height: 8,
                      ),
                      itemBuilder:
                          (context, index) {
                        final athlete =
                            athletes[index];

                        return Card(
                          child: ListTile(
                            leading:
                                CircleAvatar(
                              child: Text(
                                athlete
                                        .firstName
                                        .isNotEmpty
                                    ? athlete
                                        .firstName[0]
                                    : '?',
                              ),
                            ),
                            title: Text(
                              '${athlete.firstName} '
                              '${athlete.lastName}',
                            ),
                            subtitle:
                                athlete.gender !=
                                            null ||
                                        athlete.age !=
                                            null
                                    ? Text(
                                        [
                                          if (athlete
                                                  .gender !=
                                              null)
                                            athlete
                                                .gender!,
                                          if (athlete
                                                  .age !=
                                              null)
                                            '${athlete.age} سال',
                                        ].join(' • '),
                                      )
                                    : null,
                            trailing:
                                const Icon(
                              Icons.chevron_right,
                            ),
                            onTap: () {
                              _selectAthlete(
                                athlete,
                              );
                            },
                          ),
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