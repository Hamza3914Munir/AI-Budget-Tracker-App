import 'dart:math';
import 'package:budge_tracker_app/Screens/CreateAccount/profile_image.dart';
import 'package:budge_tracker_app/Screens/Widget/textField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Widget/app_logo.dart';
import 'e-mail.dart';

class UsernameScreen extends StatefulWidget {
  final String email;
  final String password;
  final String UserUID;

  UsernameScreen(
      {required this.email, required this.password, required this.UserUID});

  @override
  _UsernameScreenState createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _username = true;
  FirebaseFirestore fbf = FirebaseFirestore.instance;

  void _checkUserName() async {
    String username = _usernameController.text.trim();
    QuerySnapshot result = await fbf
        .collection("user")
        .where("username", isEqualTo: username)
        .get();
    if (result.docs.isEmpty) {
      setState(() {
        _username = true;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ImageScreen(username: _usernameController.text.trim(),
                    email: widget.email,
                    password: widget.password,
                    UserUID : widget.UserUID,
                    fullname: _usernameController.text.trim()
                  )));
    } else {
      setState(() {
        _username = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BudgeTrackerLogo(),
            SizedBox(
              height: 70,
            ),
            Text(
              " Enter your full name",
              style: TextStyle(
                fontSize: 15,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            CustomTextField(
                controller: _nameController,
                prefixIcon: Icon(Icons.person),
                labelText: "Full name"),
            Text(
              " Username should be unique",
              style: TextStyle(
                fontSize: 15,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            CustomTextField(
                controller: _usernameController,
                prefixIcon: Icon(CupertinoIcons.person),
                errorText: _username == true ? null : "username already taken",
                labelText: "username"),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (_usernameController.text.trim().isEmpty) {
                  Fluttertoast.showToast(
                      msg: "User name is empty",
                      backgroundColor: Colors.red,
                      gravity: ToastGravity.SNACKBAR);
                } else {
                  _checkUserName();
                }
              },
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.background),
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
    );
  }
}
