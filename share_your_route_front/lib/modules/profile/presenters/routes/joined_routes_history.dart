import 'package:flutter/material.dart';
import 'package:share_your_route_front/core/constants/colors.dart';
import 'package:share_your_route_front/modules/shared/ui/custom_app_bar.dart';

class JoinedRoutesHistory extends StatelessWidget {
  const JoinedRoutesHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardBackgroundColor =
        isDarkMode ? darkButtonBackgroundColor : lightButtonBackgroundColor;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      appBar: const CustomAppBar(title: "Rutas Unidas"),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: 10, // Número de elementos de ejemplo
          itemBuilder: (context, index) {
            return Card(
              color: cardBackgroundColor,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              clipBehavior: Clip
                  .antiAlias, // Asegura que el efecto respete los bordes redondeados
              child: ListTile(
                leading: Icon(Icons.map, color: textColor),
                title: Text(
                  'Ruta ${index + 1}',
                  style: TextStyle(color: textColor),
                ),
                subtitle: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  style: TextStyle(color: textColor.withOpacity(0.7)),
                ),
                trailing: Icon(Icons.chevron_right, color: textColor),
                onTap: () {
                  // Acción al seleccionar una ruta (puede redirigir a los detalles de la ruta)
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
