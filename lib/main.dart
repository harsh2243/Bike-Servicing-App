
import 'package:flutter/material.dart';
import './Introslider/intro1.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen Example',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false, 
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _textOpacity = 0.0; 

  @override
  void initState() {
    super.initState();

    
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    
    _controller.forward();

   
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _textOpacity = 1.0; 
      });
    });

    
    Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => IntroSliderScreen()), 
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green, 
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
           
              Container(
                width: 200, 
                height: 200, 
                child: Image.asset(
                  'assets/image/bike.png', 
                  fit: BoxFit.contain, 
                ),
              ),
              SizedBox(height: 20), 
              
              AnimatedOpacity(
                opacity: _textOpacity,
                duration: Duration(seconds: 1),
                child: Text(
                  'Tendoer',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10), 
              
              AnimatedOpacity(
                opacity: _textOpacity,
                duration: Duration(seconds: 1),
                child: Text(
                  'Bike Service',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white70,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}










