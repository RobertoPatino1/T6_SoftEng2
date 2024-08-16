import 'package:flutter/material.dart';
import 'package:share_your_route_front/modules/shared/ui/custom_app_bar.dart';
import 'package:share_your_route_front/modules/shared/ui/ui_utils.dart';
import 'package:share_your_route_front/oss_licenses.dart';

class LicenseScreen extends StatelessWidget {
  const LicenseScreen({super.key});

  Future<List<Package>> _loadLicenses() async {
    await Future.delayed(const Duration(seconds: 2));
    return allDependencies;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Licencias"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Package>>(
          future: _loadLicenses(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error al cargar licencias'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No hay licencias disponibles'));
            }

            final licenses = snapshot.data!;

            return SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    'Share Your Route License',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '© 2024 Share Your Route LLC™\n\n'
                    'This license governs the use, distribution, and modification of the "Share Your Route" application, developed by Share Your Route LLC™. '
                    'By using the app, you agree to comply with all the terms stated below.\n\n'
                    'Permissions:\n'
                    '- Use: Granted for personal and commercial purposes.\n'
                    '- Distribution: Freely distribute with this license agreement.\n'
                    '- Modification: Modifications for personal use allowed, but cannot be distributed without consent.\n\n'
                    'Restrictions:\n'
                    '- No Warranty: Provided "as is" without guarantees.\n'
                    '- No Reverse Engineering: Prohibited.\n'
                    '- Trademark Use: Requires written consent.\n\n'
                    'Liability:\n'
                    'Share Your Route LLC™ is not liable for damages arising from the use of the software.\n\n'
                    'Termination:\n'
                    'This license automatically terminates if terms are violated. Cease all use and destroy all copies upon termination.\n\n'
                    'For inquiries, contact us at shareyourroute@gmail.com.',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '© 2024 Share Your Route LLC™',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Third Party Licenses',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: licenses.length,
                    itemBuilder: (_, index) {
                      return Card(
                        color: const Color.fromARGB(255, 230, 229, 229),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ListTile(
                            title: Text(
                              licenses[index].name,
                              style: const TextStyle(fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {
                              navigateWithSlideTransition(
                                context,
                                LicenceDetailPage(
                                  title: licenses[index].name,
                                  description: licenses[index].description,
                                  licence: licenses[index].license!,
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class LicenceDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final String licence;
  const LicenceDetailPage({
    super.key,
    required this.title,
    required this.description,
    required this.licence,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 20),
                const Text(
                  "License Details",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  licence,
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
