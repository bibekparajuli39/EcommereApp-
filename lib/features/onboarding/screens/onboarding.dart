import 'package:app_project/core/constants/app_assets.dart';
import 'package:app_project/core/routes/route.dart';
import 'package:app_project/features/services/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int currentPage = 0;

  final List<String> onboardingImages = [
    AppAssets.sliderOne,
    AppAssets.sliderTwo,
    AppAssets.sliderThree,
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> finishOnboarding() async {
    await PreferencesService.setOnboardingSeen();

    if (!mounted) return;

    context.go(Routes.signup);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingImages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(20),
                    child: Image.asset(
                      onboardingImages[index],
                      fit: BoxFit.contain,
                    ),
                  );
                },
              ),
            ),

            // Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 8,
                  width: currentPage == 0 ? 24 : 8,
                  decoration: BoxDecoration(
                    color: currentPage == 0 ? Colors.blue : Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                SizedBox(width: 8),

                Container(
                  height: 8,
                  width: currentPage == 1 ? 24 : 8,
                  decoration: BoxDecoration(
                    color: currentPage == 1 ? Colors.blue : Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                SizedBox(width: 8),

                Container(
                  height: 8,
                  width: currentPage == 2 ? 24 : 8,
                  decoration: BoxDecoration(
                    color: currentPage == 2 ? Colors.blue : Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (currentPage == onboardingImages.length - 1)
                    InkWell(
                      onTap: finishOnboarding,
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 21, 97, 228),
                        ),
                      ),
                    )
                  else
                    SizedBox(),

                  // Next
                  if (currentPage < onboardingImages.length - 1)
                    InkWell(
                      onTap: () {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 21, 97, 228),
                        ),
                      ),
                    )
                  else
                    SizedBox(),
                ],
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
