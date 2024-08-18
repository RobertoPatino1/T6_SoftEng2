import 'package:flutter/material.dart';
import 'package:share_your_route_front/core/constants/colors.dart';
import 'package:share_your_route_front/modules/shared/ui/ui_utils.dart';

const TextStyle labelTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: Colors.grey,
);

const TextStyle boldlabelTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  // color: Color.fromRGBO(37, 60, 89, 1),
);

const TextStyle titlelabelTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w700,
);

Widget buildRouteNameField(
  BuildContext context,
  String routeName,
  Function(String) onRouteNameChanged,
) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Nombre de la Ruta', style: titlelabelTextStyle),
      const SizedBox(height: 8),
      TextField(
        decoration: buildInputDecoration(
          hintText: "Ingrese el nombre de la ruta",
        ).copyWith(
          hintStyle: TextStyle(
            color: isDarkMode ? Colors.white.withOpacity(0.7) : Colors.grey,
          ),
          fillColor: isDarkMode ? Colors.black54 : Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: isDarkMode ? Colors.white : Colors.black),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: isDarkMode ? Colors.white : Colors.black),
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
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
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Descripción de la Ruta', style: titlelabelTextStyle),
      const SizedBox(height: 8),
      TextField(
        decoration: buildInputDecoration(
          hintText: "Ingrese la descripción de la ruta",
        ).copyWith(
          hintStyle: TextStyle(
            color: isDarkMode ? Colors.white.withOpacity(0.7) : Colors.grey,
          ),
          fillColor: isDarkMode ? Colors.black54 : Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: isDarkMode ? Colors.white : Colors.black),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: isDarkMode ? Colors.white : Colors.black),
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        onChanged: onRouteDescriptionChanged,
      ),
    ],
  );
}

Widget buildLabeledControl(String label, Widget control) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: titlelabelTextStyle),
      control,
    ],
  );
}

Widget buildNumberChanger(int value, Function(int) onChanged) {
  return Row(
    children: [
      IconButton(
        icon: const Icon(Icons.remove, color: darkColorSchemeOnSecondary),
        onPressed: () => onChanged(value - 1),
      ),
      Text('$value', style: labelTextStyle),
      IconButton(
        icon: const Icon(Icons.add, color: darkColorSchemeOnSecondary),
        onPressed: () => onChanged(value + 1),
      ),
    ],
  );
}

Widget buildRangeSlider(double value, Function(double) onChanged) {
  return Slider(
    value: value,
    min: 1,
    max: 10,
    divisions: 9,
    label: value.round().toString(),
    onChanged: onChanged,
    thumbColor: yellowAccentColor,
    secondaryActiveColor: darkColorSchemeOnSecondary,
    activeColor: const Color.fromRGBO(191, 141, 48, 1),
    inactiveColor: const Color.fromARGB(255, 137, 137, 137),
  );
}

Widget buildDropdown(String value, Function(String) onChanged) {
  return DropdownButton<String>(
    dropdownColor: const Color.fromRGBO(241, 241, 241, 1),
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
        child: Text(value, style: labelTextStyle),
      );
    }).toList(),
  );
}
