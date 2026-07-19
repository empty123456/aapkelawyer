import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const CircleAvatar(
          radius: 62,
          backgroundColor: Color(0xFFF0F0F0),
          child: Icon(Icons.person, color: Color(0xFFAAAAAA), size: 88),
        ),
        Positioned(
          right: 0,
          bottom: 12,
          child: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: kBrown,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
            ),
            child: const Icon(Icons.edit_square, color: Colors.white, size: 22),
          ),
        ),
      ],
    );
  }
}
