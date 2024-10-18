import 'package:flutter/material.dart';

class DriverDashboardPage extends StatefulWidget {
  final String username;

  const DriverDashboardPage({Key? key, required this.username})
      : super(key: key);

  @override
  _DriverDashboardPageState createState() => _DriverDashboardPageState();
}

class _DriverDashboardPageState extends State<DriverDashboardPage> {
  bool viewMore = false; // To track whether to show the blurred cards or not

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Text(
                'Welcome, ${widget.username}',
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
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
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Container(
            height: 200,
            child: PageView(
              children: [
                Image.network('https://via.placeholder.com/400x200?text=Car+1'),
                Image.network('https://via.placeholder.com/400x200?text=Car+2'),
                Image.network('https://via.placeholder.com/400x200?text=Car+3'),
                Image.network('https://via.placeholder.com/400x200?text=Car+4'),
                Image.network('https://via.placeholder.com/400x200?text=Car+5'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
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
                  itemCount: viewMore ? 6 : 4, // Show 4 cards, then 6 after view more
                  itemBuilder: (context, index) {
                    if (!viewMore && index >= 4) {
                      return Stack(
                        children: [
                          Card(
                            child: Center(
                              child: Text('Item ${index + 1}'),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Card(
                        child: Center(child: Text('Item ${index + 1}')),
                      );
                    }
                  },
                ),
                if (!viewMore)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          viewMore = true; // Show the remaining cards
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
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.contact_phone),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
