



import 'package:flutter/material.dart';
import '../shared_prefernce.dart'; 
import './login.dart'; 

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> with SingleTickerProviderStateMixin {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();
    
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        backgroundColor: Colors.green,
      ),
      body: FadeTransition(
        opacity: _animation,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          
              Image.asset(
                'assets/image/signup_vector.png', 
                height: 150,
                errorBuilder: (context, error, stackTrace) {
                  return Text('Image not found', style: TextStyle(color: Colors.red));
                },
              ),
              SizedBox(height: 20),
              
              _buildTextField(nameController, 'Name'),
              SizedBox(height: 20),
              
              _buildTextField(mobileController, 'Mobile'),
              SizedBox(height: 20),
            
              _buildTextField(emailController, 'Email'),
              SizedBox(height: 20),
             
              _buildTextField(passwordController, 'Password', obscureText: true),
              SizedBox(height: 20),
            
              ElevatedButton(
                onPressed: () async {
                  if (_validateFields()) {
                    SharedPreferencesService prefs = SharedPreferencesService();
                    
                
                    await prefs.saveUser(
                      nameController.text,
                      mobileController.text,
                      emailController.text,
                      passwordController.text,
                    );

                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Signup Successful! You can now login.')),
                    );

                    
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  }
                },
                child: Text('Sign Up'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _validateFields() {
    if (nameController.text.isEmpty) {
      _showError('Please enter your name.');
      return false;
    }
    if (mobileController.text.isEmpty) {
      _showError('Please enter your mobile number.');
      return false;
    }
    if (emailController.text.isEmpty) {
      _showError('Please enter your email.');
      return false;
    }
    if (passwordController.text.isEmpty) {
      _showError('Please enter your password.');
      return false;
    }
    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

 
  Widget _buildTextField(TextEditingController controller, String label, {bool obscureText = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.green),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
      ),
      obscureText: obscureText,
    );
  }
}

