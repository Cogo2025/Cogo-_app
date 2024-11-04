<<<<<<< HEAD
import 'package:flutter/material.dart';

class OwnerDashboardPage extends StatefulWidget {
  final String username;

  const OwnerDashboardPage({Key? key, required this.username}) : super(key: key);

  @override
  _OwnerDashboardPageState createState() => _OwnerDashboardPageState();
}

class _OwnerDashboardPageState extends State<OwnerDashboardPage> {
  bool viewMore = false;
  bool _showSearchBar = false;
  List<String> items = List.generate(8, (index) => 'Item ${index + 1}');
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _showSearchBar ? 160 : 120,
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
        title: Row(
          children: [
            Expanded(
              child: Text(
                'Welcome, ${widget.username}',
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: IconButton(
                icon: const Icon(Icons.notifications, color: Colors.black),
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 8),
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: IconButton(
                icon: const Icon(Icons.search, color: Colors.black),
                onPressed: () {
                  setState(() {
                    _showSearchBar = !_showSearchBar;
                  });
                },
              ),
            ),
          ],
        ),
        bottom: _showSearchBar
            ? PreferredSize(
                preferredSize: const Size.fromHeight(48.0),
                child: Padding(
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
              )
            : null,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Container(
              height: 200,
              child: PageView(
                children: [
                  _buildImagePlaceholder('Asset 1'),
                  _buildImagePlaceholder('Asset 2'),
                  _buildImagePlaceholder('Asset 3'),
                  _buildImagePlaceholder('Asset 4'),
                  _buildImagePlaceholder('Asset 5'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 400,
              child: Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    itemCount: viewMore ? items.length : (items.length > 6 ? 6 : items.length),
                    itemBuilder: (context, index) {
                      return _buildGridItem(index);
                    },
                  ),
                  if (!viewMore)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            viewMore = true;
                          });
                        },
                        child: const Text('View More'),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: const Color(0xFF7247FF),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home, color: Colors.black),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.favorite, color: Colors.black),
              onPressed: () {},
            ),
            const SizedBox(width: 40), // Space for the FloatingActionButton
            IconButton(
              icon: const Icon(Icons.shopping_cart, color: Colors.black),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.person, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Colors.black, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 175, 129, 255),
              ),
              child: Text(
                'Owner Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder(String text) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          'https://via.placeholder.com/400x200?text=$text',
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                    : null,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.error)),
        ),
      ),
    );
  }

  Widget _buildGridItem(int index) {
    if (index < 0 || index >= items.length) return const SizedBox();

    return Card(
      elevation: 4,
      child: Center(
        child: Text(items[index], style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
=======
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
>>>>>>> db5e42d37affc2a55aa5f9ee24c091cd3d0b417b
