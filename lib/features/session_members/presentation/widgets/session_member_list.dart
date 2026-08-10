import 'package:flutter/material.dart';

import '../controllers/session_member_controller.dart';
import '../../domain/models/session_member_detail.dart';


class SessionMemberList extends StatefulWidget {

  final String sessionId;
  final int capacity;


  const SessionMemberList({

    super.key,

    required this.sessionId,

    required this.capacity,

  });


  @override
  State<SessionMemberList> createState() =>
      _SessionMemberListState();

}



class _SessionMemberListState
    extends State<SessionMemberList> {


  final SessionMemberController controller =
      SessionMemberController();



  int get availableCapacity {

    return widget.capacity -
        controller.members.length;

  }



  @override
  void initState() {

    super.initState();


    controller.loadMembers(
      widget.sessionId,
    );


    controller.addListener(
      refresh,
    );

  }



  void refresh() {

    if (mounted) {

      setState(() {});

    }

  }



  @override
  void dispose() {

    controller.removeListener(
      refresh,
    );


    super.dispose();

  }



  @override
  Widget build(BuildContext context) {


    return Column(

      children: [


        Padding(

          padding:
              const EdgeInsets.all(8),


          child: Text(

            'ظرفیت باقی‌مانده: $availableCapacity نفر',

          ),

        ),



        Expanded(

          child:

          controller.members.isEmpty


          ?

          const Center(

            child: Text(
              'هنوز ورزشکاری به این سانس اضافه نشده',
            ),

          )


          :

          ListView.builder(

            itemCount:
                controller.members.length,


            itemBuilder:
                (context,index) {


              final SessionMemberDetail member =
                  controller.members[index];



              return Card(

                child: ListTile(

                  leading:
                      const Icon(
                        Icons.person,
                      ),



                  title:
                      Text(
                        member.fullName,
                      ),



                  subtitle:
                      _MemberTypeBadge(
                        type:
                            member.memberType,
                      ),

                ),

              );


            },

          ),

        ),

      ],

    );

  }

}




class _MemberTypeBadge extends StatelessWidget {


  final String type;


  const _MemberTypeBadge({

    required this.type,

  });



  @override
  Widget build(BuildContext context) {


    String text;

    Color color;



    switch(type) {


      case 'MAKEUP':

        text = 'جبرانی';

        color = Colors.orange;

        break;



      case 'GUEST':

        text = 'مهمان';

        color = Colors.blue;

        break;



      default:

        text = 'عضو عادی';

        color = Colors.green;

    }



    return Container(

      margin:
          const EdgeInsets.only(
            top: 6,
          ),


      padding:
          const EdgeInsets.symmetric(

            horizontal: 10,

            vertical: 4,

          ),



      decoration:

          BoxDecoration(

            color:
                color.withValues(
                  alpha: 0.15,
                ),


            borderRadius:
                BorderRadius.circular(
                  20,
                ),

          ),



      child:

          Text(

            text,


            style:

                TextStyle(

                  color:
                      color,


                  fontWeight:
                      FontWeight.bold,

                ),

          ),

    );

  }

}