import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:emailjs/emailjs.dart' as emailjs;
import 'dart:io' show Platform;

class AuthService {
  // environment variables
  final String baseUrl = dotenv.env['BASE_API_URL']!;
  final String serviceid = dotenv.env['SERVICE_ID']!;
  final String templateid = dotenv.env['TEMPLATE_ID']!;
  final String publickey = dotenv.env['PUBLIC_KEY']!;
  final String privatekey = dotenv.env['PRIVATE_KEY']!;

  // Using flutter_secure_storage package to store the PIN securely.
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  // get email token
  Future<Map<String, dynamic>> getEmailToken({
    required String email,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/email'),
      headers: {'Accept': 'application/json'},
      body: {'email': email},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['status']) {
        final token = responseData['data']['token'];
        // using sharedPreference to store the email and otp(token)
        final prefs = await SharedPreferences.getInstance();
        // await prefs.setString('otp', token);
        await prefs.setString('email', email);
        //send mail
        sendEmail(email: email, message: token);
        return responseData['data'];
      } else {
        throw Exception(responseData['message']);
      }
    } else {
      throw Exception('Failed to get email token');
    }
  }

// email service to send verification to the user (email js)
  Future sendEmail({
    required String email,
    required String message,
  }) async {
    Map<String, dynamic> templateParams = {
      'user_subject': "Verification Token",
      'message': 'Your verification token is $message',
      'reply_to': '',
      'email': email
    };

    try {
      await emailjs.send(
        serviceid,
        templateid,
        templateParams,
        emailjs.Options(
          publicKey: publickey,
          privateKey: privatekey,
        ),
      );
      // print('SUCCESS!');
    } catch (error) {
      // print('$error');
    }
  }

  // verify email token
  Future<Map<String, dynamic>> verifyEmailToken({
    required String token,
  }) async {
    // checks and retrieve email from shared preferences
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');

    final response = await http.post(
      Uri.parse('$baseUrl/auth/email/verify'),
      headers: {'Accept': 'application/json'},
      body: {'email': email, 'token': token},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['status']) {
        return responseData['data'];
      } else {
        throw Exception(responseData['message']);
      }
    } else {
      throw Exception('Failed to verify email token');
    }
  }

  // get device platform
  String getDevicePlatform() {
    if (Platform.isAndroid) {
      return 'Android';
    } else if (Platform.isIOS) {
      return 'iOS';
    } else if (Platform.isWindows) {
      return 'Windows';
    } else if (Platform.isMacOS) {
      return 'macOS';
    } else if (Platform.isLinux) {
      return 'Linux';
    } else {
      return 'Unknown';
    }
  }

  // register
  Future<Map<String, dynamic>> register({
    required String fullName,
    required String username,
    // required String email,
    required String country,
    required String password,
    // required String deviceName,
  }) async {
    // checks and retrieve email from shared preferences
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');

    // Determine the device platform
    final deviceName = getDevicePlatform();

    // post request to register (email verified) user
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Accept': 'application/json'},
      body: {
        'full_name': fullName.toString(),
        'username': username.toString(),
        'email': email.toString(),
        'country': country.toString(),
        'password': password.toString(),
        'device_name': deviceName,
      },
    );

    // checking response status
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['status']) {
        // using sharedPreference to store the token if registration is successful
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', responseData['data']['token']);

        return responseData['data']['user'];
      } else {
        // throws exception if registration is unsuccessful
        throw Exception(responseData['message']);
      }
    } else {
      throw Exception('Failed to register');
    }
  }

  // login
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
    // required String deviceName,
  }) async {
    // Determine the device platform
    final deviceName = getDevicePlatform();

    // post request to login a user
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Accept': 'application/json'},
      body: {
        'email': email,
        'password': password,
        'device_name': deviceName,
      },
    );

    // checking response status
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['status']) {
        // using sharedPreference to store the token if login is successful
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', responseData['data']['token']);
        return responseData['data']['user'];
      } else {
        // throws exception if login is unsuccessful
        throw Exception(responseData['message']);
      }
    } else {
      throw Exception('Failed to login');
    }
  }

  // auth instance
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('token');
  }

  // logout
  Future<void> logout() async {
    // checks and retrieve token from shared preferences
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      // request to logout
      final response = await http.post(
        Uri.parse('$baseUrl/auth/logout'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status']) {
          // remove (delete) token from shared preferences
          await prefs.remove('token');
          await prefs.remove('email');
        } else {
          throw Exception(responseData['message']);
        }
      } else {
        throw Exception('Failed to logout');
      }
    } else {
      throw Exception('No token found');
    }
  }

  // set pin
  Future<void> setPin(String pin) async {
    await secureStorage.write(key: 'pin', value: pin);
  }

  // get pin
  Future<String?> getPin() async {
    return await secureStorage.read(key: 'pin');
  }

// login with pin
  Future<Map<String, dynamic>> pinLogin(String pin) async {
    final storedPin = await getPin();
    if (storedPin == pin) {
      // retreive stored token from shared preferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token != null) {
        // Fetch secret mesesage using the stored token
        final response = await http.get(
          Uri.parse('$baseUrl/dashboard'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          if (responseData['status']) {
            return responseData['data'];
          } else {
            throw Exception(responseData['message']);
          }
        } else {
          throw Exception('Failed to fetch secret message');
        }
      } else {
        throw Exception('No token found');
      }
    } else {
      throw Exception('Invalid PIN');
    }
  }

  // home (dashboard)
  Future<Map<String, dynamic>> home() async {
    // retreive stored token from shared preferences
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      // Fetch user data using the stored token
      final response = await http.get(
        Uri.parse('$baseUrl/dashboard'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status']) {
          return responseData['data'];
        } else {
          throw Exception(responseData['message']);
        }
      } else {
        throw Exception('Failed to fetch secret message');
      }
    } else {
      throw Exception('No token found');
    }
  }
}
