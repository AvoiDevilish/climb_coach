import 'package:flutter/material.dart';

import '../widgets/athlete_list.dart';
import '../controllers/athlete_controller.dart';
import '../../domain/models/athlete.dart';

class AthleteListPage extends StatefulWidget {
  const AthleteListPage({
    super.key,
  });

  @override
  State<AthleteListPage> createState() =>
      _AthleteListPageState();
}

class _AthleteListPageState extends State<AthleteListPage> {
  final AthleteController controller =
      AthleteController();

  final TextEditingController searchController =
      TextEditingController();

  String searchQuery = '';

  String genderFilter = 'همه';

  String profileFilter = 'همه';

  String informationFilter = 'همه';

  @override
  void initState() {
    super.initState();

    controller.loadAthletes();

    controller.addListener(_refresh);

    searchController.addListener(_onSearchChanged);
  }

  void _refresh() {
    if (!mounted) return;

    setState(() {});
  }

  void _onSearchChanged() {
    if (!mounted) return;

    setState(() {
      searchQuery =
          searchController.text.trim().toLowerCase();
    });
  }

  bool _isInformationComplete(Athlete athlete) {
    return athlete.age != null &&
        athlete.height != null &&
        athlete.weight != null &&
        athlete.gender != null &&
        athlete.gender!.trim().isNotEmpty;
  }

  List<Athlete> get filteredAthletes {
    final athletes =
        controller.athletes.cast<Athlete>();

    return athletes.where((athlete) {
      // -------------------------
      // Search
      // -------------------------

      final firstName =
          athlete.firstName.toLowerCase();

      final lastName =
          athlete.lastName.toLowerCase();

      final fullName =
          '$firstName $lastName';

      final matchesSearch =
          searchQuery.isEmpty ||
          firstName.contains(searchQuery) ||
          lastName.contains(searchQuery) ||
          fullName.contains(searchQuery);

      if (!matchesSearch) {
        return false;
      }

      // -------------------------
      // Gender
      // -------------------------

      if (genderFilter == 'مرد' &&
          athlete.gender != 'مرد') {
        return false;
      }

      if (genderFilter == 'زن' &&
          athlete.gender != 'زن') {
        return false;
      }

      // -------------------------
      // Profile image
      // -------------------------

      if (profileFilter == 'دارای عکس' &&
          (athlete.profileImage == null ||
              athlete.profileImage!.trim().isEmpty)) {
        return false;
      }

      if (profileFilter == 'بدون عکس' &&
          athlete.profileImage != null &&
          athlete.profileImage!.trim().isNotEmpty) {
        return false;
      }

      // -------------------------
      // Basic information
      // -------------------------

      final informationComplete =
          _isInformationComplete(athlete);

      if (informationFilter == 'تکمیل‌شده' &&
          !informationComplete) {
        return false;
      }

      if (informationFilter == 'ناقص' &&
          informationComplete) {
        return false;
      }

      return true;
    }).toList();
  }

  bool get hasActiveFilters {
    return genderFilter != 'همه' ||
        profileFilter != 'همه' ||
        informationFilter != 'همه';
  }

  void _resetFilters() {
    setState(() {
      genderFilter = 'همه';
      profileFilter = 'همه';
      informationFilter = 'همه';
    });
  }

