import 'package:flutter/material.dart';

import '../../domain/models/athlete.dart';
import '../controllers/athlete_controller.dart';

class AthleteBasicInfoPage extends StatefulWidget {
  const AthleteBasicInfoPage({
    super.key,
  });

  @override
  State<AthleteBasicInfoPage> createState() =>
      _AthleteBasicInfoPageState();
}

class _AthleteBasicInfoPageState
    extends State<AthleteBasicInfoPage> {
  final AthleteController _controller =
      AthleteController();

  late Athlete athlete;

  late TextEditingController ageController;
  late TextEditingController heightController;
  late TextEditingController weightController;

  String? gender;

  bool initialized = false;
  bool saving = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (initialized) return;

    final argument =
        ModalRoute.of(context)?.settings.arguments;

    if (argument is! Athlete) {
      return;
    }

    athlete = argument;

    ageController = TextEditingController(
      text: athlete.age?.toString() ?? '',
    );

    heightController = TextEditingController(
      text: athlete.height?.toString() ?? '',
    );

    weightController = TextEditingController(
      text: athlete.weight?.toString() ?? '',
    );

    gender = athlete.gender;

    initialized = true;
  }

  @override
  void dispose() {
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    _controller.dispose();

    super.dispose();
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

  int? parseInt(String value) {
    final normalized = value.trim();

    if (normalized.isEmpty) {
      return null;
    }

    return int.tryParse(normalized);
  }

  Future<void> save() async {
    final age = parseInt(ageController.text);
    final height = parseDouble(heightController.text);
    final weight = parseDouble(weightController.text);

    if (age != null && (age < 1 || age > 120)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'سن وارد شده معتبر نیست',
          ),
        ),
      );

      return;
    }

    if (height != null &&
        (height < 50 || height > 250)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'قد وارد شده معتبر نیست',
          ),
        ),
      );

      return;
    }

    if (weight != null &&
        (weight < 10 || weight > 300)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'وزن وارد شده معتبر نیست',
          ),
        ),
      );

      return;
    }

    setState(() {
      saving = true;
    });

    final updatedAthlete = Athlete(
      id: athlete.id,

      firstName: athlete.firstName,
      lastName: athlete.lastName,

      gender: gender,
      age: age,
      height: height,
      weight: weight,

      profileImage: athlete.profileImage,

      createdAt: athlete.createdAt,
      updatedAt: DateTime.now(),

      isDeleted: athlete.isDeleted,
    );

    try {
      await _controller.updateAthlete(
        updatedAthlete,
      );

      if (!mounted) return;

      Navigator.pop(
        context,
        updatedAthlete,
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        saving = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'ذخیره اطلاعات ناموفق بود: $e',
          ),
        ),
      );
    }
  }

  Widget numberField({
    required String label,
    required TextEditingController controller,
    String? suffix,
    TextInputType keyboardType =
        TextInputType.number,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16,
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          labelText: label,
          suffixText: suffix,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!initialized) {
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
          'اطلاعات پایه',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            '${athlete.firstName} ${athlete.lastName}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 24),

          DropdownButtonFormField<String>(
            initialValue: gender,
            decoration: const InputDecoration(
              labelText: 'جنسیت',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(
                value: 'MALE',
                child: Text('مرد'),
              ),
              DropdownMenuItem(
                value: 'FEMALE',
                child: Text('زن'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                gender = value;
              });
            },
          ),

          const SizedBox(height: 16),

          numberField(
            label: 'سن',
            controller: ageController,
            suffix: 'سال',
          ),

          numberField(
            label: 'قد',
            controller: heightController,
            suffix: 'سانتی‌متر',
          ),

          numberField(
            label: 'وزن',
            controller: weightController,
            suffix: 'کیلوگرم',
          ),

          const SizedBox(height: 8),

          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: saving ? null : save,
              child: saving
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'ذخیره اطلاعات',
                    ),
            ),
          ),
        ],
      ),
    );
  }
}