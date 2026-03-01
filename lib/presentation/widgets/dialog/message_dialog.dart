import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../core/app_color.dart';
import '../custom_views/gradient_elevated_button.dart';

class MessageDialog extends StatefulWidget {
  final String? title;
  final String? message;
  final VoidCallback? okCallback;
  final String? ok;

  const MessageDialog({
    super.key,
    this.title,
    this.message,
    this.okCallback,
    this.ok,
  });

  @override
  State<MessageDialog> createState() => _MessageDialogState();
}

class _MessageDialogState extends State<MessageDialog> with SingleTickerProviderStateMixin {
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
      // Removed OrientationBuilder as it's not strictly necessary
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_padding),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: _contentBox(context),
      ),
    );
  }

  Widget _contentBox(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    // Calculate the dynamic width: 70% of screen width, but capped at _maxDialogWidth
    final double calculatedWidth = screenWidth * 0.70;
    final double finalWidth = calculatedWidth > _maxDialogWidth ? _maxDialogWidth : calculatedWidth;

    // Removed Stack and unnecessary containers for a cleaner widget tree
    return Container(
      width: finalWidth, // Apply responsive width constraint
      padding: const EdgeInsets.all(_padding),
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
          if (widget.title != null && widget.title!.isNotEmpty)
            Text(
              widget.title!.tr, // Assuming title might be translated
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColor.black,
              ),
              textAlign: TextAlign.center,
            ),

          if (widget.title != null && widget.title!.isNotEmpty)
            const SizedBox(height: 15),

          // Message/Content
          Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Text(
                // Use widget.message or the default translated string
                widget.message?.tr ?? "internet_not_available".tr,
                style: TextStyle(fontSize: 15, color: AppColor.textTitle),
                textAlign: TextAlign.center,
              )),

          const SizedBox(height: 20),

          // Action Button (OK)
          Container(
            alignment: Alignment.center,
            child: GradientElevatedButton(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
              text: widget.ok?.tr ?? 'ok'.tr,
              fontSize: 16,
              // Use the provided callback, falling back to a dummy function if null
              onPressed: widget.okCallback ?? () => Navigator.of(context).pop(),
              borderRadius: 10,
              gradient: const LinearGradient(
                colors: [AppColor.roundEnd, AppColor.roundStart],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          )
        ],
      ),
    );
  }
}
