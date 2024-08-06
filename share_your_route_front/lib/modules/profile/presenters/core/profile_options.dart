import 'package:flutter/material.dart';

class ProfileOptions extends StatelessWidget {
  final List<OptionItem> options;

  const ProfileOptions({super.key, required this.options});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: options.map((option) {
        return ListTile(
          leading: Icon(option.icon),
          title: Text(option.title),
          onTap: () async {
            await option
                .onTap(); // Ejecuta el callback como una función asíncrona
          },
        );
      }).toList(),
    );
  }
}

class OptionItem {
  final IconData icon;
  final String title;
  final Future<void> Function()
      onTap; // Cambia a un Future<void> para soportar async

  OptionItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}
