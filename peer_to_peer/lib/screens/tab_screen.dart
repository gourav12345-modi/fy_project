import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:peer_to_peer/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:peer_to_peer/screens/chat_home_screen.dart';
import 'package:peer_to_peer/screens/home_screen.dart';
import 'package:peer_to_peer/screens/profile_screen.dart';
import 'package:peer_to_peer/screens/recommendation_screen.dart';
import 'package:peer_to_peer/screens/search_screen.dart';
import '../constants.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedIndex = 0;
  final List<Widget> _tabs = [
    HomeScreen(),
    ChatHomeScreen(),
    RecommendationScreen(),
    // SearchScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottom bar
      // now we will use bottom bar package
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _selectedIndex,
        showElevation: true, // use this to remove appBar's elevation
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: [
          BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              activeColor: kpink,
              inactiveColor: Colors.grey[300]),
          BottomNavyBarItem(
            icon: Icon(Icons.message),
            title: Text('Chat'),
            inactiveColor: Colors.grey[300],
            activeColor: kpink,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.group),
            title: Text('Recommendation'),
            inactiveColor: Colors.grey[300],
            activeColor: kpink,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
            inactiveColor: Colors.grey[300],
            activeColor: kpink,
          ),
        ],
      ),
      body: _tabs[_selectedIndex],
    );
  }
}
