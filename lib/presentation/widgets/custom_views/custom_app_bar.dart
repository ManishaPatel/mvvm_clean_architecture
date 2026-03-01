import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/app_color.dart';
import '../../../core/text_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
   String appBarTitle;
   Color backgroundColor;
   bool showBackButton;
   GestureTapCallback? onTap;
   String iconPath = 'assets/images/back.svg';

  CustomAppBar({
    super.key,
    required this.appBarTitle,
    required this.backgroundColor,
    this.onTap,
    // this.automaticImplyLeading = true,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      centerTitle: true,
      leading: showBackButton
          ? GestureDetector(
              onTap: onTap ?? () {
                Navigator.pop(context);
              },
              child: Padding(
                  padding: EdgeInsets.all(16),
                  child: SvgPicture.asset(
                    iconPath,
                    width: 16,
                    height: 16,
                    colorFilter: ColorFilter.mode(
                      AppColor.white,
                      BlendMode.srcIn,
                    ),
                  )),
            ) : null,
      automaticallyImplyLeading: true,
      title: Text(appBarTitle, style: TextStyles.appBarTitle(context),),
      iconTheme: IconThemeData(color: AppColor.white),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
