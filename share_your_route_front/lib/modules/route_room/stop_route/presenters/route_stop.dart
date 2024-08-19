import 'package:flutter/material.dart';

class RouteStop extends StatelessWidget {
  final String stopName; // Añadido para el nombre de la parada

  const RouteStop({
    super.key,
    required this.stopName, // Añadido para el nombre de la parada
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alerta de Proximidad'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Estás en la parada $stopName. Sigue las indicaciones de tu guía!',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 18, // Ajusta el tamaño según tus necesidades
                  fontWeight: FontWeight.bold, // Puedes ajustar el peso también
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
