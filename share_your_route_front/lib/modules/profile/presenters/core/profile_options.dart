import 'package:flutter/material.dart';

class ProfileOptions extends StatelessWidget {
  final List<OptionItem> options;

  const ProfileOptions({super.key, required this.options});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 230, 229, 229),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: options.take(2).map((option) {
              return Column(
                children: [
                  ListTile(
                    leading: Icon(option.icon),
                    title: Text(option.title),
                    trailing: const Icon(Icons.chevron_right), // Flecha
                    onTap: option.onTap,
                  ),
                  if (option != options[1]) const Divider(),
                ],
              );
            }).toList(),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 230, 229, 229),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: options.skip(2).map((option) {
              return Column(
                children: [
                  ListTile(
                    leading: Icon(option.icon),
                    title: Text(option.title),
                    trailing: option.title != 'Cerrar sesión'
                        ? const Icon(Icons.chevron_right)
                        : null, // Flecha o nada si es "Cerrar sesión"
                    onTap: option.onTap,
                  ),
                  if (option != options.last) const Divider(),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class OptionItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  OptionItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}
