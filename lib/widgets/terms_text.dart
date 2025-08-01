import 'package:flutter/material.dart';

class TermsAndPrivacyText extends StatelessWidget {
  const TermsAndPrivacyText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        children: [
          TextSpan(
            text:
                "By creating or logging into an account you are agreeing With Our ",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
          ),
          TextSpan(
            text: "Terms and Conditions",
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: " and ",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
          ),
          TextSpan(
            text: "Privacy Policy",
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
