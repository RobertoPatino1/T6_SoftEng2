import 'package:flutter/material.dart';
import 'package:share_your_route_front/modules/shared/ui/custom_app_bar.dart';

class BioEditionScreen extends StatefulWidget {
  final String currentBio;

  const BioEditionScreen({super.key, required this.currentBio});

  @override
  _BioEditionScreenState createState() => _BioEditionScreenState();
}

class _BioEditionScreenState extends State<BioEditionScreen> {
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    _bioController = TextEditingController(text: widget.currentBio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Editar Bio',
        actions: [
          TextButton(
            onPressed: () {
              // TODO: UPDATE THE SAVED BIO IN THE DATABASE
              Navigator.of(context).pop(_bioController.text);
            },
            child: const Text(
              'Hecho',
              style: TextStyle(
                color: Colors
                    .white, // Cambiado a blanco para que coincida con el tema
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _bioController,
          maxLines: null,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            labelText: 'Escribe tu biografía',
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }
}
