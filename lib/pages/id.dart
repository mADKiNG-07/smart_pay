import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:country_picker/country_picker.dart';
import 'package:smart_pay/auth/service.dart';
import 'package:smart_pay/common/textarea.dart';
import 'package:smart_pay/common/textarea_password.dart';
import 'package:smart_pay/pages/create_pin.dart';

class ID extends StatefulWidget {
  const ID({super.key});

  @override
  State<ID> createState() => _IDState();
}

class _IDState extends State<ID> {
  String _selectedCountry = 'Select Country';
  String _selectedFlag = '';
  String _countryInitials = '';

  // controllers
  final TextEditingController fullname = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  final AuthService authService = AuthService();

  void register() async {
    String _fullname = fullname.text;
    String _username = username.text;
    String country = _countryInitials;
    String _password = password.text;

    try {
      final data = await authService.register(
        fullName: _fullname,
        username: _username,
        country: country,
        password: _password,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Create_Pin(),
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
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Hey there! tell us a bit about ',
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w700,
                                fontSize: 34,
                                color: const Color.fromRGBO(17, 24, 39, 1),
                              ),
                            ),
                            TextSpan(
                              text: 'yourself',
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w700,
                                fontSize: 34,
                                color: const Color.fromRGBO(10, 99, 117, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      // Fullname textfield
                      CustomTextArea(
                        hintText: "Full name",
                        controller: fullname,
                        obscureText: false,
                        onChanged: null,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // Username textfield
                      CustomTextArea(
                        hintText: "Username",
                        controller: username,
                        obscureText: false,
                        onChanged: null,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: double.maxFinite,
                        child: ElevatedButton(
                          onPressed: () {
                            showCountryPicker(
                              context: context,
                              showPhoneCode: false,
                              onSelect: (Country country) {
                                setState(() {
                                  _selectedCountry = country.name;
                                  _selectedFlag = country.flagEmoji;
                                  _countryInitials = country.name.length > 2
                                      ? country.name
                                          .substring(0, 2)
                                          .toUpperCase()
                                      : country.name.toUpperCase();
                                });
                              },
                              moveAlongWithKeyboard: false,
                              countryListTheme: CountryListThemeData(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40.0),
                                  topRight: Radius.circular(40.0),
                                ),
                                inputDecoration: InputDecoration(
                                  labelText: 'Search',
                                  hintText: 'Start typing to search',
                                  prefixIcon: const Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: const Color(0xFF8C98A8)
                                          .withOpacity(0.2),
                                    ),
                                  ),
                                ),
                                searchTextStyle: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(249, 250, 251, 1),
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            elevation: 0,
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 18.0, right: 18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      _selectedFlag,
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      _selectedCountry,
                                      style: GoogleFonts.roboto(
                                        color: const Color.fromRGBO(
                                            156, 163, 175, 1),
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Color.fromRGBO(156, 163, 175, 1),
                                  size: 24,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // Password textfield
                      CustomTextArea_Password(
                        hintText: "Password",
                        controller: password,
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: double.maxFinite,
                        child: ElevatedButton(
                          onPressed: register,
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
                            'Continue',
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
