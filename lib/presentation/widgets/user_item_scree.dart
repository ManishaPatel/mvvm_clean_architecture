import 'package:flutter/material.dart';

import '../../core/app_color.dart';

class NotificationItemScreen extends StatefulWidget {
  const NotificationItemScreen({super.key});

  @override
  State<NotificationItemScreen> createState() => _NotificationItemScreenState();
}

class _NotificationItemScreenState extends State<NotificationItemScreen> {
  @override
  Widget build(BuildContext context) {
    return
      Padding(
      padding: EdgeInsets.all(4),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon or Image
            Padding(
              padding: EdgeInsets.all(15),
              child: SizedBox(
                width: 12,
                height: 12,
                child: CircleAvatar(radius: 16,backgroundColor: Colors.red),
              ),
            ),
            // Text Section
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10,right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Date Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Your Lorum ipsum property',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColor.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '2 days ago',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColor.blackLight, // Making it lighter for a date
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5), // Spacing between title and description
                    // Description
                    Text('Added Gourmet Cheese to your kit. Next week just got tastier!',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.blackLight,
                      ),
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
}
