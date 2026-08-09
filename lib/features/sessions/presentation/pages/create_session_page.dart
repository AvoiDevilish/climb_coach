import 'package:flutter/material.dart';

import '../controllers/session_controller.dart';
import '../../domain/models/session.dart';

import '../../../../core/utils/number_helper.dart';

class CreateSessionPage extends StatefulWidget {
  const CreateSessionPage({
    super.key,
  });

  @override
  State<CreateSessionPage> createState() =>
      _CreateSessionPageState();
}

class _CreateSessionPageState
    extends State<CreateSessionPage> {
  final SessionController controller =
      SessionController();

  final titleController =
      TextEditingController();

  final dateController =
      TextEditingController();

  final startTimeController =
      TextEditingController();

  final endTimeController =
      TextEditingController();

  final capacityController =
      TextEditingController();

  bool isRecurring = false;

  int? selectedWeekday;

  String? selectedClub;

  final List<String> clubs = [
    'Rock Stars (Boulder)',
    'شهید حریری',
    'سایت‌های طبیعت',
  ];

  final Map<int, String> weekdays = {
    DateTime.saturday: 'شنبه',
    DateTime.sunday: 'یکشنبه',
    DateTime.monday: 'دوشنبه',
    DateTime.tuesday: 'سه‌شنبه',
    DateTime.wednesday: 'چهارشنبه',
    DateTime.thursday: 'پنجشنبه',
    DateTime.friday: 'جمعه',
  };

  @override
  void dispose() {
    titleController.dispose();
    dateController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    capacityController.dispose();

    super.dispose();
  }

  Future<void> save() async {
    if (titleController.text.isEmpty ||
        startTimeController.text.isEmpty ||
        endTimeController.text.isEmpty ||
        capacityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'اطلاعات ضروری را کامل کنید',
          ),
        ),
      );

      return;
    }

    if (isRecurring &&
        selectedWeekday == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'روز هفته را انتخاب کنید',
          ),
        ),
      );

      return;
    }

    final session = Session(
      title: titleController.text,
      club: selectedClub,
      date: isRecurring
          ? ''
          : dateController.text,
      startTime: startTimeController.text,
      endTime: endTimeController.text,
      capacity: NumberHelper.parseInt(
        capacityController.text,
      ),
      isRecurring: isRecurring,
      weekday: isRecurring
          ? selectedWeekday
          : null,
    );

    try {
      await controller.addSession(session);

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      debugPrint(
        'SAVE SESSION ERROR: $e',
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
            ),
          ),
        );
      }
    }
  }

  Widget field(
    String label,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 12,
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'افزودن سانس',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            field(
              'نام سانس',
              titleController,
            ),

            DropdownButtonFormField<String>(
              initialValue: selectedClub,
              decoration: const InputDecoration(
                labelText: 'کلوپ',
                border: OutlineInputBorder(),
              ),
              items: clubs.map(
                (club) {
                  return DropdownMenuItem<String>(
                    value: club,
                    child: Text(club),
                  );
                },
              ).toList(),
              onChanged: (value) {
                setState(() {
                  selectedClub = value;
                });
              },
            ),

            const SizedBox(
              height: 12,
            ),

            SwitchListTile(
              title: const Text(
                'سانس دائمی',
              ),
              value: isRecurring,
              onChanged: (value) {
                setState(() {
                  isRecurring = value;

                  if (!value) {
                    selectedWeekday = null;
                  }
                });
              },
            ),

            if (isRecurring)
              DropdownButtonFormField<int>(
                initialValue: selectedWeekday,
                decoration: const InputDecoration(
                  labelText: 'روز هفته',
                  border: OutlineInputBorder(),
                ),
                items: weekdays.entries.map(
                  (item) {
                    return DropdownMenuItem<int>(
                      value: item.key,
                      child: Text(item.value),
                    );
                  },
                ).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedWeekday = value;
                  });
                },
              )
            else
              field(
                'تاریخ',
                dateController,
              ),

            field(
              'ساعت شروع',
              startTimeController,
            ),

            field(
              'ساعت پایان',
              endTimeController,
            ),

            field(
              'ظرفیت',
              capacityController,
            ),

            const SizedBox(
              height: 20,
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: save,
                child: const Text(
                  'ثبت سانس',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}