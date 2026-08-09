import 'package:flutter/material.dart';

import '../pages/session_detail_page.dart';

import '../../domain/models/session.dart';

import '../../../../core/calendar/calendar_helper.dart';
import '../../../../core/utils/number_helper.dart';

class WeekSessionView extends StatelessWidget {

  final DateTime selectedDate;

  final List<Session> sessions;

  const WeekSessionView({
    super.key,

    required this.selectedDate,

    required this.sessions,
  });


  List<DateTime> get days {

    return List.generate(
      7,
      (index) => selectedDate.add(
        Duration(days: index),
      ),
    );

  }


  String weekdayName(int day) {

    switch(day) {

      case DateTime.saturday:
        return 'شنبه';

      case DateTime.sunday:
        return 'یکشنبه';

      case DateTime.monday:
        return 'دوشنبه';

      case DateTime.tuesday:
        return 'سه‌شنبه';

      case DateTime.wednesday:
        return 'چهارشنبه';

      case DateTime.thursday:
        return 'پنجشنبه';

      case DateTime.friday:
        return 'جمعه';

      default:
        return '';

    }

  }



  @override
  Widget build(BuildContext context) {

    return ListView.builder(

      itemCount: days.length,


      itemBuilder: (context,index){

        final day = days[index];

        final daySessions = sessions.where((session) {

        if (session.isRecurring) {

            return session.weekday == day.weekday;

        }


        return CalendarHelper.normalizeDate(
              session.date,
            ) ==
            CalendarHelper.normalizeDate(
              CalendarHelper.toPersianDate(day),
            );

        }).toList();

        return Card(

          child: ExpansionTile(

            title: Text(

              '${weekdayName(day.weekday)} '
              '${NumberHelper.toPersian(
                CalendarHelper.toPersianDate(day),
              )}',

            ),


            children:

                daySessions.isEmpty

                    ?

                    [

                    const Padding(

                        padding:
                            EdgeInsets.all(16),

                        child:

                        Text(
                        'سانسی برای این روز ثبت نشده',
                        ),

                    )

                    ]

                    :

                    daySessions.map((session) {

                    return ListTile(

                      title:
                          Text(session.title),

                      subtitle:
                          Text(
                            '${session.startTime} تا ${session.endTime}',
                          ),

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

          ),

        );


      },

    );

  }

}