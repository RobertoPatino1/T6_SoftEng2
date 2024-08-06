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
          onTap: option.onTap,
        );
      }).toList(),
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
