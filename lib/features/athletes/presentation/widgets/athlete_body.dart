import 'package:flutter/material.dart';

import 'athlete_form.dart';
import 'athlete_list.dart';
import '../controllers/athlete_controller.dart';

class AthleteBody extends StatelessWidget {
  const AthleteBody({
    super.key,
    required this.controller,
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

  final AthleteController controller;

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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),

      child: Column(
        children: [

          AthleteForm(
            firstNameController: firstNameController,
            lastNameController: lastNameController,
            ageController: ageController,
            heightController: heightController,
            weightController: weightController,
            pullUpController: pullUpController,

            gender: gender,
            onGenderChanged: onGenderChanged,

            onSave: onSave,
            onClear: onClear,

            imagePath: imagePath,
            onAvatarTap: onAvatarTap,
          ),

          const SizedBox(height: 24),

          const Divider(),

          const SizedBox(height: 12),

          const Align(
            alignment: Alignment.centerRight,
            child: Text(
              'ورزشکاران ثبت شده',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 12),

          AthleteList(
            athletes: controller.athletes,
          ),
        ],
      ),
    );
  }
}