
import 'package:flutter/material.dart';
// import './admin/first.dart'; // Import the AdminPage
import './pages/userPage.dart';

class HomeScreen extends StatefulWidget {
  final String userName; // Variable to hold the user's name

  HomeScreen({required this.userName}); // Constructor to accept the user's name

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MyApp();
  }
}
