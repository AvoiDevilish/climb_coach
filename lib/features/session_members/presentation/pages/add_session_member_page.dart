import 'package:flutter/material.dart';

import '../../../athletes/presentation/controllers/athlete_controller.dart';

import '../../domain/models/session_member.dart';
import '../../domain/constants/session_member_types.dart';

import '../controllers/session_member_controller.dart';


class AddSessionMemberPage extends StatefulWidget {

  final String sessionId;

  final int capacity;

  const AddSessionMemberPage({
    super.key,
    required this.sessionId,
    required this.capacity,
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


  String selectedMemberType =
      SessionMemberTypes.normal;


  final Map<String, String> memberTypeLabels = {
    SessionMemberTypes.normal: 'عضو عادی',
    SessionMemberTypes.makeup: 'جبرانی',
    SessionMemberTypes.guest: 'مهمان',
    SessionMemberTypes.trial: 'تستی',
    SessionMemberTypes.private: 'خصوصی',
  };


  bool isSaving = false;


  int get availableCapacity {

    return widget.capacity -
        memberController.members.length;

  }


  @override
  void initState() {

    super.initState();

    athleteController.loadAthletes();

    memberController.loadMembers(
      widget.sessionId,
    );

  }


  Future addMember(
      String athleteId,
  ) async {

    if (availableCapacity <= 0) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'ظرفیت این سانس تکمیل است',
          ),
        ),
      );

      return;

    }

    setState(() {
      isSaving = true;
    });

    final member = SessionMember(

      id: DateTime.now()
          .millisecondsSinceEpoch
          .toString(),

      sessionId: widget.sessionId,

      athleteId: athleteId,

      memberType: selectedMemberType,

    );

    try {

      await memberController.addMember(
        member,
      );

      if (mounted) {

        Navigator.pop(context);

      }

    } catch (e) {

      debugPrint(
        'ADD SESSION MEMBER ERROR: $e',
      );

      if (mounted) {

        setState(() {
          isSaving = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'این ورزشکار قبلاً به این سانس اضافه شده',
            ),
          ),
        );

      }

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

        animation: Listenable.merge(
          [
            athleteController,
            memberController,
          ],
        ),

        builder: (context,child){


          final existingAthleteIds =
              memberController.members
                  .map(
                    (member) => member.athleteId,
                  )
                  .toSet();


          final availableAthletes =
              athleteController.athletes
                  .where(
                    (athlete) => !existingAthleteIds
                        .contains(athlete.id),
                  )
                  .toList();


          return Column(

            children: [

              Padding(

                padding:
                    const EdgeInsets.all(12),

                child: Column(

                  children: [

                    Text(
                      'ظرفیت باقی‌مانده: $availableCapacity نفر',
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    DropdownButtonFormField<String>(

                      initialValue:
                          selectedMemberType,

                      decoration:
                          const InputDecoration(
                        labelText: 'نوع عضویت',
                        border:
                            OutlineInputBorder(),
                      ),

                      items: memberTypeLabels
                          .entries
                          .map(
                        (entry) {
                          return DropdownMenuItem<
                              String>(
                            value: entry.key,
                            child: Text(
                              entry.value,
                            ),
                          );
                        },
                      ).toList(),

                      onChanged: (value) {

                        if (value == null) return;

                        setState(() {
                          selectedMemberType =
                              value;
                        });

                      },

                    ),

                  ],

                ),

              ),

              Expanded(

                child: availableAthletes.isEmpty

                    ? const Center(

                        child:
                            Text(
                              'همه‌ی ورزشکاران قبلاً به این سانس اضافه شده‌اند',
                            ),

                      )

                    : ListView.builder(

                        itemCount:
                            availableAthletes.length,


                        itemBuilder:
                            (context,index){


                          final athlete =
                              availableAthletes[index];


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

                                    onPressed: isSaving ||
                                            availableCapacity <= 0
                                        ? null
                                        : (){

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

                      ),

              ),

            ],

          );


        },

      ),

    );


  }

}
