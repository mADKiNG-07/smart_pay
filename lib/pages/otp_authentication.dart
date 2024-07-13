import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:smart_pay/auth/service.dart';
import 'package:smart_pay/pages/id.dart';

class OTP_Authentication extends StatefulWidget {
  const OTP_Authentication({super.key});

  @override
  State<OTP_Authentication> createState() => _OTP_AuthenticationState();
}

class _OTP_AuthenticationState extends State<OTP_Authentication> {
  TextEditingController textEditingController = TextEditingController();

  final AuthService authService = AuthService();

  void verifyEmailToken() async {
    String token = textEditingController.text;
    try {
      final data = await authService.verifyEmailToken(token: token);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ID(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

                      Text(
                        'Verify it\'s you',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w700,
                          fontSize: 34,
                          color: const Color.fromRGBO(17, 24, 39, 1),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'We send a code to (',
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                                color: const Color.fromRGBO(17, 24, 39, 1),
                              ),
                            ),
                            TextSpan(
                              text: '*****@mail.com',
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: const Color.fromRGBO(17, 24, 39, 1),
                              ),
                            ),
                            TextSpan(
                              text: '). Enter it here to verify your identity ',
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                                color: const Color.fromRGBO(17, 24, 39, 1),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      //** otp field
                      Form(
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              // horizontal: 30,
                              ),
                          child: PinCodeTextField(
                            appContext: context,
                            pastedTextStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            length: 5,
                            textStyle: GoogleFonts.roboto(
                              fontSize: 25,
                            ),
                            obscureText: false,

                            animationType: AnimationType.fade,

                            pinTheme: PinTheme(
                              activeColor: Colors.transparent,
                              selectedColor: Colors.transparent,
                              inactiveColor: Colors.transparent,
                              errorBorderColor: Colors.transparent,
                              shape: PinCodeFieldShape.box,
                              inactiveBorderWidth: 0,
                              inactiveFillColor:
                                  const Color.fromRGBO(249, 250, 251, 1),
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 50,
                              fieldWidth: 50,
                              selectedFillColor:
                                  const Color.fromRGBO(249, 250, 251, 1),
                              activeFillColor: Color.fromRGBO(249, 250, 251, 1),
                            ),
                            cursorColor: Colors.black,
                            animationDuration:
                                const Duration(milliseconds: 300),
                            enableActiveFill: true,
                            errorAnimationController: errorController,

                            controller: textEditingController,
                            keyboardType: TextInputType.number,
                            boxShadows: const [
                              BoxShadow(
                                offset: Offset(0, 1),
                                color: Colors.black12,
                                blurRadius: 10,
                              )
                            ],
                            onCompleted: (v) {
                              debugPrint("Completed");
                            },
                            // onTap: () {
                            //   print("Pressed");
                            // },
                            onChanged: (value) {
                              debugPrint(value);
                              setState(() {
                                currentText = value;
                              });
                            },
                            beforeTextPaste: (text) {
                              debugPrint("Allowing to paste $text");
                              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                              //but you can show anything you want here, like your pop up saying wrong paste format or etc
                              return true;
                            },
                          ),
                        ),
                      ),
                      // **

                      const SizedBox(
                        height: 15,
                      ),

                      Container(
                        width: double.maxFinite,
                        child: ElevatedButton(
                          onPressed: verifyEmailToken,
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
                            'Confirm',
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
