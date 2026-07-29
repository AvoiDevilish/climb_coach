import 'package:flutter/material.dart';

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
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Text('هنوز ورزشکاری ثبت نشده است.'),
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: athletes.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final athlete = athletes[index];

        return Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Text(
                athlete.firstName.isNotEmpty
                    ? athlete.firstName[0]
                    : '?',
              ),
            ),
            title: Text(
              '${athlete.firstName} ${athlete.lastName}',
            ),
           
          ),
        );
      },
    );
  }
}