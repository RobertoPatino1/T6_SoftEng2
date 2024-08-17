import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share_your_route_front/modules/shared/providers/api_provider.dart';
import 'package:share_your_route_front/modules/shared/ui/custom_app_bar.dart';

class LastNameEditionScreen extends StatefulWidget {
  final String currentLastName;

  const LastNameEditionScreen({super.key, required this.currentLastName});

  @override
  _LastNameEditionScreenState createState() => _LastNameEditionScreenState();
}

class _LastNameEditionScreenState extends State<LastNameEditionScreen> {
  late TextEditingController _lastNameController;

  @override
  void initState() {
    super.initState();
    _lastNameController = TextEditingController(text: widget.currentLastName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Editar Apellidos',
        actions: [
          TextButton(
            onPressed: () {
              updateUserData(FirebaseAuth.instance.currentUser!.uid, {
                'lastName': _lastNameController.text,
              });
              Navigator.of(context).pop(_lastNameController.text);
            },
            child: const Text(
              'Hecho',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _lastNameController,
          maxLines: null,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            labelText: 'Escribe tus apellidos',
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _lastNameController.dispose();
    super.dispose();
  }
}
