import 'package:flutter/material.dart';
import 'package:lorry/pages/owner_dashboard_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';
import 'driver_dashboard_page';
import 'owner_dashboard_page';

//hello vishnu
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      home: SplashScreen(), // Add a splash screen for checking login
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accountType = prefs.getString('accountType');
    String? phoneNumber = prefs.getString('phoneNumber');

    if (accountType != null && phoneNumber != null) {
      // User has already logged in
      if (accountType == 'Driver') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DriverDashboardPage()),
        );
      } else if (accountType == 'Owner') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OwnerDashboardPage()),
        );
      }
    } else {
      // User needs to log in or create an account
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Simple loading spinner
      ),
    );
  }
}
