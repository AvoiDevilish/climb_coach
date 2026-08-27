import 'package:flutter/material.dart';

import '../../domain/models/assessment.dart';
import '../../domain/models/assessment_item.dart';
import '../../data/repositories/assessment_repository.dart';

import '../../../movements/data/repositories/movement_repository.dart';
import '../../../movements/domain/models/movement.dart';


class AssessmentDetailPage extends StatefulWidget {

  const AssessmentDetailPage({
    super.key,
  });


  @override
  State<AssessmentDetailPage> createState() =>
      _AssessmentDetailPageState();

}



class _AssessmentDetailPageState
    extends State<AssessmentDetailPage> {


  final AssessmentRepository _assessmentRepository =
      AssessmentRepository();


  final MovementRepository _movementRepository =
      MovementRepository();



  Assessment? assessment;

  List<Movement> movements = [];

  bool loading = true;



  @override
  void didChangeDependencies() {

    super.didChangeDependencies();


    if (assessment != null) {
      return;
    }


    assessment =
        ModalRoute.of(context)!
            .settings
            .arguments as Assessment;


    _loadMovements();

  }




  Future<void> _loadMovements() async {


    final items =
        _assessmentRepository.getItems(
          assessment!.id!,
        );


    final result = <Movement>[];


    for (final AssessmentItem item in items) {

      final movement =
          await _movementRepository.getById(
            item.movementId,
          );


      if (movement != null) {

        result.add(
          movement,
        );

      }

    }



    if (!mounted) {
      return;
    }


    setState(() {

      movements = result;

      loading = false;

    });

  }




  Future<void> _startAssessment() async {
    final athleteId = await Navigator.pushNamed<String>(
      context,
      '/assessment/athlete-selector',
      arguments: assessment,
    );

    if (!mounted || athleteId == null || athleteId.trim().isEmpty) {
      return;
    }

    final result = await Navigator.pushNamed(
      context,
      '/assessment/execution',
      arguments: {
        'assessment': assessment,
        'athleteId': athleteId,
      },
    );

    if (!mounted || result == null) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('نتیجه آزمون ثبت شد.')),
    );
  }




  @override
  Widget build(BuildContext context) {


    if (loading) {

      return const Scaffold(

        body: Center(
          child:
              CircularProgressIndicator(),
        ),

      );

    }



    return Scaffold(

      appBar: AppBar(

        title:
            Text(
              assessment!.title,
            ),

      ),



      body:

          Padding(

            padding:
                const EdgeInsets.all(16),


            child:

            Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,


              children: [


                Text(

                  assessment!.description,

                  style:
                      Theme.of(context)
                          .textTheme
                          .bodyLarge,

                ),



                const SizedBox(
                  height: 24,
                ),



                const Text(

                  'حرکت‌های آزمون',

                  style: TextStyle(

                    fontSize: 18,

                    fontWeight:
                        FontWeight.bold,

                  ),

                ),



                const SizedBox(
                  height: 12,
                ),



                Expanded(

                  child:

                  ListView.builder(

                    itemCount:
                        movements.length,


                    itemBuilder:
                        (context,index){


                      final movement =
                          movements[index];


                      return Card(

                        child:
                            ListTile(

                          leading:
                              const Icon(
                                Icons.fitness_center,
                              ),


                          title:
                              Text(
                                movement.name,
                              ),


                          subtitle:
                              Text(
                                '${movement.measurementType} - ${movement.measurementUnit}',
                              ),

                        ),

                      );


                    },

                  ),

                ),



                SizedBox(

                  width:
                      double.infinity,


                  child:
                      ElevatedButton(

                    onPressed:
                        _startAssessment,


                    child:
                        const Text(
                          'شروع اجرای آزمون',
                        ),

                  ),

                ),



              ],

            ),

          ),

    );

  }

}