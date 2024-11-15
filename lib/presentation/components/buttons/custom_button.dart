import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Color? enabledBtnColor;
  final Color? disabledBtnColor;
  final Color? textColor;
  final bool? enabled;
  final VoidCallback onTap;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;
  final double? fontSize;
  final double borderRadius;

  const AppButton(
      this.text, {
        Key? key,
        this.enabledBtnColor,
        this.disabledBtnColor,
        this.textColor,
        this.enabled,
        required this.onTap,
        this.padding = const EdgeInsets.symmetric(vertical: 15.0),
        this.height,
        this.width = double.infinity,
        this.fontSize = 14.0,
        this.borderRadius = 15.0,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled == null || enabled == true ? onTap : null,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: (enabled == null || enabled == true)
              ? enabledBtnColor ?? Theme.of(context).primaryColor
              : disabledBtnColor ?? Theme.of(context).primaryColor.withOpacity(0.2),
        ),
        padding: padding,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: enabled != null && !enabled!
                  ? Colors.black
                  : textColor ?? Colors.white,
              fontSize: fontSize,
            ),
          ),
        ),
      ),
    );
  }
}
