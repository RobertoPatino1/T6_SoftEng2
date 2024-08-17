import 'package:flutter/material.dart';
import 'package:share_your_route_front/modules/shared/ui/custom_app_bar.dart';

class TermsAndPrivacyScreen extends StatelessWidget {
  const TermsAndPrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: "Términos y Políticas"),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Términos de Servicio',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Al utilizar la aplicación Share Your Route, aceptas cumplir con nuestros términos de servicio. La aplicación está diseñada para optimizar la coordinación y comunicación en actividades turísticas. Los usuarios deben proporcionar información veraz y utilizar la aplicación de manera responsable. Cualquier uso indebido o ilegal de la aplicación puede resultar en la suspensión o cancelación de la cuenta.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 20),
              Text(
                'Políticas de Privacidad',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'En Share Your Route, nos comprometemos a proteger la privacidad de nuestros usuarios. Toda la información personal recopilada se utilizará exclusivamente para mejorar la experiencia del usuario y garantizar una comunicación efectiva entre guías y turistas. No compartiremos información personal con terceros sin el consentimiento explícito del usuario.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 20),
              Text(
                'Recolección de Datos',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Recolectamos datos como nombre, correo electrónico y preferencias de viaje para personalizar las recomendaciones y mejorar la experiencia de uso. Estos datos se almacenan de manera segura y se utilizan para ofrecer funciones relevantes a los usuarios.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 20),
              Text(
                'Uso de la Información',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'La información recopilada se utiliza para personalizar las experiencias de los usuarios, mejorar la comunicación durante los tours, y proporcionar recomendaciones de rutas basadas en las preferencias individuales. Nunca compartiremos tus datos con terceros sin tu consentimiento.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 20),
              Text(
                'Seguridad',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Implementamos medidas de seguridad avanzadas para proteger tu información personal y asegurar que tu experiencia con Share Your Route sea segura y confiable.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 20),
              Text(
                'Contacto',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Si tienes alguna pregunta o inquietud, no dudes en contactarnos a través de nuestra dirección de correo electrónico:',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 10),
              Text(
                'shareyouroute@gmail.com',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
