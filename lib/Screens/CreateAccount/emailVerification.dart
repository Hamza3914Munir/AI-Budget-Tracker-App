import 'dart:math';
import 'package:budge_tracker_app/Screens/CreateAccount/UserName.dart';
import 'package:budge_tracker_app/Screens/Widget/textField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Widget/app_logo.dart';


class EmailVerificationScreen extends StatefulWidget {
  final String email;
  final String password;
  final String UserUID;
  EmailVerificationScreen(
  {required this.email, required this.UserUID, required this.password});

  @override
  _EmailVerificationScreenState createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isResending = false;

  Future<void> _sendVerificationEmail() async {
    setState(() {
      _isResending = true;
    });

    try {
      User? user = _auth.currentUser;
      await user?.sendEmailVerification();
      Fluttertoast.showToast(
        msg: "Verification email has been sent.",
        backgroundColor: Colors.green,
        gravity: ToastGravity.BOTTOM,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: Colors.red,
        gravity: ToastGravity.BOTTOM,
      );
    }

    setState(() {
      _isResending = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text("Verify Email"),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BudgeTrackerLogo(),
              SizedBox(height: 30),
              Text(
                "A verification email has been sent to your email.",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              _isResending
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: _sendVerificationEmail,
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
        child: Row(
          children: [
            Icon(Icons.email),
            SizedBox(width: 10,),
            Text(
              "Resend Email",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
                style: ElevatedButton.styleFrom(
                    padding:
                    EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor:
                    Theme.of(context).colorScheme.background),
              ),
            ],
          ),
        ),
      ),
    );
  }
}