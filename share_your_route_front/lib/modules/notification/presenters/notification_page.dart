import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  // Lista de notificaciones
  final List<NotificationItem> notifications = [
    NotificationItem("Título 1", "Detalles del mensaje 1", DateTime.now()),
    NotificationItem("Título 2", "Detalles del mensaje 2", DateTime.now().subtract(const Duration(hours: 1))),
    NotificationItem("Título 3", "Detalles del mensaje 3", DateTime.now().subtract(const Duration(days: 1))),
    // Puedes agregar más notificaciones aquí
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            width: screenWidth * 0.9,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 230, 229, 229),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  notification.details,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "${notification.date.hour}:${notification.date.minute} ${notification.date.day}/${notification.date.month}/${notification.date.year}",
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class NotificationItem {
  final String title;
  final String details;
  final DateTime date;

  NotificationItem(this.title, this.details, this.date);
}
