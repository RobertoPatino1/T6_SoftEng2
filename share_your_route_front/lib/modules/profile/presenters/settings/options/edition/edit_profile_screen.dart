import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_your_route_front/core/constants/urls.dart';
import 'package:share_your_route_front/modules/profile/presenters/settings/options/edition/bio/bio_edition_screen.dart';
import 'package:share_your_route_front/modules/shared/ui/custom_app_bar.dart';
import 'package:share_your_route_front/modules/shared/ui/ui_utils.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  XFile? _profileImage;
  XFile? _bannerImage;
  String bio =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit."; // Biografía inicial
  final TextEditingController nameController =
      TextEditingController(text: "John");
  final TextEditingController surnameController =
      TextEditingController(text: "Doe");
  final TextEditingController emailController =
      TextEditingController(text: "johndoe@example.com");

  Future<void> _pickProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = pickedFile;
      });
    }
  }

  Future<void> _pickBannerImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _bannerImage = pickedFile;
      });
    }
  }

  Future<void> _editBio() async {
    navigateWithSlideTransition(
      context,
      BioEditionScreen(
        currentBio: bio,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Editar Perfil"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onTap: _pickBannerImage,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: _bannerImage == null
                            ? const AssetImage(
                                //TODO: CHANGE THIS TO THE USER BACKGROUND PIC, IF THE DATA IS NULL, THEN USE STOCK
                                stockBackgroundPictureURL,
                              )
                            : FileImage(File(_bannerImage!.path))
                                as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: _pickBannerImage,
                    child: const CircleAvatar(
                      radius: 15,
                      backgroundColor: Color.fromARGB(255, 230, 229, 229),
                      child: Icon(
                        Icons.edit,
                        color: Color.fromARGB(255, 45, 75, 115),
                        size: 20,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -50,
                  left: 16,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      GestureDetector(
                        onTap: _pickProfileImage,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: _profileImage == null
                              ? const AssetImage(
                                  //TODO: CHANGE THIS TO THE USER PROFILE PIC, IF THE DATA IS NULL, THEN USE STOCK
                                  stockProfilePictureURL,
                                )
                              : FileImage(File(_profileImage!.path))
                                  as ImageProvider,
                        ),
                      ),
                      GestureDetector(
                        onTap: _pickProfileImage,
                        child: const CircleAvatar(
                          radius: 15,
                          backgroundColor: Color.fromARGB(255, 230, 229, 229),
                          child: Icon(
                            Icons.camera_alt,
                            color: Color.fromARGB(255, 45, 75, 115),
                            size: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Nombres'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese sus nombres';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: surnameController,
                      decoration: const InputDecoration(labelText: 'Apellidos'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese sus apellidos';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese su email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: _editBio,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                bio,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            const Icon(Icons.edit, color: Colors.grey),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // TODO: Implementar la lógica de guardado
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text('Guardar cambios'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
