import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share_your_route_front/modules/shared/providers/api_provider.dart';
import 'package:share_your_route_front/modules/shared/ui/custom_app_bar.dart';

class EmailEditionScreen extends StatefulWidget {
  final String currentEmail;

  const EmailEditionScreen({super.key, required this.currentEmail});

  @override
  _NameEditionScreenState createState() => _NameEditionScreenState();
}

class _NameEditionScreenState extends State<EmailEditionScreen> {
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.currentEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Editar Email',
        actions: [
          TextButton(
            onPressed: () {
              updateUserData(FirebaseAuth.instance.currentUser!.uid, {
                'email': _emailController.text,
              });
              Navigator.of(context).pop(_emailController.text);
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
          controller: _emailController,
          maxLines: null,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            labelText: 'Escribe tu email',
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
