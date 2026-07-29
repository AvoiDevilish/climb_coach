import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        TextFormField(
          controller: firstNameController,
          decoration: const InputDecoration(
            labelText: 'نام',
          ),
        ),

        const SizedBox(height: 12),

        TextFormField(
          controller: lastNameController,
          decoration: const InputDecoration(
            labelText: 'نام خانوادگی',
          ),
        ),

        const SizedBox(height: 12),

        TextField(
          controller: ageController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'سن',
            border: OutlineInputBorder(),
          ),
        ),

        const SizedBox(height: 12),

        DropdownButtonFormField<String>(
          initialValue: gender,
          decoration: const InputDecoration(
            labelText: 'جنسیت',
            border: OutlineInputBorder(),
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
          onChanged: onGenderChanged,
        ),

        const SizedBox(height: 12),

        TextField(
          controller: heightController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'قد (سانتی متر)',
            border: OutlineInputBorder(),
          ),
        ),

        const SizedBox(height: 12),

        TextField(
          controller: weightController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'وزن (کیلوگرم)',
            border: OutlineInputBorder(),
          ),
        ),

        const SizedBox(height: 12),

        TextField(
          controller: pullUpController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'بارفیکس روزانه',
            border: OutlineInputBorder(),
          ),
        ),

        const SizedBox(height: 24),

        Row(
          children: [

            Expanded(
              child: ElevatedButton(
                onPressed: onSave,
                child: const Text('ذخیره'),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: OutlinedButton(
                onPressed: onClear,
                child: const Text('پاک کردن'),
              ),
            ),

          ],
        ),
      ],
    );
  }
}