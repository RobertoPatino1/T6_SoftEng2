import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_your_route_front/models/user_data.dart';
import 'package:share_your_route_front/modules/profile/presenters/settings/options/edition/bio/bio_edition_screen.dart';
import 'package:share_your_route_front/modules/profile/presenters/settings/options/edition/email/email_edition_screen.dart';
import 'package:share_your_route_front/modules/profile/presenters/settings/options/edition/last_name/last_name_edition_screen.dart';
import 'package:share_your_route_front/modules/profile/presenters/settings/options/edition/name/name_edition_screen.dart';
import 'package:share_your_route_front/modules/shared/providers/api_provider.dart';
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

  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await getUserData(FirebaseAuth.instance.currentUser!.uid);
    final user = UserData.fromJson(userData["user"] as Map<String, dynamic>);

    setState(() {
      nameController.text = user.firstName;
      surnameController.text = user.lastName;
      emailController.text = user.email;
      bioController.text = user.bio;
    });
  }

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

  Future<void> _editEmail(String email) async {
    navigateWithSlideTransition(
      context,
      EmailEditionScreen(
        currentEmail: email,
      ),
    );
  }

  Future<void> _editLastNames(String lastName) async {
    navigateWithSlideTransition(
      context,
      LastNameEditionScreen(
        currentLastName: lastName,
      ),
    );
  }

  Future<void> _editNames(String name) async {
    navigateWithSlideTransition(
      context,
      NameEditionScreen(
        currentName: name,
      ),
    );
  }

  Future<void> _editBio(String bio) async {
    navigateWithSlideTransition(
      context,
      BioEditionScreen(
        currentBio: bio,
      ),
    );
  }

  GestureDetector buildEditableContainer(
    String label,
    String value,
    VoidCallback onTap,
    bool isDarkMode,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                value,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const Icon(Icons.edit, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Column formFields(UserData user) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Nombres",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        const SizedBox(height: 2.5),
        buildEditableContainer(
          "Nombres",
          user.firstName,
          () => _editNames(user.firstName),
          isDarkMode,
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Apellidos",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        const SizedBox(height: 2.5),
        buildEditableContainer(
          "Apellidos",
          user.lastName,
          () => _editLastNames(user.lastName),
          isDarkMode,
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Email",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        const SizedBox(height: 2.5),
        buildEditableContainer(
          "Email",
          user.email,
          () => _editEmail(user.email),
          isDarkMode,
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Bio",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        const SizedBox(height: 2.5),
        buildEditableContainer(
          "Bio",
          user.bio,
          () => _editBio(user.bio),
          isDarkMode,
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              user.update(FirebaseAuth.instance.currentUser!.uid);
              Navigator.of(context).pop(true);
            }
          },
          child: const Text('Guardar cambios'),
        ),
      ],
    );
  }

  Column contentPage(UserData user) {
    final backgroundPicture = user.backgroundPhoto;
    final profilePicture = user.profilePhoto;

    return Column(
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
                        ? AssetImage(backgroundPicture)
                        : FileImage(File(_bannerImage!.path)) as ImageProvider,
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
                          ? AssetImage(profilePicture)
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
            child: formFields(user),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Editar Perfil"),
      body: SingleChildScrollView(
        child: FutureBuilder<Map<String, dynamic>>(
          future: getUserData(FirebaseAuth.instance.currentUser!.uid),
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator())
                  : contentPage(
                      UserData.fromJson(
                        snapshot.data!["user"] as Map<String, dynamic>,
                      ),
                    ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    bioController.dispose();
    super.dispose();
  }
}
