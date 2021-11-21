import 'package:flutter/material.dart';
import '../theme/theme.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color buttonColor;
  final String textValue;
  final Color textColor;

  // ignore: use_key_in_widget_constructors
  const CustomButton(
      {required this.onPressed,
      required this.buttonColor,
      required this.textValue,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(14.0),
      elevation: 0,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(14.0),
            child: Center(
              child: Text(
                textValue,
                style: heading5.copyWith(color: textColor),
              ),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
