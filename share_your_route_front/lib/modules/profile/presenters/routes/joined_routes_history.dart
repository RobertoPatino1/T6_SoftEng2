import 'package:flutter/material.dart';

class JoinedRoutesHistory extends StatelessWidget {
  const JoinedRoutesHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rutas a las que te has unido'),
      ),
      body: ListView.builder(
        itemCount: 10, // Número de elementos de ejemplo
        itemBuilder: (context, index) {
          return Card(
            color: const Color.fromARGB(255, 230, 229, 229),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: const Icon(Icons.map),
              title: Text('Ruta ${index + 1}'),
              subtitle: const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Acción al seleccionar una ruta (puede redirigir a los detalles de la ruta)
              },
            ),
          );
        },
      ),
    );
  }
}
