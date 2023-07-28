import 'package:flutter/material.dart';
import 'package:notes_app/theme/app_theme.dart';

class KTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final Color cursorColor;
  final double cursorHeight;
  final String? hintText;
  final Icon? prefixIcon;
  final Color? focusColor;
  final bool? autoFocus;

  const KTextFormField({
    Key? key,
    this.prefixIcon,
    this.autoFocus,
    this.focusColor,
    this.controller,
    this.cursorColor = Colors.black,
    this.cursorHeight = 30,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autoFocus ?? false,
      controller: controller,
      cursorColor: cursorColor,
      cursorHeight: cursorHeight,
      decoration: InputDecoration(
        hintText: hintText ?? '',
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: disabledColor),
        prefixIcon: prefixIcon,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: focusColor ?? Colors.transparent),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder:const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      style:const TextStyle(color: Colors.white),
    );
  }
}
