import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:smart_pay/auth/service.dart';
import 'package:smart_pay/pages/confirmation.dart';

class Create_Pin extends StatefulWidget {
  const Create_Pin({super.key});

  @override
  State<Create_Pin> createState() => _Create_PinState();
}

class _Create_PinState extends State<Create_Pin> {
  TextEditingController textEditingController = TextEditingController();

  final AuthService authService = AuthService();

  void setPin() async {
    String pin = textEditingController.text;
    try {
      final data = await authService.setPin(pin);
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text('Token sent to $email')));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Confirmation(),
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
                        'Set your PIN code',
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
                        'We use state-of-the-art security measures to protect your information at all times',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: const Color.fromRGBO(17, 24, 39, 1),
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
                              activeColor: Colors.black,
                              selectedColor: Colors.black,
                              inactiveColor: Colors.black,
                              borderWidth: 2,
                              errorBorderColor: Colors.transparent,
                              shape: PinCodeFieldShape.underline,
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
                          onPressed: setPin,
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
                            'Create Pin',
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
