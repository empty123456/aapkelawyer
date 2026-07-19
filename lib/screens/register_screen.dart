import 'package:flutter/material.dart';

import '../models/user_role.dart';
import '../theme/app_colors.dart';
import '../widgets/app_buttons.dart';
import '../widgets/app_form_fields.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/register_fields.dart';
import '../widgets/terms_check.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.role});

  final UserRole role;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Set<String> _availableDays = {};
  bool _acceptedTerms = false;
  String? _gender;
  String? _expertise;
  String? _court;

  bool get _isLawyer => widget.role == UserRole.lawyer;

  void _register() {
    if (!_formKey.currentState!.validate() || !_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all required details and accept terms')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.role.label} registration ready to connect to API')),
    );
  }

  Future<void> _showAvailabilityDialog() async {
    final Set<String> temp = {..._availableDays};
    await showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            title: const Text('Enter Your Availability'),
            contentPadding: const EdgeInsets.fromLTRB(18, 12, 18, 0),
            content: SizedBox(
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (final day in const ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'])
                      Padding(
                        padding: const EdgeInsets.only(bottom: 18),
                        child: Column(
                          children: [
                            SwitchListTile(
                              value: temp.contains(day),
                              onChanged: (value) {
                                setDialogState(() {
                                  value ? temp.add(day) : temp.remove(day);
                                });
                              },
                              title: Text(day, style: const TextStyle(fontWeight: FontWeight.w800)),
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Time Range:', style: TextStyle(fontSize: 18)),
                                Column(children: [Text('From', style: TextStyle(color: kBrown, fontSize: 18)), Text('21:05')]),
                                Column(children: [Text('To', style: TextStyle(color: kBrown, fontSize: 18)), Text('21:05')]),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
              FilledButton(
                onPressed: () {
                  setState(() {
                    _availableDays
                      ..clear()
                      ..addAll(temp);
                  });
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _showCourtDialog() async {
    String? temp = _court;
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text('Select Type of Court'),
        content: StatefulBuilder(
          builder: (context, setDialogState) => DropdownButtonFormField<String>(
            value: temp,
            hint: const Text('Select Court'),
            items: const ['Supreme Court', 'High Court', 'District Court']
                .map((court) => DropdownMenuItem(value: court, child: Text(court)))
                .toList(),
            onChanged: (value) => setDialogState(() => temp = value),
          ),
        ),
        actions: [
          FilledButton(
            onPressed: () {
              setState(() => _court = temp);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const ProfileAvatar(),
                const SizedBox(height: 26),
                Text(
                  _isLawyer ? 'Register Your Lawyer Account' : 'Register your account',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: kBrown, fontSize: 30, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 28),
                const AppTextField(hint: 'Name'),
                const SizedBox(height: 14),
                if (_isLawyer) ...[
                  const AppTextField(hint: 'Email', keyboardType: TextInputType.emailAddress),
                  const SizedBox(height: 14),
                ],
                const AppTextField(hint: 'Date of Birth', keyboardType: TextInputType.datetime),
                const SizedBox(height: 14),
                AppDropdownField(
                  hint: 'Select Gender',
                  value: _gender,
                  options: const ['Male', 'Female', 'Other'],
                  onChanged: (value) => setState(() => _gender = value),
                ),
                const SizedBox(height: 14),
                AppTextField(hint: _isLawyer ? 'Phone number with country code (+91)' : 'Phone'),
                const SizedBox(height: 14),
                Row(
                  children: [
                    const Expanded(child: AppTextField(hint: 'Enter OTP')),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 128,
                      child: PrimaryButton(
                        label: 'Get OTP',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('OTP request ready to connect to API')),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                if (!_isLawyer) ...[
                  const AppTextField(hint: 'Email', keyboardType: TextInputType.emailAddress),
                  const SizedBox(height: 14),
                  const AppTextField(hint: 'Address'),
                  const SizedBox(height: 14),
                ],
                if (_isLawyer) ...[
                  const AppTextField(hint: 'Enter your bio', maxLines: 2),
                  const SizedBox(height: 14),
                  const AppTextField(hint: 'Bar Council ID'),
                  const SizedBox(height: 14),
                  AppDropdownField(
                    hint: 'Area Of Expertize',
                    subHint: 'Select an area of expertise',
                    value: _expertise,
                    options: const ['Civil', 'Criminal', 'Family', 'Corporate'],
                    onChanged: (value) => setState(() => _expertise = value),
                  ),
                  const SizedBox(height: 14),
                  const AppTextField(hint: 'Experience in years', keyboardType: TextInputType.number),
                  const SizedBox(height: 14),
                  const AppTextField(hint: 'Enter Office Address'),
                  const SizedBox(height: 26),
                  AvailabilityField(days: _availableDays, onTap: _showAvailabilityDialog),
                  const SizedBox(height: 26),
                  CourtField(value: _court, onTap: _showCourtDialog),
                  const SizedBox(height: 14),
                ],
                const AppTextField(hint: 'Password', obscureText: true),
                const SizedBox(height: 14),
                const AppTextField(hint: 'Confirm Password', obscureText: true),
                const SizedBox(height: 20),
                TermsCheck(
                  value: _acceptedTerms,
                  onChanged: (value) => setState(() => _acceptedTerms = value ?? false),
                ),
                const SizedBox(height: 20),
                PrimaryButton(label: _isLawyer ? 'Register' : 'Create Account', onPressed: _register),
                const SizedBox(height: 14),
                if (_isLawyer)
                  SecondaryButton(
                    label: 'Already have an account? Login',
                    onPressed: () => Navigator.of(context).pop(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
