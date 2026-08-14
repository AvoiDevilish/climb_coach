import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  late Athlete athlete;

  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_initialized) return;

    athlete =
        ModalRoute.of(context)!
            .settings
            .arguments as Athlete;

    _initialized = true;
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
    final ageController = TextEditingController(
      text: athlete.age?.toString() ?? '',
    );

    final heightController = TextEditingController(
      text: athlete.height?.toString() ?? '',
    );

    final weightController = TextEditingController(
      text: athlete.weight?.toString() ?? '',
    );

    String selectedGender =
        athlete.gender ?? 'مرد';

    final formKey = GlobalKey<FormState>();

    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (
            context,
            setDialogState,
          ) {
            return AlertDialog(
              title: const Text(
                'اطلاعات پایه',
              ),
              content: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
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

                      TextFormField(
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
                          suffixText: 'سانتی‌متر',
                          border:
                              OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextFormField(
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
                          suffixText: 'کیلوگرم',
                          border:
                              OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      DropdownButtonFormField<String>(
                        initialValue:
                            selectedGender,
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
                        onChanged: (value) {
                          if (value == null) return;

                          setDialogState(() {
                            selectedGender =
                                value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                      dialogContext,
                      false,
                    );
                  },
                  child: const Text(
                    'انصراف',
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    int? age;

                    if (ageController
                        .text
                        .trim()
                        .isNotEmpty) {
                      age = int.tryParse(
                        ageController.text
                            .trim(),
                      );
                    }

                    double? height;

                    if (heightController
                        .text
                        .trim()
                        .isNotEmpty) {
                      height = double.tryParse(
                        heightController.text
                            .trim(),
                      );
                    }

                    double? weight;

                    if (weightController
                        .text
                        .trim()
                        .isNotEmpty) {
                      weight = double.tryParse(
                        weightController.text
                            .trim(),
                      );
                    }

                    if (ageController.text
                            .trim()
                            .isNotEmpty &&
                        age == null) {
                      ScaffoldMessenger.of(
                        dialogContext,
                      ).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'سن معتبر نیست',
                          ),
                        ),
                      );
                      return;
                    }

                    if (heightController
                            .text
                            .trim()
                            .isNotEmpty &&
                        height == null) {
                      ScaffoldMessenger.of(
                        dialogContext,
                      ).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'قد معتبر نیست',
                          ),
                        ),
                      );
                      return;
                    }

                    if (weightController
                            .text
                            .trim()
                            .isNotEmpty &&
                        weight == null) {
                      ScaffoldMessenger.of(
                        dialogContext,
                      ).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'وزن معتبر نیست',
                          ),
                        ),
                      );
                      return;
                    }

                    final updatedAthlete =
                        Athlete(
                      id: athlete.id,
                      firstName:
                          athlete.firstName,
                      lastName:
                          athlete.lastName,
                      gender:
                          selectedGender,
                      age: age,
                      height: height,
                      weight: weight,
                      profileImage:
                          athlete.profileImage,
                      createdAt:
                          athlete.createdAt,
                      updatedAt:
                          DateTime.now(),
                      isDeleted:
                          athlete.isDeleted,
                    );

                    await _controller
                        .updateAthlete(
                      updatedAthlete,
                    );

                    if (!mounted) return;

                    setState(() {
                      athlete =
                          updatedAthlete;
                    });

                    Navigator.pop(
                      dialogContext,
                      true,
                    );
                  },
                  child: const Text(
                    'ذخیره',
                  ),
                ),
              ],
            );
          },
        );
      },
    );

    ageController.dispose();
    heightController.dispose();
    weightController.dispose();

    if (result == true && mounted) {
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
        padding:
            const EdgeInsets.all(16),
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
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  NumberHelper.toPersian(
                    '$percent٪',
                  ),
                  style:
                      const TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            ClipRRect(
              borderRadius:
                  BorderRadius.circular(8),
              child:
                  LinearProgressIndicator(
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
      margin:
          const EdgeInsets.only(
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

  String formatNumber(
    num value,
  ) {
    final text =
        value % 1 == 0
            ? value
                .toInt()
                .toString()
            : value.toString();

    return NumberHelper.toPersian(
      text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text(
          'پروفایل ورزشکار',
        ),
      ),
      body: ListView(
        padding:
            const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 10),

          Center(
            child:
                GestureDetector(
              onTap: pickImage,
              child:
                  CircleAvatar(
                radius: 55,
                backgroundImage:
                    athlete.profileImage !=
                            null
                        ? FileImage(
                            File(
                              athlete
                                  .profileImage!,
                            ),
                          )
                        : null,
                child:
                    athlete.profileImage ==
                            null
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
              style:
                  const TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 24),

          buildCompletionCard(),

          const SizedBox(height: 16),

          AthleteInfoCard(
            athlete: athlete,
          ),

          const SizedBox(height: 8),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed:
                  editBasicInfo,
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
}