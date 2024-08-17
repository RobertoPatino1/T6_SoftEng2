import 'package:flutter/material.dart';
import 'package:share_your_route_front/core/constants/colors.dart';

class ProfileHeader extends StatelessWidget {
  final String backgroundImagePath;
  final String imagePath;
  final String name;
  final String email;
  final String bio;

  const ProfileHeader({
    super.key,
    required this.backgroundImagePath,
    required this.imagePath,
    required this.name,
    required this.email,
    required this.bio,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final nameColor = isDarkMode ? Colors.white : Colors.black;
    final bioBackgroundColor =
        isDarkMode ? darkButtonBackgroundColor : lightButtonBackgroundColor;
    final bioTextColor = isDarkMode ? Colors.white : Colors.black;
    final bioBorderColor = isDarkMode ? Colors.white : Colors.black;
    final emailTextColor = isDarkMode ? Colors.grey : Colors.black;

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(backgroundImagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 5,
                  ),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              children: [
                Text(
                  name.split(" ").take(2).join(" "),
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: nameColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (name.split(" ").length > 2)
                  Text(
                    name.split(" ").skip(2).join(" "),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: nameColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          email,
          style: TextStyle(
            fontSize: 16,
            color: emailTextColor,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: bioBackgroundColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: bioBorderColor,
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              Text(
                "Acerca de mi:",
                style: TextStyle(
                  fontSize: 15,
                  color: bioTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                bio,
                style: TextStyle(
                  fontSize: 12,
                  color: bioTextColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
