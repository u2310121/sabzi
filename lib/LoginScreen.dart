import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    phoneFocusNode.addListener(_onFocusChange);
    passwordFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    phoneFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'LOGO',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      maxLength: 9,
                      controller: phoneController,
                      focusNode: phoneFocusNode,
                      decoration: InputDecoration(
                        labelText: 'Phone number',
                        prefixText: '+998',
                        counterText: '',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: passwordController,
                      focusNode: passwordFocusNode,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'parolni unutdim',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: Submitdata,
                      child: Text('kirish'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text("Ro'yxatdan o'tish"),
                    ),
                    SizedBox(height: 20),
                    Text(
                      phoneFocusNode.hasFocus || passwordFocusNode.hasFocus
                          ? 'Keyboard is visible'
                          : 'Keyboard is hidden',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> Submitdata() async {
    final phone = '998' + phoneController.text; // Correct concatenation
    final password = passwordController.text;
    final body = {"phone": phone, "password": password};
    const url = 'https://api.sabzi.uz/api/v1/login/';
    final uri = Uri.parse(url);
    final response = await https.post(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final token = responseData['token']['access'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);
      Navigator.pushNamed(context, '/white');
      ;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid phone number or password.')));
    }
  }
}
