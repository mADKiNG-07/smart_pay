import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Confirmation extends StatelessWidget {
  const Confirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/thumb_up.png',
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Congratulations',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                  color: const Color.fromRGBO(17, 24, 39, 1),
                ),
              ),
              Container(
                width: 250,
                child: Text(
                  'You’ve completed the onboarding, you can start using',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: const Color.fromRGBO(17, 24, 39, 1),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 250,
                child: ElevatedButton(
                  onPressed: () {
                    // Button action
                    Navigator.pushNamed(
                      context,
                      '/home',
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
            ],
          ),
        ),
      ),
    );
  }
}
