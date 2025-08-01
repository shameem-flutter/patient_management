import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final Color backgroundColor;
  final String text;
  final VoidCallback onPressed;
  final Color textColor;

  CustomTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = const Color(0XFF006837),
    this.textColor = Colors.white,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 50,
          child: TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              backgroundColor: backgroundColor,
              foregroundColor: textColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),

            child: Text(text),
          ),
        ),
      ],
    );
  }
}
