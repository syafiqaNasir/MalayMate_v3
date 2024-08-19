import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(SignUpApp());
}

class SignUpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isEmailValid = true;
  bool _isTermsAccepted = false;
  bool _isPasswordVisible = false;
  bool _isRSPasswordVisible = false;

  //function to valid emial format
  bool _validatEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return emailRegex.hasMatch(email);
  }

  @override
  void initState() {
    super.initState();
    //Listen for change in the emails text field
    _emailController.addListener(() {
      setState(() {
        _isEmailValid = _validatEmail(_emailController.text);
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
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
                height: 180,
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Sign Up',
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
                    cursorColor: Colors.blue.shade800,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
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
                  SizedBox(height: 20),
                  // Email Input
                  TextField(
                    controller: _emailController,
                    cursorColor: Colors.blue.shade800,
                    decoration: InputDecoration(
                      labelText: 'Email',
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
                            Icons.check_circle,
                            color: _isEmailValid ? Colors.green : Colors.red
                        ),
                        onPressed: () {
                          //Show a SnackBar with Email validation status
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                _isEmailValid ? 'Email is valid': 'Email is not valid',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: _isEmailValid ? Colors.green : Colors.red,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Password Input
                  TextField(
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
                  SizedBox(height: 20),
                  // Password Input
                  TextField(
                    obscureText: !_isRSPasswordVisible,
                    cursorColor: Colors.blue.shade800,
                    decoration: InputDecoration(
                      labelText: 'Re-confirm password',
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
                          _isRSPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isRSPasswordVisible = !_isRSPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  // Checkbox with Terms & Conditions
                  Row(
                    children: [
                      Checkbox(
                        activeColor: Colors.green,
                        value: _isTermsAccepted,
                        onChanged: (value) {
                          setState(() {
                            _isTermsAccepted = value!;
                          });
                        },
                      ),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: 'I agree to the ',
                            children: [
                              TextSpan(
                                text: 'Terms & Conditions ',
                                style: TextStyle(
                                  color: Colors.blue.shade800,
                                ),
                              ),
                              TextSpan(text: 'and '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  color: Colors.blue.shade800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
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
                    onPressed: _isTermsAccepted ? () {} : null, // Disable button if terms are not accepted
                    child: Text('Create Account'),
                  ),
                  SizedBox(height: 15),
                  // Or Divider
                  Text('or', style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 20),
                  // Sign In Link
                  Text.rich(
                    TextSpan(
                      text: 'Already have an account? ',
                      children: [
                        TextSpan(
                          text: 'Sign in',
                          style: TextStyle(color: Colors.blue.shade800),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(25),
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
