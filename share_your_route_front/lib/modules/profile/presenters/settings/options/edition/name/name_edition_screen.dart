import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share_your_route_front/modules/shared/providers/api_provider.dart';
import 'package:share_your_route_front/modules/shared/ui/custom_app_bar.dart';

class NameEditionScreen extends StatefulWidget {
  final String currentName;

  const NameEditionScreen({super.key, required this.currentName});

  @override
  _NameEditionScreenState createState() => _NameEditionScreenState();
}

class _NameEditionScreenState extends State<NameEditionScreen> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Editar Nombres',
        actions: [
          TextButton(
            onPressed: () {
              updateUserData(FirebaseAuth.instance.currentUser!.uid, {
                'firstName': _nameController.text,
              });
              Navigator.of(context).pop(_nameController.text);
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
          controller: _nameController,
          maxLines: null,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            labelText: 'Escribe tus nombres',
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
