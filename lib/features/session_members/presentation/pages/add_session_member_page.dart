import 'package:flutter/material.dart';

import '../../../athletes/presentation/controllers/athlete_controller.dart';

import '../../domain/models/session_member.dart';

import '../controllers/session_member_controller.dart';


class AddSessionMemberPage extends StatefulWidget {

  final String sessionId;

  const AddSessionMemberPage({
    super.key,
    required this.sessionId,
  });


  @override
  State<AddSessionMemberPage> createState() =>
      _AddSessionMemberPageState();

}



class _AddSessionMemberPageState
    extends State<AddSessionMemberPage> {


  final AthleteController athleteController =
      AthleteController();


  final SessionMemberController memberController =
      SessionMemberController();



  @override
  void initState() {

    super.initState();

    athleteController.loadAthletes();

  }



  Future addMember(
      String athleteId,
  ) async {


    final member = SessionMember(

      id: DateTime.now()
          .millisecondsSinceEpoch
          .toString(),

      sessionId: widget.sessionId,

      athleteId: athleteId,

    );


    await memberController.addMember(
      member,
    );


    if(mounted){

      Navigator.pop(context);

    }

  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(

        title:
            const Text(
              'افزودن ورزشکار به سانس',
            ),

      ),



      body: AnimatedBuilder(

        animation: athleteController,

        builder: (context,child){


          final athletes =
              athleteController.athletes;



          if(athletes.isEmpty){

            return const Center(

              child:
                  Text(
                    'ورزشکاری ثبت نشده',
                  ),

            );

          }



          return ListView.builder(

            itemCount:
                athletes.length,


            itemBuilder:
                (context,index){


              final athlete =
                  athletes[index];



              return Card(

                child: ListTile(


                  leading:
                      const Icon(
                        Icons.person,
                      ),



                  title:
                      Text(
                        '${athlete.firstName} ${athlete.lastName}',
                      ),



                  trailing:
                      ElevatedButton(

                        onPressed: (){

                          addMember(
                            athlete.id!,
                          );

                        },


                        child:
                            const Text(
                              'افزودن',
                            ),

                      ),

                ),

              );


            },

          );


        },

      ),

    );


  }

}