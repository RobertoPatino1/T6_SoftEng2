import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'asset/images/logo.png',
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
              ),
              const SizedBox(height: 10),
              const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur convallis, metus eu malesuada vehicula, lectus est cursus arcu, vitae laoreet enim est sit amet odio. Donec id metus vitae lorem convallis ultrices. '
                'Vivamus eget dolor lacus. Proin vestibulum odio nec justo hendrerit, nec aliquet felis viverra. Sed in lacus nec libero malesuada laoreet ac in est. Praesent vehicula neque nisi, in ultricies mi cursus at. '
                'Nam ut orci eros. Quisque ultricies dui ac odio accumsan, in pulvinar magna cursus. Maecenas gravida suscipit orci, vel porttitor nulla pharetra ac. '
                'In congue nulla nec purus ornare, in vehicula sem pharetra. Morbi consectetur dolor at diam vehicula, in pulvinar ipsum bibendum. '
                'Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vivamus sollicitudin est ut augue dapibus, vitae varius risus posuere.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              const Text(
                'Nuestro Compromiso',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean mollis dapibus magna, vel facilisis purus facilisis ut. Etiam quis metus nec ipsum tristique dapibus. '
                'Mauris eu orci odio. Phasellus viverra metus in tellus cursus, in facilisis metus auctor. Nulla facilisi. Suspendisse ut ligula ut eros efficitur viverra. '
                'Phasellus ornare bibendum magna, id cursus justo vestibulum sit amet.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
