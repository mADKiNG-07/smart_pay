import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingOne extends StatelessWidget {
  const OnboardingOne({super.key});

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              children: [
                buildPage(
                  context,
                  'assets/device.png',
                  'assets/illustration.png',
                  "Finance app the safest and most trusted",
                  "Your finance work starts here. Our here to help you track and deal with speeding up your transactions.",
                ),
                buildPage(
                  context,
                  'assets/image2.png', // Replace with another image
                  'assets/illustration4.png', // Replace with another image
                  "The fastest transaction process only here",
                  "Get easy to pay all your bills with just a few steps. Paying your bills become fast and efficient.",
                ),
                // Add more pages as needed
              ],
            ),
          ),
          SmoothPageIndicator(
            controller: pageController,
            count: 2, // Update this to the number of pages you have
            effect: const ExpandingDotsEffect(
              dotWidth: 10.0,
              dotHeight: 10.0,
              expansionFactor: 3.0, // Makes the active dot wider
              spacing: 5.0,
              dotColor: Color.fromRGBO(229, 231, 235, 1),
              activeDotColor: Color.fromRGBO(17, 24, 39, 1),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: 300,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Button action
                Navigator.pushNamed(
                  context,
                  '/sign_up',
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(17, 24, 39, 1),
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                elevation: 0,
              ),
              child: Text(
                'Get Started',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(
              height: 50), // Add spacing to adjust the button position
        ],
      ),
    );
  }

  Widget buildPage(BuildContext context, String deviceImage,
      String illustrationImage, String title, String subtitle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: double.maxFinite,
          height: 500,
          child: Center(
            child: Stack(
              children: [
                Positioned(
                  left: 30,
                  child: Container(
                    child: Image.asset(
                      deviceImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  child: Container(
                    child: Image.asset(
                      illustrationImage,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          child: Column(
            children: [
              Container(
                width: 300,
                child: Column(
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                        color: const Color.fromRGBO(17, 24, 39, 1),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: const Color.fromRGBO(17, 24, 39, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
