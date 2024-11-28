import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomTextfield extends StatelessWidget {
  final String hintText, lebelText;
  final TextEditingController controller;
  final bool? obscureText, needObscureText;
  final VoidCallback? onPress;
  final double? labelLeftPadding;
  final TextInputType? textInputType;
  final bool? readOnly;
  final FocusNode? focusNode;
  final int? maxLines;
  const CustomTextfield(
      {super.key,
      required this.hintText,
      required this.lebelText,
      this.obscureText,
      this.onPress,
      this.needObscureText,
        this.labelLeftPadding,
      required this.controller,
        this.textInputType,
        this.readOnly,
        this.focusNode,
        this.maxLines,
      });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText ?? false,
      controller: controller,
      keyboardType: textInputType ?? TextInputType.text,
      readOnly: readOnly ?? false,
      focusNode: focusNode,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding:  EdgeInsets.only(left: labelLeftPadding ?? 34.0),
          isDense: false,
          isCollapsed: false,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: HexColor("B1B1B1"), width: 0.5),
          ),
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              fontFamily: "Podkova",),
          hintTextDirection: TextDirection.ltr,
          label: Text(
            lebelText,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              fontFamily: "Podkova",
              color: Colors.black,
            ),
          ),
          alignLabelWithHint: true,
          fillColor: HexColor("#FFFFFFF"),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: HexColor("#B1B1B1"), width: 1.5),
            borderRadius: BorderRadius.circular(4),
          ),
          suffixIcon: needObscureText == true
              ? IconButton(
                  onPressed: onPress,
                  icon: Icon(
                    obscureText == false
                        ? Icons.visibility
                        : Icons.visibility_off,
                    size: 22,
                    color: Colors.black.withOpacity(0.6),
                  ))
              : const SizedBox.shrink(),),
    );
  }
}
