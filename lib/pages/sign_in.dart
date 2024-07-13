import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_pay/auth/service.dart';
import 'package:smart_pay/common/textarea.dart';
import 'package:smart_pay/common/textarea_password.dart';
import 'package:smart_pay/pages/home.dart';

class Sign_In extends StatelessWidget {
  Sign_In({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthService authService = AuthService();

  void signIn(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;
    try {
      final data = await authService.login(email: email, password: password);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      Text(
                        'Hi There! 👋',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w700,
                          fontSize: 34,
                          color: const Color.fromRGBO(17, 24, 39, 1),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Welcome back, Sign in to your account',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: const Color.fromRGBO(17, 24, 39, 1),
                        ),
                      ),
                      const SizedBox(height: 25),
                      CustomTextArea(
                        hintText: "Email",
                        controller: emailController,
                        obscureText: false,
                        onChanged: null,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextArea_Password(
                        hintText: "Password",
                        controller: passwordController,
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Forgot Password?',
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: const Color.fromRGBO(10, 99, 117, 1)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.maxFinite,
                        child: ElevatedButton(
                          onPressed: () => signIn(context),
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
                            'Sign In',
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
                            const SizedBox(width: 10),
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
                            "Don't have an account? ",
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
                              Navigator.pushNamed(context, '/sign_up');
                            },
                            child: Text(
                              "Sign Up",
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
