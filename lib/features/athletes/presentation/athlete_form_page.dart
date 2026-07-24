import 'package:flutter/material.dart';

class AthleteFormPage extends StatefulWidget {
  const AthleteFormPage({super.key});

  @override
  State<AthleteFormPage> createState() => _AthleteFormPageState();
}

class _AthleteFormPageState extends State<AthleteFormPage> {

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final pullUpController = TextEditingController();

  String gender = 'مرد';

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    pullUpController.dispose();
    super.dispose();
  }


  void clearForm() {
    nameController.clear();
    ageController.clear();
    heightController.clear();
    weightController.clear();
    pullUpController.clear();

    setState(() {
      gender = 'مرد';
    });
  }


  void saveAthlete() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('اطلاعات ورزشکار ثبت شد'),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ثبت ورزشکار'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'نام ورزشکار',
                border: OutlineInputBorder(),
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
              onChanged: (value) {
                setState(() {
                  gender = value!;
                });
              },
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
                    onPressed: saveAthlete,
                    child: const Text('ذخیره'),
                  ),
                ),


                const SizedBox(width: 12),


                Expanded(
                  child: OutlinedButton(
                    onPressed: clearForm,
                    child: const Text('پاک کردن'),
                  ),
                ),

              ],
            )

          ],
        ),
      ),
    );
  }
}
