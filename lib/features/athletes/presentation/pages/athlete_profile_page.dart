import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/athlete_history_controller.dart';
import '../widgets/profile/athlete_history_timeline.dart';
import '../../domain/models/athlete.dart';
import '../controllers/athlete_controller.dart';
import '../widgets/profile/athlete_info_card.dart';
import '../../../../core/utils/number_helper.dart';

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

  final AthleteHistoryController _historyController =
      AthleteHistoryController();

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

    _historyController.addListener(
      _onHistoryChanged,
    );

    _initialized = true;

    final athleteId = athlete.id;

    if (athleteId != null &&
        athleteId.trim().isNotEmpty) {
      _historyController.loadHistory(
        athleteId,
      );
    }
  }

  @override
  void dispose() {
    _historyController.removeListener(
      _onHistoryChanged,
    );

    _historyController.dispose();
    _controller.dispose();

    super.dispose();
  }


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

  Future<void> editBasicInfo() async {
    final updatedAthlete =
        await showDialog<Athlete>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return _EditBasicInfoDialog(
          athlete: athlete,
          onSave: (updatedAthlete) async {
            await _controller.updateAthlete(
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

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'اطلاعات پایه ذخیره شد',
          ),
        ),
      );
    }
  }

  Widget buildCompletionCard() {
    final percent = completionPercent;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'تکمیل پروفایل',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  NumberHelper.toPersian(
                    '$percent٪',
                  ),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: percent / 100,
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              percent == 100
                  ? 'پروفایل کامل است'
                  : 'اطلاعات پایه را تکمیل کنید',
              style:
                  Theme.of(context)
                      .textTheme
                      .bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSection(
    IconData icon,
    String title,
    VoidCallback? onTap,
  ) {
    return Card(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(
          Icons.chevron_right,
        ),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 10),

          Center(
            child: GestureDetector(
              onTap: pickImage,
              child: CircleAvatar(
                radius: 55,
                backgroundImage:
                    athlete.profileImage != null
                        ? FileImage(
                            File(
                              athlete.profileImage!,
                            ),
                          )
                        : null,
                child:
                    athlete.profileImage == null
                        ? const Icon(
                            Icons.person,
                            size: 55,
                          )
                        : null,
              ),
            ),
          ),

          const SizedBox(height: 16),

          Center(
            child: Text(
              '${athlete.firstName} ${athlete.lastName}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 24),

          buildCompletionCard(),

          const SizedBox(height: 16),

          AthleteInfoCard(
            athlete: athlete,
          ),

          const SizedBox(height: 20),

          AthleteHistoryTimeline(
            history: _historyController.history,
            loading: _historyController.loading,
            error: _historyController.error,
          ),

          const SizedBox(height: 8),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: editBasicInfo,
              icon: const Icon(
                Icons.edit,
              ),
              label: const Text(
                'ویرایش اطلاعات پایه',
              ),
            ),
          ),

          const SizedBox(height: 20),

          buildSection(
            Icons.fitness_center,
            'تمرین‌ها',
            () {},
          ),

          buildSection(
            Icons.assignment,
            'آزمون‌ها',
            () {},
          ),

          buildSection(
            Icons.bar_chart,
            'گزارش عملکرد',
            () {},
          ),
        ],
      ),
    );
  }

  void _onHistoryChanged() {
    if (!mounted) return;

    setState(() {});
  }


}

class _EditBasicInfoDialog extends StatefulWidget {
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
  late final TextEditingController ageController;
  late final TextEditingController heightController;
  late final TextEditingController weightController;

  late String selectedGender;

  bool saving = false;

  @override
  void initState() {
    super.initState();

    ageController = TextEditingController(
      text: widget.athlete.age?.toString() ?? '',
    );

    heightController = TextEditingController(
      text: widget.athlete.height?.toString() ?? '',
    );

    weightController = TextEditingController(
      text: widget.athlete.weight?.toString() ?? '',
    );

    selectedGender =
        _normalizeGender(widget.athlete.gender);
  }

  String _normalizeGender(String? value) {
    if (value == 'زن' || value == 'FEMALE') {
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

  int? parseInt(String value) {
    final normalized = value.trim();

    if (normalized.isEmpty) {
      return null;
    }

    return int.tryParse(normalized);
  }

  double? parseDouble(String value) {
    final normalized = value
        .trim()
        .replaceAll(',', '.');

    if (normalized.isEmpty) {
      return null;
    }

    return double.tryParse(normalized);
  }

  Future<void> save() async {
    if (saving) return;

    final age = parseInt(
      ageController.text,
    );

    final height = parseDouble(
      heightController.text,
    );

    final weight = parseDouble(
      weightController.text,
    );

    if (age != null &&
        (age < 1 || age > 120)) {
      _showError('سن وارد شده معتبر نیست');
      return;
    }

    if (height != null &&
        (height < 50 || height > 250)) {
      _showError('قد وارد شده معتبر نیست');
      return;
    }

    if (weight != null &&
        (weight < 10 || weight > 300)) {
      _showError('وزن وارد شده معتبر نیست');
      return;
    }

    final updatedAthlete = Athlete(
      id: widget.athlete.id,
      firstName: widget.athlete.firstName,
      lastName: widget.athlete.lastName,
      gender: selectedGender,
      age: age,
      height: height,
      weight: weight,
      profileImage:
          widget.athlete.profileImage,
      createdAt:
          widget.athlete.createdAt,
      updatedAt: DateTime.now(),
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

      /*
       * نکته مهم:
       *
       * اینجا دیگر setState صفحه والد را انجام نمی‌دهیم.
       * فقط نتیجه را به showDialog برمی‌گردانیم.
       *
       * بنابراین ابتدا Dialog به طور کامل dispose می‌شود
       * و controllerهای خودش آزاد می‌شوند.
       *
       * بعد از بسته شدن Dialog، صفحه Profile نتیجه را
       * دریافت کرده و setState می‌کند.
       */
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

  void _showError(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'اطلاعات پایه',
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: ageController,
              keyboardType:
                  TextInputType.number,
              decoration:
                  const InputDecoration(
                labelText: 'سن',
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: heightController,
              keyboardType:
                  const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration:
                  const InputDecoration(
                labelText: 'قد',
                suffixText: 'سانتی‌متر',
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: weightController,
              keyboardType:
                  const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration:
                  const InputDecoration(
                labelText: 'وزن',
                suffixText: 'کیلوگرم',
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              initialValue: selectedGender,
              decoration:
                  const InputDecoration(
                labelText: 'جنسیت',
                border:
                    OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'مرد',
                  child: Text('مرد'),
                ),
                DropdownMenuItem(
                  value: 'زن',
                  child: Text('زن'),
                ),
              ],
              onChanged: saving
                  ? null
                  : (value) {
                      if (value == null) {
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
                  Navigator.of(context).pop();
                },
          child: const Text(
            'انصراف',
          ),
        ),
        FilledButton(
          onPressed: saving ? null : save,
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