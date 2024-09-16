import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Widget/app_logo.dart';
import '../Widget/textField.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math';

import 'UserName.dart';

class EmailScreen extends StatefulWidget {
  @override
  _EmailScreenState createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signIn() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _confirmPasswordController.text.trim(),
      );
      String uid = await userCredential.user!.uid;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UsernameScreen(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
            UserUID: uid,
          ),
        ),
      );
      debugPrint("user created");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40,),
                BudgeTrackerLogo(),
                SizedBox(height: 70),
                Text(
                  "Enter your active email address",
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                CustomTextField(
                  controller: _emailController,
                  prefixIcon: Icon(Icons.email),
                  labelText: "E-mail",
                ),
                SizedBox(height: 12),
                Text(
                  "Create a strong password, greater than 6 digits",
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(height: 5,),
                CustomTextField(
                  controller: _passwordController,
                  prefixIcon: Icon(Icons.lock),
                  labelText: "Password",
                ),
                SizedBox(height: 16),
                CustomTextField(
                  controller: _confirmPasswordController,
                  prefixIcon: Icon(Icons.lock),
                  labelText: "Confirm Password",
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    if (_emailController.text.trim().isEmpty) {
                      Fluttertoast.showToast(
                        msg: "Enter your email",
                        backgroundColor: Colors.red,
                        gravity: ToastGravity.SNACKBAR,
                      );
                      return;
                    }
                    if (_passwordController.text.trim().isEmpty || _confirmPasswordController.text.trim().isEmpty) {
                      Fluttertoast.showToast(
                        msg: "Please enter your password",
                        backgroundColor: Colors.red,
                        gravity: ToastGravity.SNACKBAR,
                      );
                      return;
                    }
                    if (_passwordController.text.trim() != _confirmPasswordController.text.trim()) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Error"),
                          content: Text("Passwords do not match."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("OK"),
                            ),
                          ],
                        ),
                      );
                      return;
                    }
                    _signIn();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.background,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.tertiary,
                          Theme.of(context).colorScheme.secondary,
                          Theme.of(context).colorScheme.primary,
                        ],
                        transform: GradientRotation(pi / 4),
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                    child: Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
