import 'dart:io';
import 'dart:math';
import 'package:budge_tracker_app/Screens/HomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../Widget/app_logo.dart';

class ImageScreen extends StatefulWidget {
  final String username;
  final String email;
  final String password;
  final String UserUID;
  final String fullname;

  ImageScreen({
    required this.username,
    required this.email,
    required this.password,
    required this.fullname,
    required this.UserUID,
  });

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  bool _isVisible = true;
  File? imageFile;
  final picker = ImagePicker();
  String imageUrl = "";
  bool loading = false;

  Future<void> imgFromCamera() async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() => imageFile = File(pickedFile.path));
      }
    } else {
      print("Permission Denied");
    }
  }

  Future<void> upLoadImage() async {
    Reference rootReference = FirebaseStorage.instance.ref();
    Reference childReference = rootReference.child("Profile Image");
    Reference uploadImage = childReference.child(widget.UserUID);

    if (imageFile == null) {
      String defaultImagePath = "lib/assets/person-icon.png";
      File defaultImage = File(defaultImagePath);
      await uploadImage.putFile(defaultImage);
    } else {
      await uploadImage.putFile(imageFile!);
    }
    imageUrl = await uploadImage.getDownloadURL();
  }

  Future<void> storeUserData() async {
    try {
      setState(() {
        loading = true;
      });

      if (imageFile != null) {
        await upLoadImage();
      } else {
        imageUrl = "lib/assets/person-icon.png";
      }

      await FirebaseFirestore.instance.collection("user").doc(widget.UserUID).set({
        "username": widget.username,
        "password": widget.password,
        "fullname": widget.fullname,
        "imageurl": imageUrl,
        "email": widget.email,
        "userID": widget.UserUID,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Account created successfully")),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      print("Error in creating account: ${e.toString()}");
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BudgeTrackerLogo(),
              if (_isVisible)
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            setState(() {
                              _isVisible = false;
                            });
                          },
                          tooltip: 'Skip',
                        ),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            Text(
                              "Profile Image",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            CircleAvatar(
                              radius: 70,
                              child: imageFile == null
                                  ? Icon(
                                Icons.person,
                                size: 60,
                              )
                                  : ClipOval(
                                child: Image.file(
                                  imageFile!,
                                  fit: BoxFit.cover,
                                  width: 140,
                                  height: 140,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor:
                                  Theme.of(context).colorScheme.background),
                              onPressed: () {
                                imgFromCamera();
                              },
                              child: Text('Take Picture from Camera'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              else
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 10),
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Your account is \nready to create",
                      style:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ElevatedButton(
                onPressed: () async {
                  await storeUserData();
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
                  child: loading
                      ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                      : Text(
                    "Create Account",
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
    );
  }
}
