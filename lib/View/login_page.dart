import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:malaymate/View/translatewithtext_page.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  bool _isEmailValid = true;
  bool _isPasswordVisible = false;

  //Function to show a message using a SnackBar
  void _showSnackBar(String message, {Color backgroundColor = Colors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message),
        backgroundColor: backgroundColor,
        duration: Duration(seconds: 2),
      ),
    );
  }

  //function to triggered the button create account
  void _oncreateAccountPressed() {
    // Check if any field is empty
    if (_usernameController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      _showSnackBar('Some fields are missing.\nPlease complete all required fields.');
      return;
    }

    //Navigate to textpage
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TranslateWithTextPage()),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Image
            Center(
              child: Container(
                height: 350,
                child: Image.asset('assets/images/smiley.png'), // Replace with your asset
              ),
            ),
            Container(
              //width: 350,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  bottomRight: Radius.circular(0),
                  bottomLeft: Radius.circular(0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 5),
                  // Sign Up Title
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  // Full Name Input
                  TextField(
                    controller: _usernameController,
                    cursorColor: Colors.blue.shade800,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle:const TextStyle(
                        color: Color(0xFF333333),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.blue.shade800,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  // Password Input
                  TextField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    cursorColor: Colors.blue.shade800,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle:const TextStyle(
                        color: Color(0xFF333333),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.blue.shade800,
                          width: 2.0,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  // Create Account Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.blue.shade800,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size(double.infinity, 50),
                    ),
                    //ternary operator meaning (?:) (if-else)
                    onPressed: _oncreateAccountPressed,
                    child: Text('Login',
                    style: TextStyle(
                      fontSize: 18,
                    ),),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(70),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
