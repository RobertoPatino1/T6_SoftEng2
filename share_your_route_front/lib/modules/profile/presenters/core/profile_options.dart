import 'package:flutter/material.dart';
import 'package:share_your_route_front/core/constants/colors.dart';

class ProfileOptions extends StatelessWidget {
  final List<OptionGroup> optionGroups;

  const ProfileOptions({super.key, required this.optionGroups});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDarkMode ? darkButtonBackgroundColor : lightButtonBackgroundColor;
    final textColor =
        isDarkMode ? Theme.of(context).colorScheme.onSurface : Colors.black;

    return Column(
      children: optionGroups.map((group) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: group.options.map((option) {
              BorderRadius? borderRadius;
              if (group.options.length == 1) {
                borderRadius = BorderRadius.circular(15);
              } else if (option == group.options.first) {
                borderRadius =
                    const BorderRadius.vertical(top: Radius.circular(15));
              } else if (option == group.options.last) {
                borderRadius =
                    const BorderRadius.vertical(bottom: Radius.circular(15));
              }

              return Column(
                children: [
                  Material(
                    color: backgroundColor,
                    borderRadius: borderRadius,
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () async {
                        await Future.delayed(const Duration(milliseconds: 100));
                        option.onTap();
                      },
                      splashColor: Colors.grey,
                      child: ListTile(
                        leading: Icon(option.icon, color: textColor),
                        title: Text(
                          option.title,
                          style: TextStyle(color: textColor),
                        ),
                        trailing: Icon(Icons.chevron_right, color: textColor),
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
