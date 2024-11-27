import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  Future<bool> checkToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('auth_token'); // Check if the token exists
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.data == true) {
          // Token exists, navigate to the white screen
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, '/white');
          });
        } else {
          // Token doesn't exist, navigate to the login screen
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, '/login');
          });
        }
        return SizedBox.shrink(); // Return an empty widget during navigation
      },
    );
  }
}
