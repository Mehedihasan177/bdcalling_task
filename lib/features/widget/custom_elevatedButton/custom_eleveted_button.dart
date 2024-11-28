import 'package:flutter/material.dart';

import '../../../core/utils/consts/app_colors.dart';
import 'custom_text.dart';
class CustomElevatedButton extends StatelessWidget {
  final Color? textColor;
  final Color? hexColor; // Ensure hexColor is a Color, not a string
  final FontWeight? fontWeight;
  final VoidCallback? onPress;
  final String text;
  final double? topRightRadius,
      bottomLeftRadius,
      topLeft,
      bottomRight,
      minimumWidthSize,
      maximumWidthSize, textSize;
  final bool? loading;
  const CustomElevatedButton({
    super.key,
    this.textColor,
    this.onPress,
    this.hexColor,
    required this.text,
    this.bottomLeftRadius,
    this.topRightRadius,
    this.bottomRight,
    this.topLeft,
    this.fontWeight,
    this.maximumWidthSize,
    this.minimumWidthSize,
    this.textSize, this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: hexColor ??
            AppColors.backgroundColor, // This works if hexColor is a Color
        minimumSize: Size(
            minimumWidthSize ?? MediaQuery.of(context).size.width * 0.6, 38),
        maximumSize: Size(
            maximumWidthSize ?? MediaQuery.of(context).size.width * 0.6, 38),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(topRightRadius ?? 10),
            bottomLeft: Radius.circular(bottomLeftRadius ?? 10),
            topLeft: Radius.circular(topLeft ?? 0),
            bottomRight: Radius.circular(bottomRight ?? 0),
          ),
        ),
      ),
      onPressed: onPress,
      child: loading == true ? Center(
        child: CircularProgressIndicator(),
      ) : CustomSimpleText(
        text: text,
        color: textColor ?? Colors.white,
        fontWeight: fontWeight ?? FontWeight.w500,
        fontSize: textSize ?? 16,
        alignment: TextAlign.center,
      ),
    );
  }
}
