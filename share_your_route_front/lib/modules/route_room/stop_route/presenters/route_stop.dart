import 'package:flutter/material.dart';

class RouteStop extends StatelessWidget {
  final String directions;
  final String distance;

  const RouteStop({
    Key? key,
    required this.directions,
    required this.distance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alerta de Proximidad'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '¡Estás cerca de tu destino!',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'Distancia restante: $distance',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'Instrucciones: $directions',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Regresa a la página anterior
              },
              child: Text('Regresar'),
            ),
          ],
        ),
      ),
    );
  }
}