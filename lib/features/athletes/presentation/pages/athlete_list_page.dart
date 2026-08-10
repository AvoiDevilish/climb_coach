import 'package:flutter/material.dart';
import '../widgets/athlete_list.dart';
import '../controllers/athlete_controller.dart';


class AthleteListPage extends StatefulWidget {
  const AthleteListPage({
    super.key,
  });

  @override
  State<AthleteListPage> createState() =>
      _AthleteListPageState();
}


class _AthleteListPageState
    extends State<AthleteListPage> {

  final AthleteController controller =
      AthleteController();



  @override
  void initState() {
    super.initState();

    controller.loadAthletes();

    controller.addListener(_refresh);
  }



  void _refresh() {

    if (mounted) {

      setState(() {});

    }

  }



  Future<void> openNewAthletePage() async {

    await Navigator.pushNamed(
      context,
      '/athlete/new',
    );


    await controller.loadAthletes();

  }




  @override
  void dispose() {

    controller.removeListener(_refresh);

    super.dispose();

  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(


      appBar: AppBar(

        title: const Text(
          'ورزشکاران',
        ),

        centerTitle: true,

      ),



      floatingActionButton:
          FloatingActionButton.extended(


        onPressed:
            openNewAthletePage,


        icon:
            const Icon(
              Icons.person_add,
            ),


        label:
            const Text(
              'ثبت ورزشکار',
            ),

      ),




      body: Padding(

        padding:
            const EdgeInsets.all(16),


        child: Column(

          children: [



            TextField(

              decoration:
                  const InputDecoration(

                hintText:
                    'جستجوی ورزشکار...',


                prefixIcon:
                    Icon(
                      Icons.search,
                    ),


                border:
                    OutlineInputBorder(),

              ),

            ),



            const SizedBox(
              height: 12,
            ),



            Row(

              children: [


                const Icon(
                  Icons.filter_alt,
                ),



                const SizedBox(
                  width: 8,
                ),



                const Text(
                  'فیلترها (به‌زودی)',
                ),


              ],

            ),




            const SizedBox(
              height: 20,
            ),




            Expanded(
              child: AthleteList(
                athletes: controller.athletes,
              ),
            ),


          ],

        ),

      ),

    );

  }

}