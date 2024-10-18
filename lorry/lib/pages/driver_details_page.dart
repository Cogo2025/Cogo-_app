import 'package:flutter/material.dart';
import 'driver_dashboard_page.dart';

class DriverDetailsPage extends StatefulWidget {
  @override
  _DriverDetailsPageState createState() => _DriverDetailsPageState();
}

class _DriverDetailsPageState extends State<DriverDetailsPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController licenseController = TextEditingController();
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Driver Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Please enter your details', style: TextStyle(fontSize: 18, color: Colors.grey)),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: dobController,
              decoration: const InputDecoration(labelText: 'Date of Birth'),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              controller: licenseController,
              decoration: const InputDecoration(labelText: 'License Number'),
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: selectedGender,
              hint: const Text('Select Gender'),
              items: <String>['Male', 'Female', 'Other'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedGender = newValue!;
                });
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
  onPressed: () {
    // Pass the username from the text field to DriverDashboardPage
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DriverDashboardPage(
          username: nameController.text, // Pass the username here
        ),
      ),
    );
  },
  style: ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(vertical: 16),
  ),
  child: const Text('Submit', style: TextStyle(fontSize: 18)),
),

          ],
        ),
      ),
    );
  }
}
