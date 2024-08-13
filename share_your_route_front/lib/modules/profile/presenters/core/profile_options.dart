import 'package:flutter/material.dart';

class ProfileOptions extends StatelessWidget {
  final List<OptionGroup> optionGroups;

  const ProfileOptions({super.key, required this.optionGroups});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: optionGroups.map((group) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 230, 229, 229),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: group.options.map((option) {
              BorderRadius? borderRadius;
              if (group.options.length == 1) {
                // Si solo hay una opción en el grupo, todos los bordes son redondeados
                borderRadius = BorderRadius.circular(15);
              } else if (option == group.options.first) {
                // Si es la primera opción, redondear solo los bordes superiores
                borderRadius =
                    const BorderRadius.vertical(top: Radius.circular(15));
              } else if (option == group.options.last) {
                // Si es la última opción, redondear solo los bordes inferiores
                borderRadius =
                    const BorderRadius.vertical(bottom: Radius.circular(15));
              }

              return Column(
                children: [
                  Material(
                    color: option.backgroundColor ?? Colors.transparent,
                    borderRadius: borderRadius,
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () async {
                        await Future.delayed(const Duration(milliseconds: 100));
                        option.onTap();
                      },
                      splashColor: Colors.grey,
                      child: ListTile(
                        leading: Icon(option.icon,
                            color: option.textColor ?? Colors.black,),
                        title: Text(
                          option.title,
                          style: TextStyle(
                              color: option.textColor ?? Colors.black,),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: option.textColor ?? Colors.black,
                        ),
                      ),
                    ),
                  ),
                  if (option != group.options.last)
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
        );
      }).toList(),
    );
  }
}

class OptionGroup {
  final List<OptionItem> options;

  OptionGroup({required this.options});
}

class OptionItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? textColor;

  OptionItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.backgroundColor,
    this.textColor,
  });
}
