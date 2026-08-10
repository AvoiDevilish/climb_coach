import 'package:flutter/material.dart';

import '../../domain/models/session.dart';
import '../../../session_members/presentation/widgets/session_member_list.dart';


class SessionDetailPage extends StatelessWidget {

  final Session session;


  const SessionDetailPage({
    super.key,
    required this.session,
  });



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text(
          session.title,
        ),

      ),


      body: Padding(

        padding:
            const EdgeInsets.all(16),


        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,


          children: [


            Text(

              session.title,

              style:
                  const TextStyle(

                fontSize: 22,

                fontWeight:
                    FontWeight.bold,

              ),

            ),



            const SizedBox(
              height: 12,
            ),



            Text(

              '${session.startTime} تا ${session.endTime}',

            ),



            const SizedBox(
              height: 12,
            ),



            Text(

              'ظرفیت: ${session.capacity}',

            ),



            const SizedBox(
              height: 24,
            ),



            const Text(

              'ورزشکاران',

              style:
                  TextStyle(

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
                session.id == null

                    ? const Center(
                        child: Text(
                            'شناسه سانس نامعتبر است',
                        ),
                        )

                    : SessionMemberList(
                        sessionId: session.id!,
                        capacity: session.capacity,
                      ),

            ),


          ],

        ),

      ),

    );

  }

}