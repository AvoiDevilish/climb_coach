import 'package:flutter/material.dart';

import '../../domain/models/session.dart';
import '../pages/session_detail_page.dart';

import 'session_card.dart';


class SessionList extends StatelessWidget {

  final List<Session> sessions;


  const SessionList({

    super.key,

    required this.sessions,

  });



  @override
  Widget build(BuildContext context) {


    return Column(

      children:

          sessions.map((session) {


        return SessionCard(

          title:
              session.title,


          time:
              '${session.startTime} تا ${session.endTime}',


          currentCount:
              0,


          capacity:
              session.capacity,


          allowMakeup:
              session.allowMakeup,



          onTap: () {


            Navigator.push(

              context,

              MaterialPageRoute(

                builder: (_) =>
                    SessionDetailPage(

                      session: session,

                    ),

              ),

            );


          },


        );


      }).toList(),

    );


  }

}