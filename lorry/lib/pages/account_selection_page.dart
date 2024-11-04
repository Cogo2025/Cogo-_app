import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'driver_dashboard_page.dart'; // Ensure these are correctly implemented
import 'owner_dashboard_page.dart';

class AccountSelectionPage extends StatelessWidget {
  final String phoneNumber;

  const AccountSelectionPage({Key? key, required this.phoneNumber}) : super(key: key);

  Future<void> _saveAccountType(String type) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accountType', type); // Save type to preferences
  }

  void _navigateToDashboard(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 114, 71, 255),
              Color.fromARGB(255, 120, 122, 255),
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Create your account as',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      await _saveAccountType('driver');
                      _navigateToDashboard(context, DriverDashboardPage());
                    },
                    child: const Text('Driver'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      await _saveAccountType('owner');
                      _navigateToDashboard(context, OwnerDashboardPage());
                    },
                    child: const Text('Owner'),
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

