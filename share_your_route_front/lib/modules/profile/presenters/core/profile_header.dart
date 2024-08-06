import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String imagePath;
  final String name;
  final String email;

  const ProfileHeader({
    super.key,
    required this.imagePath,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage(imagePath),
        ),
        const SizedBox(height: 10),
        Text(
          name,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          email,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }
}
