import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_pay/auth/service.dart';
import 'package:smart_pay/common/textarea.dart';
import 'package:smart_pay/pages/otp_authentication.dart';

class Sign_Up extends StatefulWidget {
  const Sign_Up({super.key});

  @override
  State<Sign_Up> createState() => _Sign_UpState();
}

class _Sign_UpState extends State<Sign_Up> {
  final TextEditingController emailController = TextEditingController();

  final AuthService authService = AuthService();

  void getEmailToken() async {
    String email = emailController.text;
    try {
      final data = await authService.getEmailToken(email: email);
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text('Token sent to $email')));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const OTP_Authentication(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    // controllers

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      // ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Padding(
              padding: EdgeInsets.only(
                left: 25.0,
                right: 25.0,
                top: MediaQuery.of(context).size.height * 0.1,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color: Colors.grey, width: 1)),
                          child: const FaIcon(
                            FontAwesomeIcons.chevronLeft,
                            size: 15,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Create a ',
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w700,
                                fontSize: 34,
                                color: const Color.fromRGBO(17, 24, 39, 1),
                              ),
                            ),
                            TextSpan(
                              text: 'SmartPay',
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w700,
                                fontSize: 34,
                                color: const Color.fromRGBO(10, 99, 117, 1),
                              ),
                            ),
                            TextSpan(
                              text: ' account',
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w700,
                                fontSize: 34,
                                color: const Color.fromRGBO(17, 24, 39, 1),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      //** email textfield
                      CustomTextArea(
                        hintText: "Email",
                        controller: emailController,
                        obscureText: false,
                        onChanged: null,
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      Container(
                        width: double.maxFinite,
                        child: ElevatedButton(
                          onPressed: getEmailToken,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(17, 24, 39, 1),
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Sign Up',
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      Container(
                        width: double.maxFinite,
                        child: Text(
                          'OR',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                              // fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: const Color.fromRGBO(107, 114, 128, 1)),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      Container(
                        width: double.maxFinite,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  border: Border.all(
                                    color:
                                        const Color.fromRGBO(229, 231, 235, 1),
                                  ),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Button action
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    elevation: 0,
                                  ),
                                  child: Image.asset('assets/search1.png'),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10), // Space between buttons
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  border: Border.all(
                                    color:
                                        const Color.fromRGBO(229, 231, 235, 1),
                                  ),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Button action
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    elevation: 0,
                                  ),
                                  child: Image.asset('assets/Apple.png'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              color: const Color.fromRGBO(
                                107,
                                114,
                                128,
                                1,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/sign_in');
                            },
                            child: Text(
                              "Sign In",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: const Color.fromRGBO(10, 99, 117, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
