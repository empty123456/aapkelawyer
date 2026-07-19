import 'package:flutter/material.dart';

class TermsCheck extends StatelessWidget {
  const TermsCheck({super.key, required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(value: value, onChanged: onChanged),
        const SizedBox(width: 8),
        const Expanded(
          child: Text.rich(
            TextSpan(
              text: 'I agree to the ',
              children: [
                TextSpan(
                  text: 'Terms & Conditions',
                  style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                ),
                TextSpan(text: ' and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                ),
              ],
            ),
            style: TextStyle(fontSize: 18, height: 1.25),
          ),
        ),
      ],
    );
  }
}
