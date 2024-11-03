import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

// Assuming CustomLayoutPage is already defined
import 'like.dart';

class OwnerDashboardPage extends StatefulWidget {
  final String ownerName;

  const OwnerDashboardPage({Key? key, required this.ownerName}) : super(key: key);

  @override
  _OwnerDashboardPageState createState() => _OwnerDashboardPageState();
}

class _OwnerDashboardPageState extends State<OwnerDashboardPage> {
  int _selectedIndex = 0; // Track the selected index for navigation
  bool _filterByAge = false; // Checkbox state for Age
  bool _filterByLocation = false; // Checkbox state for Location

  void _showFilterBar() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ensure the modal doesn't take up full height
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Filter Options',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Age filter checkbox
              CheckboxListTile(
                title: const Text('Filter by Age'),
                value: _filterByAge,
                onChanged: (bool? value) {
                  setState(() {
                    _filterByAge = value ?? false;
                  });
                },
              ),
              // Location filter checkbox
              CheckboxListTile(
                title: const Text('Filter by Location'),
                value: _filterByLocation,
                onChanged: (bool? value) {
                  setState(() {
                    _filterByLocation = value ?? false;
                  });
                },
              ),
              const SizedBox(height: 16),
              // Apply button
              ElevatedButton(
                onPressed: () {
                  // Apply filter logic based on selected checkboxes
                  Navigator.pop(context); // Close the modal
                },
                child: const Text('Apply Filters'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onNavigationItemSelected(int index) {
    setState(() {
      _selectedIndex = index; // Update selected index
    });

    // Navigate to CustomLayoutPage when the favorite icon is selected
    if (index == 3) { // Assuming favorite icon is at index 3
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CustomLayoutPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120, // Reduced height as buttons are moved outside
        flexibleSpace: Container(
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
        ),
        title: Text(
          'Welcome, ${widget.ownerName}',
          style: const TextStyle(fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16), // Add spacing before the buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Notification Icon with white circle
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white, // White background
                ),
                child: IconButton(
                  icon: const Icon(Icons.notifications, color: Colors.black), // Black icon color
                  onPressed: () {
                    // Handle notification button press
                  },
                ),
              ),
              const SizedBox(width: 16), // Add spacing between the buttons
              // Filter Icon with white circle
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white, // White background
                ),
                child: IconButton(
                  icon: const Icon(Icons.filter_list, color: Colors.black), // Black icon color
                  onPressed: () {
                    _showFilterBar(); // Show the filter pop-up bar
                  },
                ),
              ),
              const SizedBox(width: 16), // Add spacing between the buttons
            ],
          ),
          // Search bar is now always visible
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          // Add other body content here
        ],
      ),
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          CurvedNavigationBar(
            index: _selectedIndex,
            items: <Widget>[
              Icon(Icons.home, size: 30),
              Icon(Icons.person, size: 30),
              Icon(Icons.business, size: 30),
              Icon(Icons.favorite, size: 30),
            ],
            color: const Color(0xFF7247FF),
            buttonBackgroundColor: const Color.fromARGB(255, 175, 129, 255),
            backgroundColor: const Color.fromARGB(255, 255, 253, 253),
            onTap: _onNavigationItemSelected, // Updated to use custom function
          ),
          Positioned(
            top: -30, // Adjust this value to position the button above the navigation bar
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              shape: const CircleBorder(), // Ensures the button is circular
              onPressed: () {
                // Handle the "+" button action here
              },
              child: const Icon(Icons.add, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
