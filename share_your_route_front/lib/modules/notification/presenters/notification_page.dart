import 'package:flutter/material.dart';
import 'package:share_your_route_front/core/constants/colors.dart';
import 'package:share_your_route_front/modules/shared/ui/custom_app_bar.dart';

class NotificationPage extends StatefulWidget {
  final ValueChanged<int> onUnreadCountChanged;
  final List<NotificationItem> notifications;

  const NotificationPage({
    super.key,
    required this.notifications,
    required this.onUnreadCountChanged,
  });

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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardBackgroundColor =
        isDarkMode ? darkButtonBackgroundColor : lightButtonBackgroundColor;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final unviewedNotificationBackgroundColor = Colors.blue.shade50;

    return Scaffold(
      appBar: const CustomAppBar(title: "Notificaciones"),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
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
                      ? cardBackgroundColor
                      : unviewedNotificationBackgroundColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notification.title,
                            style: TextStyle(
                              fontSize: 15,
                              color: notification.isRead
                                  ? textColor
                                  : Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            notification.details,
                            style: TextStyle(
                              fontSize: 12,
                              color: notification.isRead
                                  ? textColor
                                  : Colors.black,
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
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          notifications.removeAt(index);
                          widget.onUnreadCountChanged(
                              notifications.where((n) => !n.isRead).length);
                        });
                      },
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
