import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // Brand Colors matching the auth screens
  static const Color _primary = Color(0xFF1E3A8A);
  static const Color _secondary = Color(0xFFF97316); // orange accent

  int _currentPage = 0;
  final PageController _pageController = PageController();

  final List<Map<String, String>> _pages = [
    {
      'title': 'Send Cargo\nEasily',
      'image': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/cb51d6c5bb-50ef3d2bdd8c9758a9e8.png',
      'description': 'Create and manage shipments quickly from your mobile phone.',
    },
    {
      'title': 'Track Your\nShipment',
      'image': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/884bfbf788-13907b83fcf2f58b724e.png',
      'description': 'Track your cargo and stay updated with delivery status.',
    },
    {
      'title': 'Fast & Reliable\nDelivery',
      'image': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/c8f31d8f68-b1768409cf2d3b7525a0.png',
      'description': 'Your cargo delivered safely and on time with our trusted network.',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      _onSkip();
    }
  }

  void _onSkip() {
    // Navigate to Login/Register Screen
    Navigator.of(context).pushReplacementNamed('/login'); // Assuming route is defined
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            children: [
              // ── TOP BAR (Progress & Skip) ──────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(
                      _pages.length,
                      (index) => Container(
                        margin: const EdgeInsets.only(right: 6),
                        width: index == _currentPage ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: index == _currentPage ? _primary : Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: _onSkip,
                    style: TextButton.styleFrom(
                      foregroundColor: _primary.withValues(alpha: 0.6),
                      textStyle: const TextStyle(
                        fontFamily: 'SF Pro Display', // Using similar requested sans font
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    child: const Text('Skip'),
                  ),
                ],
              ),
              
              const Spacer(),

              // ── PAGE VIEW CONTENT ──────────────────────────────────────────
              Expanded(
                flex: 8,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    final page = _pages[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          page['title']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontWeight: FontWeight.w700,
                            fontSize: 32, // approx 4xl
                            height: 1.2,
                            color: _primary,
                          ),
                        ),
                        const SizedBox(height: 48),
                        SizedBox(
                          height: 250,
                          child: Center(
                            child: Image.network(
                              page['image']!,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image, size: 100, color: Colors.grey),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            page['description']!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 15, // approx base
                              height: 1.5,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        const SizedBox(height: 48),
                      ],
                    );
                  },
                ),
              ),

              // ── BOTTOM BUTTON ──────────────────────────────────────────────
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _currentPage == _pages.length - 1 ? _secondary : _primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 4,
                  ),
                  child: Text(
                    _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                    style: const TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 16, // approx lg
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
