import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/models/athlete.dart';
import '../controllers/athlete_controller.dart';


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


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    athlete =
        ModalRoute.of(context)!
            .settings
            .arguments as Athlete;
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

    debugPrint('ATHLETE ID: ${athlete.id}');

    debugPrint(
      'NEW IMAGE PATH: ${updatedAthlete.profileImage}',
    );

    debugPrint(
      'ATHLETE ID FOR UPDATE: ${updatedAthlete.id}',
    );

    await _controller.updateAthlete(
      updatedAthlete,
    );

    setState(() {
      athlete = updatedAthlete;
    });

    if (!mounted) return;

    Navigator.pop(
      context,
      updatedAthlete,
    );


    if (!mounted) return;


    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content:
            Text('تصویر پروفایل ذخیره شد'),
      ),
    );
  }


  Widget buildSection(
    BuildContext context,
    IconData icon,
    String title,
  ) {

    return Card(

      margin:
          const EdgeInsets.only(bottom: 12),

      child: ListTile(

        leading:
            Icon(icon),

        title:
            Text(title),

        trailing:
            const Icon(
              Icons.chevron_right,
            ),

        onTap: () {},
      ),
    );
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar:
          AppBar(
            title:
                const Text(
                  "پروفایل ورزشکار",
                ),
          ),


      body:
          ListView(

        padding:
            const EdgeInsets.all(16),


        children: [


          const SizedBox(
            height: 10,
          ),


          Center(

            child:
                GestureDetector(

              onTap:
                  pickImage,


              child:
                  CircleAvatar(

                radius:
                    55,


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



          const SizedBox(
            height: 20,
          ),



          Center(

            child:
                Text(

              '${athlete.firstName} ${athlete.lastName}',

              style:
                  const TextStyle(

                fontSize:
                    22,

                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),



          const SizedBox(
            height: 30,
          ),



          buildSection(
            context,
            Icons.badge,
            "اطلاعات پایه",
          ),


          buildSection(
            context,
            Icons.fitness_center,
            "تمرین ها",
          ),


          buildSection(
            context,
            Icons.assignment,
            "آزمون ها",
          ),


          buildSection(
            context,
            Icons.bar_chart,
            "گزارش عملکرد",
          ),

        ],
      ),
    );
  }
}