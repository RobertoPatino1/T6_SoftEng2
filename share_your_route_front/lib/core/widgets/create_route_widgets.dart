import 'package:flutter/material.dart';
import 'package:share_your_route_front/core/constants/colors.dart';

Widget buildRouteNameField(
  BuildContext context,
  String routeName,
  Function(String) onRouteNameChanged,
) {
  final theme = Theme.of(context);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Nombre de la Ruta',
        style: theme.textTheme.headlineSmall,
      ),
      const SizedBox(height: 8),
      TextField(
        decoration: InputDecoration(
          hintStyle: theme.inputDecorationTheme.hintStyle,
          labelStyle: theme.inputDecorationTheme.labelStyle,
          enabledBorder: theme.inputDecorationTheme.enabledBorder,
          focusedBorder: theme.inputDecorationTheme.focusedBorder,
          fillColor: theme.inputDecorationTheme.fillColor,
          filled: theme.inputDecorationTheme.filled,
        ),
        style: theme.textTheme.bodyLarge,
        onChanged: onRouteNameChanged,
      ),
    ],
  );
}

Widget buildRouteDescriptionField(
  BuildContext context,
  String routeDescription,
  Function(String) onRouteDescriptionChanged,
) {
  final theme = Theme.of(context);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Descripción de la Ruta',
        style: theme.textTheme.headlineSmall,
      ),
      const SizedBox(height: 8),
      TextField(
        decoration: InputDecoration(
          hintStyle: theme.inputDecorationTheme.hintStyle,
          labelStyle: theme.inputDecorationTheme.labelStyle,
          enabledBorder: theme.inputDecorationTheme.enabledBorder,
          focusedBorder: theme.inputDecorationTheme.focusedBorder,
          fillColor: theme.inputDecorationTheme.fillColor,
          filled: theme.inputDecorationTheme.filled,
        ),
        style: theme.textTheme.bodyLarge,
        onChanged: onRouteDescriptionChanged,
      ),
    ],
  );
}

Widget buildLabeledControl(BuildContext context, String label, Widget control) {
  final theme = Theme.of(context);

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: theme.textTheme.headlineSmall),
      control,
    ],
  );
}

Widget buildNumberChanger(
    BuildContext context, int value, Function(int) onChanged,) {
  final theme = Theme.of(context);

  return Row(
    children: [
      IconButton(
        icon: const Icon(Icons.remove, color: yellowAccentColor),
        onPressed: () => onChanged(value - 1),
      ),
      Text(
        '$value',
        style: theme.textTheme.headlineSmall,
      ),
      IconButton(
        icon: const Icon(Icons.add, color: yellowAccentColor),
        onPressed: () => onChanged(value + 1),
      ),
    ],
  );
}

Widget buildRangeSlider(
  BuildContext context,
  double value,
  Function(double) onChanged,
) {
  // Añadido contexto como parámetro
  final theme = Theme.of(context); // Corrección: usar el contexto correcto

  return Slider(
    value: value,
    min: 1,
    max: 10,
    divisions: 9,
    label: value.round().toString(),
    onChanged: onChanged,
    thumbColor: yellowAccentColor,
    activeColor: yellowAccentColor, // Usando color secundario del tema
    inactiveColor: theme.disabledColor,
  );
}

Widget buildDropdown(
    BuildContext context, String value, Function(String) onChanged,) {
  // Añadido contexto como parámetro
  final theme = Theme.of(context); // Corrección: usar el contexto correcto

  return DropdownButton<String>(
    dropdownColor:
        theme.colorScheme.surface, // Usando color de superficie del tema
    value: value,
    onChanged: (String? newValue) {
      if (newValue != null) {
        onChanged(newValue);
      }
    },
    items: <String>['Sonido 1', 'Sonido 2', 'Sonido 3']
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value, style: theme.textTheme.headlineSmall),
      );
    }).toList(),
  );
}
