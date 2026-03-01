import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'app_color.dart';

/// Helper for scaling font size based on device width
class ResponsiveFont {
  static double scale(BuildContext context, double baseSize) {
    double width = MediaQuery.of(context).size.width;

    if (width < 600) {
      // Mobile
      return baseSize * 0.9;
    } else if (width < 1024) {
      // Tablet
      return baseSize * 1.1;
    } else {
      // Desktop / Web
      return baseSize * 1.2;
    }
  }
}

class TextStyles {

  static TextStyle normalText(BuildContext context,
      {Color color = AppColor.black,
        double fontSize = 14.0,
        FontWeight fontWeight = FontWeight.normal}) {
    return TextStyle(
      fontSize: ResponsiveFont.scale(context, fontSize),
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle titleText(BuildContext context,
      {Color color = AppColor.black,
        double fontSize = 12.0,
        FontWeight fontWeight = FontWeight.w500}) {
    return TextStyle(
      fontSize: ResponsiveFont.scale(context, fontSize),
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle descriptionText(BuildContext context,
      { Color color = AppColor.gray,
        double fontSize = 14.0,
        FontWeight fontWeight = FontWeight.normal}) {
    return TextStyle(
      fontSize: ResponsiveFont.scale(context, fontSize),
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle loginLable(BuildContext context,
      {Color color = AppColor.lableColor,
        FontWeight fontWeight = FontWeight.w500,
        double fontSize = 12,
        double height = 1.6}) {
    return TextStyle(
      color: color,
      height: height,
      fontSize: ResponsiveFont.scale(context, fontSize),
      fontWeight: fontWeight,
    );
  }

  static TextStyle textFieldHint(BuildContext context,
      {Color color = AppColor.gray,
        double fontSize = 14,
        double letterSpacing = 1,
        double height = 1.2}) {
    return TextStyle(
      color: color,
      fontSize: ResponsiveFont.scale(context, fontSize),
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  static TextStyle textFieldText(BuildContext context,
      {Color color = AppColor.black,
        double fontSize = 14,
        FontWeight fontWeight = FontWeight.w500,
        double height = 1.4}) {
    return TextStyle(
      color: color,
      fontSize: ResponsiveFont.scale(context, fontSize),
      fontWeight: fontWeight,
      height: height,
    );
  }

  static TextStyle loginRedLable(BuildContext context,
      {Color color = AppColor.textColorRed,
        FontWeight fontWeight = FontWeight.w600,
        double fontSize = 14,
        double height = 1.4}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: ResponsiveFont.scale(context, fontSize),
      height: height,
    );
  }

  static TextStyle loginGrayLable(BuildContext context,
      {Color color = AppColor.gray,
        double fontSize = 14,
        FontWeight fontWeight = FontWeight.w600}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: ResponsiveFont.scale(context, fontSize),
    );
  }

  static TextStyle tabStyle(BuildContext context,
      {Color color = AppColor.tabFontColor,
        double fontSize = 14,
        FontWeight fontWeight = FontWeight.w500,
        double height = 1.5}) {
    return TextStyle(
      color: color,
      fontSize: ResponsiveFont.scale(context, fontSize),
      fontWeight: fontWeight,
      height: height,
    );
  }

  static TextStyle appBarTitle(BuildContext context,
      {Color color = AppColor.white,
        double fontSize = 24,
        double height = 1,
        FontWeight fontWeight = FontWeight.w700}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: ResponsiveFont.scale(context, fontSize),
      height: height,
    );
  }

  static TextStyle bottomMenuUnselected(BuildContext context,
      {Color color = AppColor.menuUnselected,
        double fontSize = 12,
        double height = 1.5,
        FontWeight fontWeight = FontWeight.w500}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: ResponsiveFont.scale(context, fontSize),
      height: height,
    );
  }

  static TextStyle dashboardViewAll(BuildContext context,
      {Color color = AppColor.white,
        double fontSize = 14,
        double height = 1,
        double letterSpacing = 0.5,
        FontWeight fontWeight = FontWeight.w500}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: ResponsiveFont.scale(context, fontSize),
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle infoLable(BuildContext context,
      {Color color = AppColor.lblColor,
        double fontSize = 10,
        double letterSpacing = 0,
        FontWeight fontWeight = FontWeight.w500}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      fontSize: ResponsiveFont.scale(context, fontSize),
    );
  }

  static TextStyle infoText(BuildContext context,
      {Color color = AppColor.white,
        double fontSize = 15,
        double letterSpacing = 0.5,
        FontWeight fontWeight = FontWeight.w600}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      fontSize: ResponsiveFont.scale(context, fontSize),
    );
  }

  static TextStyle filterLable(BuildContext context,
      {Color color = AppColor.textTitle,
        double fontSize = 14,
        double height = 1.6,
        FontWeight fontWeight = FontWeight.w500}) {
    return TextStyle(
      fontSize: ResponsiveFont.scale(context, fontSize),
      color: color,
      height: height,
      fontWeight: fontWeight,
    );
  }
}
