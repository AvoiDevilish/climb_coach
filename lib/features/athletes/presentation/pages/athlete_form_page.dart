import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/models/athlete.dart';
import '../controllers/athlete_controller.dart';
import '../widgets/athlete_body.dart';

class AthleteFormPage extends StatefulWidget {
  const AthleteFormPage({super.key});

  @override
  State<AthleteFormPage> createState() => _AthleteFormPageState();
}

class _AthleteFormPageState extends State<AthleteFormPage> {
  final AthleteController _controller = AthleteController();
  final AthleteController controller = AthleteController();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final pullUpController = TextEditingController();

  String gender = 'مرد';

  String? selectedImagePath;

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

    selectedImagePath = null;

    setState(() {
      gender = 'مرد';
    });
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();

    final image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) return;

    setState(() {
      selectedImagePath = image.path;
    });
  }

  Future<void> saveAthlete() async {
    debugPrint('saveAthlete started');

    final firstName =
        firstNameController.text.trim();

    final lastName =
        lastNameController.text.trim();

    if (firstName.isEmpty || lastName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "نام و نام خانوادگی الزامی است",
          ),
          backgroundColor: Colors.orange,
        ),
      );

      return;
    }

    final exists =
        await _controller.athleteExists(
              firstName,
              lastName,
            );
    if (!mounted) return;

    if (exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "این ورزشکار قبلاً ثبت شده است",
          ),
          backgroundColor: Colors.red,
        ),
      );

      return;
    }

    final athlete = Athlete(
      id: DateTime.now()
          .millisecondsSinceEpoch
          .toString(),

      firstName: firstName,
      lastName: lastName,
      profileImage: selectedImagePath,
    );

    await _controller.addAthlete(athlete);

    await controller.loadAthletes();

    clearForm();

    if (!mounted) return;

    FocusScope.of(context).unfocus();

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
        imagePath: selectedImagePath,

        onAvatarTap: pickImage,
      ),
    );
  }
}