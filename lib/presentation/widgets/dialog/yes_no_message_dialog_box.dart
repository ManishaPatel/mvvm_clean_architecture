import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../core/app_color.dart';
import '../custom_views/gradient_elevated_button.dart';

class YesNoMessageDialogBox extends StatefulWidget {
  final String title;
  final String textEditing;
  final VoidCallback noCallback;
  final VoidCallback yesCallback;
  // Note: 'yes' and 'no' fields are redundant since you use GetX translation 'yes'.tr and 'no'.tr in the buttons.
  final String yes;
  final String no;

  const YesNoMessageDialogBox({
    super.key,
    required this.title,
    required this.textEditing,
    required this.noCallback,
    required this.yesCallback,
    this.yes = "Yes",
    this.no = "No",
  });

  @override
  State<YesNoMessageDialogBox> createState() => _YesNoMessageDialogBoxState();
}

class _YesNoMessageDialogBoxState extends State<YesNoMessageDialogBox>
    with SingleTickerProviderStateMixin {
  static const double _padding = 20.0;
  static const double _maxDialogWidth = 400.0; // Max width for responsiveness
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutBack,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
        scale: _animation,
        // Removed OrientationBuilder as it's not strictly necessary and adds widget complexity
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_padding),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: _contentBox(context),
        ));
  }

  Widget _contentBox(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    // Calculate the dynamic width: 70% of screen width, but capped at _maxDialogWidth
    final double calculatedWidth = screenWidth * 0.70;
    final double finalWidth = calculatedWidth > _maxDialogWidth ? _maxDialogWidth : calculatedWidth;

    // Removed the unnecessary Stack
    return Container(
      width: finalWidth, // Apply responsive width constraint
      padding: EdgeInsets.all(_padding),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(_padding),
          boxShadow: const [
            BoxShadow(color: Colors.black, offset: Offset(0, 5), blurRadius: 10),
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Title
          Text(
            widget.title.toString().tr, // Assuming title might also be translated
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColor.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),

          // Message/Content
          Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Text(
                widget.textEditing.toString(),
                style: TextStyle(fontSize: 15, color: AppColor.textTitle),
                textAlign: TextAlign.center,
              )),

          const SizedBox(height: 20),

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: GradientElevatedButton(
                    text: 'no'.tr, // Swapped Yes/No to match standard cancellation flow (No/Cancel usually on the left)
                    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                    onPressed: widget.noCallback,
                    textColor: AppColor.white,
                    borderRadius: 10,
                    fontSize: 14,
                    gradient: const LinearGradient(
                      colors: [AppColor.roundEnd, AppColor.roundStart],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: GradientElevatedButton(
                    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                    text: 'yes'.tr,
                    fontSize: 14,
                    onPressed: widget.yesCallback,
                    textColor: AppColor.black,
                    borderRadius: 10,
                    borderColor: AppColor.roundEnd,
                    gradient: const LinearGradient(
                      colors: [
                        AppColor.white,
                        AppColor.white
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
