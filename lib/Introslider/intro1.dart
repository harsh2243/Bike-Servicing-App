
import 'package:flutter/material.dart';
import '../pages/login.dart'; 
import 'dart:async';

class IntroSliderScreen extends StatefulWidget {
  @override
  _IntroSliderScreenState createState() => _IntroSliderScreenState();
}

class _IntroSliderScreenState extends State<IntroSliderScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        children: <Widget>[
          _buildPage(
            title: "Welcome to MyApp!",
            description: "An amazing app for all your needs.",
            image: "assets/image/bike1.png",
          ),
          _buildPage(
            title: "Bike Servicing App",
            description: "All your bike maintenance needs in one app.",
            image: "assets/image/Bike_image.png",
          ),
          _buildPage(
            title: "Get Started Today",
            description: "Join us and make your life easier.",
            image: "assets/image/slider3.png",
            isLastPage: true,
          ),
        ],
      ),
      bottomSheet: _currentPage != 2
          ? Container(
              height: 60,
              alignment: Alignment.center,
              child: Text(
                "Swipe to Continue",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          : SizedBox.shrink(),
    );
  }

  Widget _buildPage({
    required String title,
    required String description,
    required String image,
    bool isLastPage = false,
  }) {
    return Container(
      color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              image,
              height: 300,
              errorBuilder: (context, error, stackTrace) {
                return Text('.', style: TextStyle(color: const Color.fromARGB(255, 12, 202, 249)));
              },
            ),
            SizedBox(height: 30),
            Text(
              title,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            Text(
              description,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            if (isLastPage)
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text("Get Started"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
              ),
          ],
        ),
      ),
    );
  }
}



