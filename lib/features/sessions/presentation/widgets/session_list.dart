import 'package:flutter/material.dart';

import 'session_card.dart';



class SessionList extends StatelessWidget {

  final List<Map<String, dynamic>> sessions;


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
              session["title"] as String,


          time:
              session["time"] as String,


          currentCount:
              session["count"] as int,


          capacity:
              session["capacity"] as int,


          allowMakeup:
              session["makeup"] as bool,


        );


      }).toList(),

    );

  }

}