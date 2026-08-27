import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/number_helper.dart';
import '../../domain/models/athlete.dart';
import '../controllers/athlete_controller.dart';
import '../widgets/athlete_health_card.dart';

class AthleteProfilePage extends StatefulWidget {
  const AthleteProfilePage({
    super.key,
  });

  @override
  State<AthleteProfilePage> createState() =>
      _AthleteProfilePageState();
}

class _AthleteProfilePageState
    extends State<AthleteProfilePage> {
  final ImagePicker _picker = ImagePicker();

  final AthleteController _controller =
      AthleteController();

  late Athlete athlete;

  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_initialized) return;

    final argument =
        ModalRoute.of(context)?.settings.arguments;

    if (argument is! Athlete) {
      return;
    }

    athlete = argument;
    _initialized = true;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ============================================================
  // Profile image
  // ============================================================

  Future<void> pickImage() async {
    final image = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) return;

    final updatedAthlete = Athlete(
      id: athlete.id,
      firstName: athlete.firstName,
      lastName: athlete.lastName,
      gender: athlete.gender,
      age: athlete.age,
      height: athlete.height,
      weight: athlete.weight,
      profileImage: image.path,
      healthStatus: athlete.healthStatus,
      injuryAreas: athlete.injuryAreas,
      injurySince: athlete.injurySince,
      recoveryUntil: athlete.recoveryUntil,
      createdAt: athlete.createdAt,
      updatedAt: DateTime.now(),
      isDeleted: athlete.isDeleted,
    );

    try {
      await _controller.updateAthlete(
        updatedAthlete,
      );

      if (!mounted) return;

      setState(() {
        athlete = updatedAthlete;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'تصویر پروفایل ذخیره شد',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'ذخیره تصویر ناموفق بود: $e',
          ),
        ),
      );
    }
  }

  // ============================================================
  // Profile completion
  // ============================================================

  int get completionPercent {
    int completed = 0;
    const total = 7;

    if (athlete.firstName.trim().isNotEmpty) {
      completed++;
    }

    if (athlete.lastName.trim().isNotEmpty) {
      completed++;
    }

    if (athlete.profileImage != null &&
        athlete.profileImage!.trim().isNotEmpty) {
      completed++;
    }

    if (athlete.age != null) {
      completed++;
    }

    if (athlete.height != null) {
      completed++;
    }

    if (athlete.weight != null) {
      completed++;
    }

    if (athlete.gender != null &&
        athlete.gender!.trim().isNotEmpty) {
      completed++;
    }

    return ((completed / total) * 100).round();
  }

  String get athleteFullName {
    final firstName =
        athlete.firstName.trim();

    final lastName =
        athlete.lastName.trim();

    final fullName =
        '$firstName $lastName'.trim();

    return fullName.isEmpty
        ? 'ورزشکار'
        : fullName;
  }

  // ============================================================
  // Combined profile + basic information card
  // ============================================================

  Widget buildProfileCard() {
    final percent =
        completionPercent;

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding:
              const EdgeInsets.fromLTRB(
            16,
            12,
            16,
            12,
          ),
          childrenPadding:
              const EdgeInsets.fromLTRB(
            16,
            0,
            16,
            16,
          ),
          leading: const Icon(
            Icons.person_outline,
          ),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  athleteFullName,
                  maxLines: 1,
                  overflow:
                      TextOverflow.ellipsis,
                  style:
                      const TextStyle(
                    fontSize: 16,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                NumberHelper.toPersian(
                  '$percent٪',
                ),
                style:
                    TextStyle(
                  fontWeight:
                      FontWeight.bold,
                  color:
                      Theme.of(context)
                          .colorScheme
                          .primary,
                ),
              ),
            ],
          ),
          subtitle: Padding(
            padding:
                const EdgeInsets.only(
              top: 10,
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(
                    8,
                  ),
                  child:
                      LinearProgressIndicator(
                    value:
                        percent / 100,
                    minHeight: 8,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  percent == 100
                      ? 'پروفایل کامل است'
                      : 'برای مشاهده و ویرایش اطلاعات پایه باز کنید',
                  style:
                      Theme.of(context)
                          .textTheme
                          .bodySmall,
                ),
              ],
            ),
          ),
          children: [
            const Divider(
              height: 1,
            ),

            const SizedBox(
              height: 8,
            ),

            _infoRow(
              'سن',
              athlete.age == null
                  ? 'ثبت نشده'
                  : '${NumberHelper.toPersian(
                      athlete.age!,
                    )} سال',
            ),

            _infoRow(
              'قد',
              athlete.height == null
                  ? 'ثبت نشده'
                  : '${NumberHelper.toPersian(
                      athlete.height!,
                    )} سانتی‌متر',
            ),

            _infoRow(
              'وزن',
              athlete.weight == null
                  ? 'ثبت نشده'
                  : '${NumberHelper.toPersian(
                      athlete.weight!,
                    )} کیلوگرم',
            ),

            _infoRow(
              'جنسیت',
              athlete.gender == null ||
                      athlete.gender!
                          .trim()
                          .isEmpty
                  ? 'ثبت نشده'
                  : athlete.gender!,
            ),

            const SizedBox(
              height: 12,
            ),

            SizedBox(
              width: double.infinity,
              child:
                  FilledButton.tonalIcon(
                onPressed:
                    editBasicInfo,
                icon: const Icon(
                  Icons.edit_outlined,
                ),
                label: const Text(
                  'ویرایش اطلاعات',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(
    String title,
    String value,
  ) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style:
                  const TextStyle(
                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ),
          Text(value),
        ],
      ),
    );
  }

  // ============================================================
  // Edit basic information
  // ============================================================

  Future<void> editBasicInfo() async {
    final updatedAthlete =
        await showDialog<Athlete>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return _EditBasicInfoDialog(
          athlete: athlete,
          onSave:
              (updatedAthlete) async {
            await _controller
                .updateAthlete(
              updatedAthlete,
            );
          },
        );
      },
    );

    if (!mounted) return;

    if (updatedAthlete != null) {
      setState(() {
        athlete = updatedAthlete;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'اطلاعات پایه ذخیره شد',
          ),
        ),
      );
    }
  }

  // ============================================================
  // Generic expandable section
  // ============================================================

  Widget buildSection({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? content,
  }) {
    return Card(
      margin:
          const EdgeInsets.only(
        top: 12,
      ),
      child: ExpansionTile(
        leading: Icon(icon),
        title: Text(
          title,
          style:
              const TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),
        subtitle: subtitle == null
            ? null
            : Text(subtitle),
        children: content == null
            ? []
            : [
                Padding(
                  padding:
                      const EdgeInsets.fromLTRB(
                    16,
                    0,
                    16,
                    16,
                  ),
                  child: content,
                ),
              ],
      ),
    );
  }

  Widget buildComingSoonContent() {
    return Align(
      alignment:
          Alignment.centerRight,
      child: Text(
        'به‌زودی',
        style:
            Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
          color:
              Theme.of(context)
                  .colorScheme
                  .onSurfaceVariant,
        ),
      ),
    );
  }

  // ============================================================
  // Build
  // ============================================================

  @override
  Widget build(
    BuildContext context,
  ) {
    if (!_initialized) {
      return const Scaffold(
        body: Center(
          child: Text(
            'اطلاعات ورزشکار قابل بارگذاری نیست',
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'پروفایل ورزشکار',
        ),
        centerTitle: true,
      ),

      body: ListView(
        padding:
            const EdgeInsets.all(16),
        children: [
          const SizedBox(
            height: 10,
          ),

          // ------------------------------------------------------
          // Profile image
          // ------------------------------------------------------

          Center(
            child: GestureDetector(
              onTap: pickImage,
              child: CircleAvatar(
                radius: 55,
                backgroundImage:
                    athlete.profileImage !=
                                null &&
                            athlete.profileImage!
                                .trim()
                                .isNotEmpty
                        ? FileImage(
                            File(
                              athlete
                                  .profileImage!,
                            ),
                          )
                        : null,
                child:
                    athlete.profileImage ==
                                null ||
                            athlete.profileImage!
                                .trim()
                                .isEmpty
                        ? const Icon(
                            Icons.person,
                            size: 55,
                          )
                        : null,
              ),
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          // ------------------------------------------------------
          // Combined profile card
          // ------------------------------------------------------

          buildProfileCard(),

          AthleteHealthCard(
            athlete: athlete,
            onChanged: (updatedAthlete) async {
              await _controller.updateAthlete(updatedAthlete);
              if (mounted) {
                setState(() => athlete = updatedAthlete);
              }
            },
          ),

          // ------------------------------------------------------
          // Movements
          // ------------------------------------------------------

          buildSection(
            icon:
                Icons.fitness_center,
            title:
                'حرکات و برنامه تمرینی',
            content:
                Align(
              alignment:
                  Alignment.centerRight,
              child:
                  FilledButton.tonalIcon(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/athlete/training',
                    arguments: athlete,
                  );
                },
                icon:
                    const Icon(
                  Icons.arrow_forward,
                ),
                label:
                    const Text(
                  'مشاهده حرکات و برنامه',
                ),
              ),
            ),
          ),

          // ------------------------------------------------------
          // Assessments
          // ------------------------------------------------------

          buildSection(
            icon:
                Icons.assignment_outlined,
            title: 'آزمون‌ها',
            subtitle: 'اجرای آزمون و ثبت نتیجه توسط مربی',
            content: Align(
              alignment: Alignment.centerRight,
              child: FilledButton.tonalIcon(
                onPressed: () async {
                  await Navigator.pushNamed(context, '/assessments');
                },
                icon: const Icon(Icons.assignment_outlined),
                label: const Text('مشاهده آزمون‌ها'),
              ),
            ),
          ),

          // ------------------------------------------------------
          // Reports
          // ------------------------------------------------------

          buildSection(
            icon:
                Icons.bar_chart_outlined,
            title: 'گزارش عملکرد',
            subtitle: 'روند عملکرد و سابقه ثبت‌شده',
            content: Align(
              alignment: Alignment.centerRight,
              child: Text('ثبت عملکرد پایه در این Sprint فعال است؛ نمودارهای تفصیلی در مرحله گزارش‌گیری تکمیل می‌شوند.', textAlign: TextAlign.right),
            ),
          ),

          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Edit Basic Information Dialog
// ============================================================================

class _EditBasicInfoDialog
    extends StatefulWidget {
  final Athlete athlete;

  final Future<void> Function(
    Athlete updatedAthlete,
  ) onSave;

  const _EditBasicInfoDialog({
    required this.athlete,
    required this.onSave,
  });

  @override
  State<_EditBasicInfoDialog> createState() =>
      _EditBasicInfoDialogState();
}

class _EditBasicInfoDialogState
    extends State<_EditBasicInfoDialog> {
  late final TextEditingController
      ageController;

  late final TextEditingController
      heightController;

  late final TextEditingController
      weightController;

  late String selectedGender;

  bool saving = false;

  @override
  void initState() {
    super.initState();

    ageController =
        TextEditingController(
      text:
          widget.athlete.age
                  ?.toString() ??
              '',
    );

    heightController =
        TextEditingController(
      text:
          widget.athlete.height
                  ?.toString() ??
              '',
    );

    weightController =
        TextEditingController(
      text:
          widget.athlete.weight
                  ?.toString() ??
              '',
    );

    selectedGender =
        _normalizeGender(
      widget.athlete.gender,
    );
  }

  String _normalizeGender(
    String? value,
  ) {
    if (value == 'زن' ||
        value == 'FEMALE') {
      return 'زن';
    }

    return 'مرد';
  }

  @override
  void dispose() {
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();

    super.dispose();
  }

  int? parseInt(
    String value,
  ) {
    final normalized =
        value.trim();

    if (normalized.isEmpty) {
      return null;
    }

    return int.tryParse(
      normalized,
    );
  }

  double? parseDouble(
    String value,
  ) {
    final normalized =
        value
            .trim()
            .replaceAll(',', '.');

    if (normalized.isEmpty) {
      return null;
    }

    return double.tryParse(
      normalized,
    );
  }

  Future<void> save() async {
    if (saving) return;

    final age =
        parseInt(
      ageController.text,
    );

    final height =
        parseDouble(
      heightController.text,
    );

    final weight =
        parseDouble(
      weightController.text,
    );

    if (age != null &&
        (age < 1 ||
            age > 120)) {
      _showError(
        'سن وارد شده معتبر نیست',
      );
      return;
    }

    if (height != null &&
        (height < 50 ||
            height > 250)) {
      _showError(
        'قد وارد شده معتبر نیست',
      );
      return;
    }

    if (weight != null &&
        (weight < 10 ||
            weight > 300)) {
      _showError(
        'وزن وارد شده معتبر نیست',
      );
      return;
    }

    final updatedAthlete =
        Athlete(
      id: widget.athlete.id,
      firstName:
          widget.athlete.firstName,
      lastName:
          widget.athlete.lastName,
      gender: selectedGender,
      age: age,
      height: height,
      weight: weight,
      profileImage:
          widget.athlete.profileImage,
      healthStatus:
          widget.athlete.healthStatus,
      injuryAreas:
          widget.athlete.injuryAreas,
      injurySince:
          widget.athlete.injurySince,
      recoveryUntil:
          widget.athlete.recoveryUntil,
      createdAt:
          widget.athlete.createdAt,
      updatedAt:
          DateTime.now(),
      isDeleted:
          widget.athlete.isDeleted,
    );

    setState(() {
      saving = true;
    });

    try {
      await widget.onSave(
        updatedAthlete,
      );

      if (!mounted) return;

      Navigator.of(context).pop(
        updatedAthlete,
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        saving = false;
      });

      _showError(
        'ذخیره اطلاعات ناموفق بود: $e',
      );
    }
  }

  void _showError(
    String message,
  ) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content:
            Text(message),
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return AlertDialog(
      title: const Text(
        'اطلاعات پایه',
      ),

      content:
          SingleChildScrollView(
        child: Column(
          mainAxisSize:
              MainAxisSize.min,
          children: [
            TextField(
              controller:
                  ageController,
              keyboardType:
                  TextInputType.number,
              decoration:
                  const InputDecoration(
                labelText: 'سن',
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(
              height: 12,
            ),

            TextField(
              controller:
                  heightController,
              keyboardType:
                  const TextInputType
                      .numberWithOptions(
                decimal: true,
              ),
              decoration:
                  const InputDecoration(
                labelText: 'قد',
                suffixText:
                    'سانتی‌متر',
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(
              height: 12,
            ),

            TextField(
              controller:
                  weightController,
              keyboardType:
                  const TextInputType
                      .numberWithOptions(
                decimal: true,
              ),
              decoration:
                  const InputDecoration(
                labelText: 'وزن',
                suffixText:
                    'کیلوگرم',
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(
              height: 12,
            ),

            DropdownButtonFormField<
                String>(
              initialValue:
                  selectedGender,
              decoration:
                  const InputDecoration(
                labelText:
                    'جنسیت',
                border:
                    OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'مرد',
                  child:
                      Text('مرد'),
                ),
                DropdownMenuItem(
                  value: 'زن',
                  child:
                      Text('زن'),
                ),
              ],
              onChanged:
                  saving
                      ? null
                      : (value) {
                          if (value ==
                              null) {
                            return;
                          }

                          setState(() {
                            selectedGender =
                                value;
                          });
                        },
            ),
          ],
        ),
      ),

      actions: [
        TextButton(
          onPressed: saving
              ? null
              : () {
                  Navigator.of(
                    context,
                  ).pop();
                },
          child:
              const Text(
            'انصراف',
          ),
        ),

        FilledButton(
          onPressed:
              saving
                  ? null
                  : save,
          child: saving
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child:
                      CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
              : const Text(
                  'ذخیره',
                ),
        ),
      ],
    );
  }
}