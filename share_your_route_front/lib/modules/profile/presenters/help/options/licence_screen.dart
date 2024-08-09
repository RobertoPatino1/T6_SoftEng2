import 'package:flutter/material.dart';
import 'package:share_your_route_front/modules/shared/ui/custom_app_bar.dart';

class LicenseScreen extends StatelessWidget {
  const LicenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: "Licencia"),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Share Your Route License',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'GNU GENERAL PUBLIC LICENSE\n'
                'Version 3, 29 June 2007\n\n'
                'Copyright © 2007 Free Software Foundation, Inc. <https://fsf.org/>\n'
                'Everyone is permitted to copy and distribute verbatim copies\n'
                'of this license document, but changing it is not allowed.\n\n'
                'Preamble\n'
                'The GNU General Public License is a free, copyleft license for\n'
                'software and other kinds of works.\n\n'
                'The licenses for most software and other practical works are\n'
                'designed to take away your freedom to share and change the works.\n'
                'By contrast, the GNU General Public License is intended to guarantee\n'
                'your freedom to share and change all versions of a program--to make\n'
                'sure it remains free software for all its users. We, the Free\n'
                'Software Foundation, use the GNU General Public License for most\n'
                'of our software; it applies also to any other work released this way\n'
                'by its authors. You can apply it to your programs, too.\n\n'
                'When we speak of free software, we are referring to freedom, not\n'
                'price. Our General Public Licenses are designed to make sure that\n'
                'you have the freedom to distribute copies of free software (and\n'
                'charge for them if you wish), that you receive source code or can\n'
                'get it if you want it, that you can change the software or use\n'
                'pieces of it in new free programs, and that you know you can do\n'
                'these things.\n\n'
                'To protect your rights, we need to prevent others from denying you\n'
                'these rights or asking you to surrender the rights. Therefore, you\n'
                'have certain responsibilities if you distribute copies of the\n'
                'software, or if you modify it: responsibilities to respect the\n'
                'freedom of others.\n\n'
                'For example, if you distribute copies of such a program, whether\n'
                'gratis or for a fee, you must pass on to the recipients the same\n'
                'freedoms that you received. You must make sure that they, too,\n'
                'receive or can get the source code. And you must show them these\n'
                'terms so they know their rights.\n\n'
                'Developers that use the GNU GPL protect your rights with two steps:\n'
                '(1) assert copyright on the software, and (2) offer you this License\n'
                'giving you legal permission to copy, distribute and/or modify it.\n\n'
                "For the developers' and authors' protection, the GPL clearly explains\n"
                "that there is no warranty for this free software. For both users' and\n"
                "authors' sake, the GPL requires that modified versions be marked as\n"
                'changed, so that their problems will not be attributed erroneously to\n'
                'authors of previous versions.\n\n',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 20),
              Text(
                '© 2024 Share Your Route LLC™',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
