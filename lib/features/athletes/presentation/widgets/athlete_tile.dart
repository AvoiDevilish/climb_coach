import 'dart:io';

import 'package:flutter/material.dart';

import '../../domain/models/athlete.dart';

class AthleteTile extends StatelessWidget {
  final Athlete athlete;

  const AthleteTile({
    super.key,
    required this.athlete,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint(
      'ATHLETE TILE ID: ${athlete.id}',
    );
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey.shade300,
          backgroundImage: athlete.profileImage != null
              ? FileImage(
                  File(athlete.profileImage!),
                )
              : null,
          child: athlete.profileImage == null
              ? const Icon(Icons.person)
              : null,
        ),

        title: Text(
          '${athlete.firstName} ${athlete.lastName}',
        ),

        trailing: const Icon(Icons.chevron_right),

        onTap: () {
          Navigator.pushNamed(
            context,
            '/athlete/profile',
            arguments: athlete,
          );
        },
      ),
    );
  }
}