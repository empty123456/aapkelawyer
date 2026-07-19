import 'package:flutter/material.dart';

import '../models/user_role.dart';
import 'login_screen.dart';
import '../theme/app_colors.dart';
import '../widgets/app_buttons.dart';
import '../widgets/legal_illustration.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  void _openLogin(BuildContext context, UserRole role) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => LoginScreen(role: role)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 34, 24, 24),
          child: Column(
            children: [
              const Spacer(),
              const LegalIllustration(type: LegalArt.handshake, size: 340),
              const SizedBox(height: 42),
              const Text(
                'WELCOME TO AAPKE LAWYER',
                textAlign: TextAlign.center,
                style: TextStyle(color: kBrown, fontSize: 28, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 18),
              const Text(
                'Discover and connect with top lawyers in your area with ease!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF6B4A32), fontSize: 20, height: 1.25),
              ),
              const SizedBox(height: 34),
              const Text('Login as ?', style: TextStyle(color: kBrown, fontSize: 24)),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoleButton(
                    icon: Icons.person,
                    label: 'CLIENT',
                    outlined: true,
                    onPressed: () => _openLogin(context, UserRole.client),
                  ),
                  const SizedBox(width: 12),
                  RoleButton(
                    icon: Icons.gavel,
                    label: 'LAWYER',
                    onPressed: () => _openLogin(context, UserRole.lawyer),
                  ),
                ],
              ),
              const Spacer(),
              const Text(
                'Terms & Conditions    |    Privacy & Policy',
                style: TextStyle(color: Colors.black54, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
