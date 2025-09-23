import 'package:flutter/material.dart';
import 'main_app_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Widget> _onboardingPages = [
    const OnboardingPage1(),
    const OnboardingPage2(),
    const OnboardingPage3(),
    const OnboardingPage4(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: _onboardingPages,
          ),
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _onboardingPages.length,
                (index) => Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? const Color(0xFF38E07B)
                        : const Color(0xFF4A5C53),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  if (_currentPage < _onboardingPages.length - 1) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainAppScreen(),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF38E07B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: Text(
                  _currentPage < _onboardingPages.length - 1
                      ? 'Continue'
                      : 'Get Started',
                  style: const TextStyle(
                    color: Color(0xFF111714),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF16A34A), Color(0xFF1D4ED8)],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.favorite,
              color: Colors.white,
              size: 48,
            ),
            const SizedBox(height: 16),
            const Text(
              'NGO Connect',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1A2521),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.network(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuCBVB4Nb6IFmebi10-IM54dGMwJqeC1MVVhPC4816c2ImKuEZC8qRqTo8pwhmtoIWtal5qkiBLcHplfhMw0WzxThIjxWhLWjLCxXgVvaagDDBpea71r9sUQSlPpHt6xhstXcHhiRrzs7eifsbZyB69Oo63TMe0T9NXvCWTmdccGSYQXfC-M9uxDSHDCXSEGW4wEykwZtIoZs-fx-3n7BP0JiViqqStDphgMsZ6FE8PStYWUz7a1OKucHRN6DfhnfEwMhVBsTgUc8BE',
                width: 300,
                height: 300,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 40),
            decoration: const BoxDecoration(
              color: Color(0xFF111714),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(48),
                topRight: Radius.circular(48),
              ),
            ),
            child: Column(
              children: [
                const Text(
                  'Connect, Contribute, Change Lives',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Find and join volunteer opportunities that match your skills and interests, or request assistance for community services.',
                  style: TextStyle(
                    color: Color(0xFF9EB7A8),
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1A202C),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuA-z6JGd6YwHJt99GmBeDzbBIEUZrObq_MQ9ky8dV0RjlG7JJGu0vua9FhTUocLnDX-fnc0wmpLlHgtJYJvFDgbfSI6rChcZEfwc-Fju7UNrDkdRcpS1oFu7_WeQi4SqVtB-zOvE0mV6IYjVUkoArUm1_1P2BUGZnviaQxe5fQshke_31cQZXo5cr3o3KhMuUnxTp02ceqe1uqVczDMV5Tm0HYhWzg25XBCR3gZWEmng1uRGNamTpH7Nwe7Lueqy74e3GUYcDeDSbg',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Find Your Perfect Volunteer Match',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Connect with organizations that align with your passions and skills, making a meaningful impact on causes you care about.',
                    style: TextStyle(
                      color: Color(0xFFA0AEC0),
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage4 extends StatelessWidget {
  const OnboardingPage4({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF111714),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.network(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuBYPm22L9XzxXsiuDtocYOqAN8p1JVuciK7UHaVXSqUHrPorSgtLByd6CTaeYgkbpvQEqsijK3E11QRCo-FItSfcQ3sizanPjYaD_oPJfVDHs7KgeydSIr_3YLmHd7ReqaafOjMns0bVOWWKZALNCaCrKXLyGV7vbtse_Q6OCqU0Kf1YEsvp7SUgNez7hmdBa9XU6OGeNtqLyCeEfgG-N0i6S2csnXG2ctaXBXDar1mUeAJIZPJre2tXtDVUD-OdUvx_BLQYelfyjY',
                width: 300,
                height: 300,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF4A5568),
                      ),
                    ),
                    Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF4A5568),
                      ),
                    ),
                    Container(
                      width: 10,
                      height: 10,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF38E07B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                const Text(
                  'Connect, Contribute, and Make a Difference',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Join a network of volunteers, NGOs, and service seekers. Find opportunities, share your skills, and create positive change in your community.',
                  style: TextStyle(
                    color: Color(0xFF9EB7A8),
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
