import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

@immutable
class GradientElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Gradient gradient;
  final double borderRadius;
  final double fontSize;
  final Color textColor;
  final Color borderColor;
  final Color imageColor;
  final EdgeInsetsGeometry padding;
  final String imagePath;
  final bool isVisible;

  const GradientElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.gradient,
    this.borderRadius =10,
    this.fontSize = 17,
    this.textColor = Colors.white,
    this.imageColor = Colors.white,
    this.borderColor = Colors.transparent,
    this.padding = const EdgeInsets.symmetric(vertical: 13.0, horizontal: 24.0),
    this.imagePath = 'assets/images/cart.svg',
    this.isVisible = false,

  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      onPressed: onPressed,
      child: Ink(
        decoration: BoxDecoration(
          gradient: gradient,
          border: Border.all(color: borderColor, width: 1),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Container(
          alignment: Alignment.center,
          padding: padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                  visible: isVisible,
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: SvgPicture.asset(imagePath),
                  )),
              Text(text.tr, style: TextStyle(color: textColor, fontSize: fontSize,
                    fontWeight: FontWeight.w600, letterSpacing: 0.5),
              ),
              SizedBox(width: 12,height: 16,),
              Image.asset(imagePath,color: imageColor,width: 20,height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
