import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  final ValueChanged<int> onUnreadCountChanged;
  final List<NotificationItem> notifications;

  const NotificationPage(
      {super.key,
      required this.notifications,
      required this.onUnreadCountChanged});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late List<NotificationItem> notifications;

  @override
  void initState() {
    super.initState();
    notifications = widget.notifications;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];

            return GestureDetector(
              onTap: () {
                setState(() {
                  notification.isRead = true;
                });
                final int unreadNotificationsCount =
                    notifications.where((n) => !n.isRead).length;
                widget.onUnreadCountChanged(unreadNotificationsCount);
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                width: screenWidth * 0.9,
                decoration: BoxDecoration(
                  color: notification.isRead
                      ? const Color.fromARGB(255, 230, 229, 229)
                      : const Color.fromARGB(255, 200, 230, 201),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title,
                      style: TextStyle(
                        fontSize: 15,
                        color:
                            notification.isRead ? Colors.black : Colors.green,
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
              ),
            );
          },
        ),
      ),
    );
  }
}

class NotificationItem {
  final String title;
  final String details;
  final DateTime date;
  bool isRead;

  NotificationItem(this.title, this.details, this.date, {this.isRead = false});
}
