import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String backgroundImagePath;
  final String imagePath;
  final String name;
  final String email;

  const ProfileHeader({
    super.key,
    required this.backgroundImagePath,
    required this.imagePath,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Imagen de fondo
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(backgroundImagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Foto de perfil con borde blanco
            Positioned(
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 5,
                  ), // TODO: CHANGE THIS WITH THE APPLIED THEME
                ),
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage(imagePath),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Column(
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              email,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
