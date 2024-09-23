import 'package:client/components/CarouselHome.dart';
import 'package:client/screen/PostCreateScreen.dart';
import 'package:client/screen/ProfileScreen.dart';
import 'package:client/screen/SearchScreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  // List of widgets to display for each tab
  final List<Widget> _pages = [
    Center(child: Text("")), // Home
    Center(child: Text('')), // Search
    Center(child: Text('')), // Profile
    Center(child: Text('')), // Profile
    Center(child: Text('Settings Screen')), // Settings
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          // Conditionally display the image if the Home Screen is selected
          if (selectedIndex == 0)
            Container(
              width: screenWidth,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
                child: Image.asset(
                  'assets/images/image02.png', // Replace with your image path
                  width: screenWidth,
                  height: screenHeight * 0.4,
                  fit: BoxFit.fill,
                ),
              ),
            ),

          // Second section
          if (selectedIndex == 0)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Text(
                      'Welcome to the Wedding Planner App',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 54, 54, 54),
                        letterSpacing: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),

          // Conditional widgets based on selectedIndex
          if (selectedIndex == 0) const Expanded(child: CarouselHome()),
          if (selectedIndex == 2) const Expanded(child: PostCreateScreen()),
          if (selectedIndex == 1) const Expanded(child: SearchScreen()),
          if (selectedIndex == 3) const Expanded(child: ProfileScreen()),

          // Expanded to fill the rest of the screen with the selected page content
          if (selectedIndex != 0 && selectedIndex != 2 && selectedIndex != 1 && selectedIndex != 3)
            Expanded(child: _pages[selectedIndex]),
        ],
      ),

      floatingActionButton: SizedBox(
        width: 60,
        height: 60,
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              selectedIndex = 2;
            });
          },
          child: const Icon(
            Icons.add,
            size: 30,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                _onItemTapped(0);
              },
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                _onItemTapped(1);
              },
            ),
            const SizedBox(width: 60), // Empty space for the FAB
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                _onItemTapped(3);
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                _onItemTapped(4);
              },
            ),
          ],
        ),
      ),
    );
  }
}
