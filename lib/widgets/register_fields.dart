import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AvailabilityField extends StatelessWidget {
  const AvailabilityField({super.key, required this.days, required this.onTap});

  final Set<String> days;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const labels = ['M', 'T', 'W', 'Th', 'F', 'S', 'S'];
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          border: Border.all(color: kBorder, width: 1.4),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            const Expanded(child: Text('Enter Availability', style: TextStyle(color: kHint, fontSize: 18))),
            for (final label in labels)
              Container(
                width: 28,
                height: 28,
                margin: const EdgeInsets.only(left: 5),
                alignment: Alignment.center,
                decoration: const BoxDecoration(color: Color(0xFF8E8E8E), shape: BoxShape.circle),
                child: Text(label, style: const TextStyle(color: Colors.black, fontSize: 13)),
              ),
          ],
        ),
      ),
    );
  }
}

class CourtField extends StatelessWidget {
  const CourtField({super.key, required this.value, required this.onTap});

  final String? value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          border: Border.all(color: kBorder, width: 1.4),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            border: Border.all(color: kBorder, width: 1.2),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            value ?? 'Select Court Of Practice',
            style: const TextStyle(color: kHint, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
