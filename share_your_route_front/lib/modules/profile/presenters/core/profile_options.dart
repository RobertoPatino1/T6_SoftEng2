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
              BorderRadius? borderRadius;
              if (option == options.first) {
                borderRadius =
                    const BorderRadius.vertical(top: Radius.circular(15));
              } else if (option == options[1]) {
                borderRadius =
                    const BorderRadius.vertical(bottom: Radius.circular(15));
              }

              return Column(
                children: [
                  Material(
                    color: Colors.transparent,
                    borderRadius: borderRadius,
                    clipBehavior: Clip
                        .antiAlias, // Asegura que el splash effect respete los bordes
                    child: InkWell(
                      onTap: () async {
                        await Future.delayed(const Duration(milliseconds: 100));
                        option.onTap();
                      },
                      splashColor: Colors.grey,
                      child: ListTile(
                        leading: Icon(option.icon),
                        title: Text(option.title),
                        trailing: const Icon(Icons.chevron_right),
                      ),
                    ),
                  ),
                  if (option != options[1])
                    const Divider(
                      height: 1,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                    ),
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
              BorderRadius? borderRadius;
              if (option == options.first) {
                borderRadius =
                    const BorderRadius.vertical(top: Radius.circular(15));
              } else if (option == options.last) {
                borderRadius =
                    const BorderRadius.vertical(bottom: Radius.circular(15));
              }

              return Column(
                children: [
                  Material(
                    color: Colors.transparent,
                    borderRadius: borderRadius,
                    clipBehavior: Clip
                        .antiAlias, // Asegura que el splash effect respete los bordes
                    child: InkWell(
                      onTap: () async {
                        await Future.delayed(
                          const Duration(
                            milliseconds: 100,
                          ),
                        );
                        option.onTap();
                      },
                      splashColor: Colors.grey,
                      child: ListTile(
                        leading: Icon(option.icon),
                        title: Text(option.title),
                        trailing: option.title != 'Cerrar sesión'
                            ? const Icon(Icons.chevron_right)
                            : null,
                      ),
                    ),
                  ),
                  if (option != options.last)
                    const Divider(
                      height: 1,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                    ),
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
