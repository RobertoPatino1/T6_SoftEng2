import 'package:flutter/material.dart';
import 'package:share_your_route_front/core/constants/urls.dart';
import 'package:share_your_route_front/modules/shared/ui/custom_app_bar.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Información"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.asset(
                logoURL,
                width: double.infinity,
                height: 150,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              const Text(
                'Sobre Share Your Route',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Share Your Route es una aplicación diseñada para mejorar la experiencia de los turistas en Ecuador, proporcionando a las agencias de viajes herramientas para gestionar y coordinar mejor sus tours. La app facilita la comunicación en tiempo real entre guías y turistas, evita problemas como retrasos y pérdidas, y ofrece recomendaciones personalizadas basadas en las preferencias de los usuarios. De esta manera, optimizamos y fortalecemos las experiencias de viaje, garantizando seguridad y satisfacción en cada recorrido.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 20),
              const Text(
                'Nuestro Compromiso',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'En Share Your Route, nos comprometemos a potenciar la calidad de las experiencias turísticas mediante soluciones tecnológicas que optimizan la comunicación, seguridad y satisfacción del cliente. Nuestro objetivo es ser el aliado estratégico para las empresas turísticas, ofreciendo herramientas innovadoras que simplifican la gestión de grupos y mejoran la coordinación en cada viaje. Creemos que el éxito de nuestros clientes es también nuestro éxito.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
