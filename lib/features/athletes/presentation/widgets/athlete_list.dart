import 'package:flutter/material.dart';

import 'athlete_tile.dart';
import '../../domain/models/athlete.dart';


class AthleteList extends StatelessWidget {

  const AthleteList({
    super.key,
    required this.athletes,
  });


  final List<Athlete> athletes;



  @override
  Widget build(BuildContext context) {


    if (athletes.isEmpty) {

      return const Center(

        child: Text(
          'هنوز ورزشکاری ثبت نشده است.',
        ),

      );

    }



    return ListView.separated(

      itemCount:
          athletes.length,


      separatorBuilder:
          (context, index) =>
              const SizedBox(
                height: 8,
              ),


      itemBuilder:
          (context, index) {


        final athlete =
            athletes[index];


        return AthleteTile(
          athlete: athlete,
        );


      },

    );

  }

}