  Future<void> _showFilters() async {
    String temporaryGender = genderFilter;
    String temporaryProfile = profileFilter;
    String temporaryInformation = informationFilter;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (
            context,
            setModalState,
          ) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  20,
                  20,
                  24,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'فیلتر ورزشکارها',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),
                        if (
                          temporaryGender != 'همه' ||
                          temporaryProfile != 'همه' ||
                          temporaryInformation != 'همه'
                        )
                          TextButton(
                            onPressed: () {
                              setModalState(() {
                                temporaryGender =
                                    'همه';
                                temporaryProfile =
                                    'همه';
                                temporaryInformation =
                                    'همه';
                              });
                            },
                            child:
                                const Text(
                              'حذف فیلترها',
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'جنسیت',
                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Wrap(
                      spacing: 8,
                      children: [
                        _filterChoice(
                          label: 'همه',
                          selected:
                              temporaryGender ==
                                  'همه',
                          onSelected: () {
                            setModalState(() {
                              temporaryGender =
                                  'همه';
                            });
                          },
                        ),
                        _filterChoice(
                          label: 'مرد',
                          selected:
                              temporaryGender ==
                                  'مرد',
                          onSelected: () {
                            setModalState(() {
                              temporaryGender =
                                  'مرد';
                            });
                          },
                        ),
                        _filterChoice(
                          label: 'زن',
                          selected:
                              temporaryGender ==
                                  'زن',
                          onSelected: () {
                            setModalState(() {
                              temporaryGender =
                                  'زن';
                            });
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'اطلاعات پایه',
                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Wrap(
                      spacing: 8,
                      children: [
                        _filterChoice(
                          label: 'همه',
                          selected:
                              temporaryInformation ==
                                  'همه',
                          onSelected: () {
                            setModalState(() {
                              temporaryInformation =
                                  'همه';
                            });
                          },
                        ),
                        _filterChoice(
                          label: 'تکمیل‌شده',
                          selected:
                              temporaryInformation ==
                                  'تکمیل‌شده',
                          onSelected: () {
                            setModalState(() {
                              temporaryInformation =
                                  'تکمیل‌شده';
                            });
                          },
                        ),
                        _filterChoice(
                          label: 'ناقص',
                          selected:
                              temporaryInformation ==
                                  'ناقص',
                          onSelected: () {
                            setModalState(() {
                              temporaryInformation =
                                  'ناقص';
                            });
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'عکس پروفایل',
                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Wrap(
                      spacing: 8,
                      children: [
                        _filterChoice(
                          label: 'همه',
                          selected:
                              temporaryProfile ==
                                  'همه',
                          onSelected: () {
                            setModalState(() {
                              temporaryProfile =
                                  'همه';
                            });
                          },
                        ),
                        _filterChoice(
                          label: 'دارای عکس',
                          selected:
                              temporaryProfile ==
                                  'دارای عکس',
                          onSelected: () {
                            setModalState(() {
                              temporaryProfile =
                                  'دارای عکس';
                            });
                          },
                        ),
                        _filterChoice(
                          label: 'بدون عکس',
                          selected:
                              temporaryProfile ==
                                  'بدون عکس',
                          onSelected: () {
                            setModalState(() {
                              temporaryProfile =
                                  'بدون عکس';
                            });
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            genderFilter =
                                temporaryGender;

                            profileFilter =
                                temporaryProfile;

                            informationFilter =
                                temporaryInformation;
                          });

                          Navigator.pop(
                            sheetContext,
                          );
                        },
                        child:
                            const Text(
                          'اعمال فیلتر',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _filterChoice({
    required String label,
    required bool selected,
    required VoidCallback onSelected,
  }) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) {
        onSelected();
      },
    );
  }

  Future<void> openNewAthletePage() async {
    await Navigator.pushNamed(
      context,
      '/athlete/new',
    );

    await controller.loadAthletes();
  }

  @override
  void dispose() {
    controller.removeListener(_refresh);

    searchController.removeListener(
      _onSearchChanged,
    );

    searchController.dispose();

    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final athletes = filteredAthletes;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ورزشکاران',
        ),
        centerTitle: true,
      ),

      floatingActionButton:
          FloatingActionButton.extended(
        onPressed:
            openNewAthletePage,
        icon: const Icon(
          Icons.person_add,
        ),
        label: const Text(
          'ثبت ورزشکار',
        ),
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(16),

        child: Column(
          children: [
            TextField(
              controller:
                  searchController,

              textInputAction:
                  TextInputAction.search,

              decoration:
                  InputDecoration(
                hintText:
                    'جستجوی ورزشکار...',

                prefixIcon:
                    const Icon(
                  Icons.search,
                ),

                suffixIcon:
                    searchQuery.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              searchController
                                  .clear();
                            },
                            icon:
                                const Icon(
                              Icons.clear,
                            ),
                          )
                        : null,

                border:
                    const OutlineInputBorder(),
              ),
            ),

            const SizedBox(
              height: 12,
            ),

            Row(
              children: [
                IconButton(
                  onPressed:
                      _showFilters,
                  icon: Icon(
                    Icons.filter_alt,
                    color:
                        hasActiveFilters
                            ? Theme.of(context)
                                .colorScheme
                                .primary
                            : null,
                  ),
                  tooltip:
                      'فیلتر ورزشکارها',
                ),

                Expanded(
                  child: Text(
                    hasActiveFilters
                        ? '${athletes.length} ورزشکار'
                        : searchQuery.isEmpty
                            ? 'همه ورزشکاران'
                            : '${athletes.length} ورزشکار',
                  ),
                ),

                if (hasActiveFilters)
                  TextButton(
                    onPressed:
                        _resetFilters,
                    child:
                        const Text(
                      'حذف فیلتر',
                    ),
                  ),
              ],
            ),

            if (hasActiveFilters)
              Align(
                alignment:
                    Alignment.centerRight,
                child: Wrap(
                  spacing: 6,
                  children: [
                    if (genderFilter != 'همه')
                      Chip(
                        label:
                            Text(
                          genderFilter,
                        ),
                      ),
                    if (informationFilter !=
                        'همه')
                      Chip(
                        label:
                            Text(
                          informationFilter,
                        ),
                      ),
                    if (profileFilter != 'همه')
                      Chip(
                        label:
                            Text(
                          profileFilter,
                        ),
                      ),
                  ],
                ),
              ),

            const SizedBox(
              height: 12,
            ),

            Expanded(
              child: AthleteList(
                athletes: athletes,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
