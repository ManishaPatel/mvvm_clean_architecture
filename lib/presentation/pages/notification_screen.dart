import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/text_style.dart';
import '../../core/app_color.dart';
import '../widgets/custom_views/custom_app_bar.dart';
import '../widgets/custom_views/gradient_elevated_button.dart';
import '../widgets/user_item_scree.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<String> notifications = List.generate(10, (index) => "Notification $index");

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColor.orange, AppColor.grayLight],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          backgroundColor: Colors.transparent,
          appBarTitle: 'Users',
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: notifications.isEmpty
                    ? Center(
                        child: Text(
                          "No notifications",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        itemCount: notifications.length,
                        itemBuilder: (context, index) {
                          return NotificationItemScreen();
                        },
                      ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: 30.0,right: 30,top: 10,bottom: 20),
              child: GradientElevatedButton(
                text: "Clear All",
                onPressed: () {},
                gradient: LinearGradient(
                  colors: [AppColor.white, AppColor.white],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
