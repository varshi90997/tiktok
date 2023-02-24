import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tiktok/view/screen/3/add_video_screen.dart';
import 'package:tiktok/view/screen/1/video_screen.dart';
import 'package:tiktok/view/screen/5/profile_screen.dart';

import 'controller/auth_controller.dart';
import 'view/screen/2/search_screen.dart';

List pages = [
  VideoScreen(),
  SearchScreen(),
  const AddVideoScreen(),
  const Text('Messages Screen'),
  ProfileScreen(uid: authController.user.uid),

  // VideoScreen(),
  // SearchScreen(),
  // const AddVideoScreen(),
  // Text('Messages Screen'),
  // ProfileScreen(uid: authController.user.uid),
];

// COLORS
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

// FIREBASE
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

// CONTROLLER
var authController = AuthController.instance;