import 'package:flutter/material.dart';
import '../../../utils/color_manager.dart';
import 'custom_button.dart';

class BuySellButton extends StatelessWidget {
  final String label;
  final bool isBuy;
  final VoidCallback onPressed;

  const BuySellButton({
    Key? key,
    required this.label,
    required this.isBuy,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppButton(
      label,
      enabledBtnColor: isBuy ? ColorManager.buyButtonColor : ColorManager.sellButtonColor,
      textColor: ColorManager.whiteTextColor,
      onTap: onPressed,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      fontSize: 16.0,
      borderRadius: 8,
    );
  }
}
