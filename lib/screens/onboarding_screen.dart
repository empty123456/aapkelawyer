import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/legal_illustration.dart';
import 'welcome_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _page = 0;

  final List<OnboardingPageData> _pages = const [
    OnboardingPageData(
      title: 'Welcome to AapkeLawyer',
      subtitle: 'Find trusted lawyers for any court, anytime, anywhere.',
      background: Colors.white,
      art: LegalArt.handshake,
    ),
    OnboardingPageData(
      title: 'Choose Your Role',
      subtitle: "Whether you're a lawyer or someone seeking legal help.",
      background: Color(0xFFFFF5EF),
      art: LegalArt.access,
    ),
    OnboardingPageData(
      title: 'Services for All Courts',
      subtitle: 'Civil, Criminal, Family, Corporate - we cover it all.',
      background: Color(0xFFEFF4FF),
      art: LegalArt.security,
    ),
    OnboardingPageData(
      title: "Let's Get Started",
      subtitle: 'Sign up now and connect with legal professionals.',
      background: Colors.white,
      art: LegalArt.logo,
    ),
  ];

  void _openWelcome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: _pages.length,
        onPageChanged: (value) => setState(() => _page = value),
        itemBuilder: (context, index) => OnboardingPage(data: _pages[index]),
      ),
      bottomNavigationBar: Container(
        height: 96,
        color: const Color(0xFFE8E8E8),
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Row(
          children: [
            TextButton(
              onPressed: _openWelcome,
              child: const Text(
                'Skip',
                style: TextStyle(color: kBrown, fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            const Spacer(),
            Row(
              children: List.generate(
                _pages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 9,
                  height: 9,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: index == _page ? Colors.black87 : Colors.black26,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                if (_page == _pages.length - 1) {
                  _openWelcome();
                  return;
                }
                _controller.nextPage(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                );
              },
              child: Text(
                _page == _pages.length - 1 ? 'Done' : 'Next',
                style: const TextStyle(color: kBrown, fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPageData {
  const OnboardingPageData({
    required this.title,
    required this.subtitle,
    required this.background,
    required this.art,
  });

  final String title;
  final String subtitle;
  final Color background;
  final LegalArt art;
}

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key, required this.data});

  final OnboardingPageData data;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: data.background,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            children: [
              const Spacer(flex: 2),
              LegalIllustration(type: data.art, size: 280),
              const SizedBox(height: 58),
              Text(
                data.title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 22),
              Text(
                data.subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Color(0xFF4D4D4D), fontSize: 22, height: 1.25),
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
