import 'dart:io';

import 'package:flutter/material.dart';

class AthleteAvatarPicker extends StatelessWidget {
  const AthleteAvatarPicker({
    super.key,
    required this.imagePath,
    required this.onTap,
  });

  final String? imagePath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: CircleAvatar(
        radius: 48,

        backgroundColor: Colors.grey.shade300,

        child: imagePath == null
            ? const Icon(
                Icons.add_a_photo,
                size: 32,
              )
            : ClipOval(
                child: Image.file(
                  File(imagePath!),
                  width: 96,
                  height: 96,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }
}