import 'package:flutter/material.dart';

import 'athlete_avatar_picker.dart';

class AthleteForm extends StatelessWidget {
  const AthleteForm({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.ageController,
    required this.heightController,
    required this.weightController,
    required this.pullUpController,
    required this.gender,
    required this.onGenderChanged,
    required this.onSave,
    required this.onClear,

    required this.imagePath,
    required this.onAvatarTap,
  });

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController ageController;
  final TextEditingController heightController;
  final TextEditingController weightController;
  final TextEditingController pullUpController;

  final String gender;

  final ValueChanged<String?> onGenderChanged;

  final VoidCallback onSave;
  final VoidCallback onClear;

  final String? imagePath;
  final VoidCallback onAvatarTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [

            const Text(
              "ثبت ورزشکار جدید",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 24),

            Center(
              child: AthleteAvatarPicker(
                imagePath: imagePath,
                onTap: onAvatarTap,
              ),
            ),

            const SizedBox(height: 24),

            TextFormField(
              controller: firstNameController,
              decoration: const InputDecoration(
                labelText: "نام",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: lastNameController,
              decoration: const InputDecoration(
                labelText: "نام خانوادگی",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: [

                Expanded(
                  child: FilledButton(
                    onPressed: onSave,
                    child: const Text("ثبت ورزشکار"),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: OutlinedButton(
                    onPressed: onClear,
                    child: const Text("پاک کردن"),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}