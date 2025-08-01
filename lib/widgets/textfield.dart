import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String upperText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool obsecureText;
  final Color backgroundColor;
  final Color textColor;
  final Color labelColor;
  final FontStyle labelFontStyle;
  final double borderRadius;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.upperText,

    this.keyboardType = TextInputType.number,
    this.validator,
    this.obsecureText = false,
    this.backgroundColor = Colors.black,
    this.textColor = Colors.black,
    this.labelColor = Colors.black,
    this.labelFontStyle = FontStyle.normal,
    this.borderRadius = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(upperText),
        ),
        SizedBox(height: 5),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obsecureText,
          validator: validator,
          style: TextStyle(color: textColor),

          decoration: InputDecoration(
            filled: true,
            fillColor: Color.fromARGB(255, 243, 237, 237),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.only(left: 12),

            hintText: labelText,
            hintStyle: TextStyle(color: labelColor, fontStyle: labelFontStyle),
          ),
        ),
      ],
    );
  }
}
