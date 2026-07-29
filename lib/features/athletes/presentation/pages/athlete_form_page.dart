import 'package:flutter/material.dart';

import '../../data/repositories/athlete_repository.dart';
import '../../domain/models/athlete.dart';
import '../controllers/athlete_controller.dart';
import '../widgets/athlete_body.dart';

class AthleteFormPage extends StatefulWidget {
  const AthleteFormPage({super.key});

  @override
  State<AthleteFormPage> createState() => _AthleteFormPageState();
}

class _AthleteFormPageState extends State<AthleteFormPage> {
  final AthleteRepository _repository = AthleteRepository();
  final AthleteController controller = AthleteController();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final pullUpController = TextEditingController();

  String gender = 'مرد';

  @override
  void initState() {
    super.initState();

    controller.loadAthletes().then((_) {
      if (mounted) {
        setState(() {});
      }
    });

    controller.addListener(_refresh);
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    controller.removeListener(_refresh);

    firstNameController.dispose();
    lastNameController.dispose();
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    pullUpController.dispose();

    super.dispose();
  }

  void clearForm() {
    firstNameController.clear();
    lastNameController.clear();
    ageController.clear();
    heightController.clear();
    weightController.clear();
    pullUpController.clear();

    setState(() {
      gender = 'مرد';
    });
  }

  Future<void> saveAthlete() async {
    debugPrint('saveAthlete started');
    final athlete = Athlete(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
    );

    await _repository.insertAthlete(athlete);

    await controller.loadAthletes();

    clearForm();

    if (!mounted) return;

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
      body: AthleteBody(
        controller: controller,
        firstNameController: firstNameController,
        lastNameController: lastNameController,
        ageController: ageController,
        heightController: heightController,
        weightController: weightController,
        pullUpController: pullUpController,
        gender: gender,
        onGenderChanged: (value) {
          setState(() {
            gender = value!;
          });
        },
        onSave: saveAthlete,
        onClear: clearForm,
      ),
    );
  }
}