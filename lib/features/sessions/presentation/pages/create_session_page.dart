import 'package:flutter/material.dart';

import '../controllers/session_controller.dart';

import '../../domain/models/session.dart';


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



  bool allowMakeup = true;



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


    final session = Session(

      title:
          titleController.text,


      date:
          dateController.text,


      startTime:
          startTimeController.text,


      endTime:
          endTimeController.text,


      capacity:
          int.tryParse(
            capacityController.text,
          ) ?? 0,


      allowMakeup:
          allowMakeup,

    );



    await controller.addSession(
      session,
    );



    if (mounted) {

      Navigator.pop(context);

    }


  }





  Widget field(
    String label,
    TextEditingController controller,
  ) {

    return Padding(

      padding:
          const EdgeInsets.only(
            bottom: 12,
          ),


      child: TextField(

        controller:
            controller,


        decoration:
            InputDecoration(

          labelText:
              label,


          border:
              const OutlineInputBorder(),

        ),

      ),

    );

  }






  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(

        title:
            const Text(
              "افزودن سانس",
            ),

      ),



      body: SingleChildScrollView(


        padding:
            const EdgeInsets.all(16),



        child: Column(


          children: [


            field(
              "نام سانس",
              titleController,
            ),


            field(
              "تاریخ",
              dateController,
            ),


            field(
              "ساعت شروع",
              startTimeController,
            ),


            field(
              "ساعت پایان",
              endTimeController,
            ),


            field(
              "ظرفیت",
              capacityController,
            ),



            SwitchListTile(

              title:
                  const Text(
                    "پذیرش جبرانی",
                  ),


              value:
                  allowMakeup,


              onChanged:
                  (value) {

                setState(() {

                  allowMakeup =
                      value;

                });

              },

            ),




            const SizedBox(
              height: 20,
            ),



            SizedBox(

              width:
                  double.infinity,


              child:
                  ElevatedButton(

                onPressed:
                    save,


                child:
                    const Text(
                      "ثبت سانس",
                    ),

              ),

            ),


          ],

        ),

      ),

    );

  }

}