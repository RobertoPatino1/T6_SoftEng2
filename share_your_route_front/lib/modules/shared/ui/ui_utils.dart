import 'package:flutter/material.dart';

InputDecoration buildInputDecoration({String? labelText, String? hintText}) {
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    labelText: labelText,
    hintText: hintText,
  );
}

void showSnackbar(BuildContext context, String message, String messageType) {
  Color backgroundColor;
  Icon icon;

  switch (messageType.toLowerCase()) {
    case 'error':
      backgroundColor = Colors.red;
      icon = const Icon(Icons.error, color: Colors.white);
    case 'warning':
      backgroundColor = Colors.amber;
      icon = const Icon(Icons.warning, color: Colors.white);
    case 'confirmation':
      backgroundColor = Colors.green;
      icon = const Icon(Icons.check_circle, color: Colors.white);
    default:
      backgroundColor = Colors.blue;
      icon = const Icon(Icons.info, color: Colors.white);
  }

  ScaffoldMessenger.of(context).clearSnackBars();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: SizedBox(
        height: 50,
        child: Row(
          children: [
            icon,
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white, fontSize: 15),
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: backgroundColor,
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
        label: 'Cerrar',
        textColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ),
  );
}

Widget slideInTransition(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child,) {
  const begin = Offset(1.0, 0.0);
  const end = Offset.zero;
  const curve = Curves.ease;

  final tween = Tween(begin: begin, end: end).chain(
    CurveTween(curve: curve),
  );

  return SlideTransition(
    position: animation.drive(tween),
    child: child,
  );
}

void navigateWithSlideTransition(BuildContext context, Widget page) {
  Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: slideInTransition,
    ),
  );
}
