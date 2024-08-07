import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayuda'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Spacer(), // Añade espacio flexible
          // Imagen centrada
          Image.asset(
            'asset/images/help_screen_img.jpg',
            width: 500, // Ajusta el tamaño de la imagen según sea necesario
            height: 500,
            fit: BoxFit.contain,
          ),
          const Spacer(flex: 2), // Mayor espacio entre la imagen y las opciones
          // Opciones
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 230, 229, 229),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                _buildOption(context, Icons.travel_explore, 'Quiénes Somos'),
                _buildDivider(),
                _buildOption(
                  context,
                  Icons.description,
                  'Términos y Condiciones',
                ),
                _buildDivider(),
                _buildOption(context, Icons.lock, 'Licencia'),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ), // Espacio entre las opciones y el texto de propiedad
          Text(
            '© 2024 Share Your Route LLC™',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20), // Espacio inferior
        ],
      ),
    );
  }

  Widget _buildOption(BuildContext context, IconData icon, String title) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Acción al tocar la opción
        },
        splashColor: Colors.grey,
        child: ListTile(
          leading: Icon(icon),
          title: Text(title),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      indent: 0,
      endIndent: 0,
    );
  }
}
