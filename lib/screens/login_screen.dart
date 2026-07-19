import 'package:flutter/material.dart';

import '../models/user_role.dart';
import 'register_screen.dart';
import '../theme/app_colors.dart';
import '../widgets/app_buttons.dart';
import '../widgets/app_form_fields.dart';
import '../widgets/legal_illustration.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.role});

  final UserRole role;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _login() {
    if (!_formKey.currentState!.validate()) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.role.label} login ready to connect to API')),
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
                LegalIllustration(
                  type: widget.role == UserRole.client ? LegalArt.security : LegalArt.access,
                  size: 280,
                ),
                const SizedBox(height: 38),
                Text(
                  'Login as ${widget.role.label}',
                  style: const TextStyle(color: kBrown, fontSize: 30, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 30),
                const AppTextField(hint: 'Email', keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 18),
                const AppTextField(hint: 'Password', obscureText: true),
                const SizedBox(height: 20),
                PrimaryButton(label: 'Login', onPressed: _login),
                const SizedBox(height: 16),
                SecondaryButton(
                  label: 'Create Account',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => RegisterScreen(role: widget.role)),
                    );
                  },
                ),
                const SizedBox(height: 26),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Forgot password flow pending')),
                    );
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.black54, fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
