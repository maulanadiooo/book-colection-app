import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    this.colorText = Colors.white,
    this.colorButton,
    this.onTap,
    this.borderActive = false,
    this.borderColor,
  }) : super(key: key);

  final String text;
  final Color colorText;
  final Color? colorButton;
  final void Function()? onTap;
  final bool borderActive;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: (borderActive)
              ? Border.all(
                  width: 1,
                  color: (borderColor == null)
                      ? Colors.green.withOpacity(0.8)
                      : borderColor!,
                )
              : null,
          color: (borderActive)
              ? null
              : (colorButton == null)
                  ? Colors.green.withOpacity(0.8)
                  : colorButton,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w400, color: colorText),
          ),
        ),
      ),
    );
  }
}
