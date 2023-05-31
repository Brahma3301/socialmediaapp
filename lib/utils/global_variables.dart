// ignore: unused_import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/screens/add_post_screen.dart';
import 'package:socialapp/screens/feed_screen.dart';
import 'package:socialapp/screens/profile_screen.dart';
import 'package:socialapp/screens/search_screen.dart';

const webScreensize = 600;
List<Widget> homeScreenItems = [
  FeedScreen(),
  SearchScreen(),
  AddPostSCreen(),
  const Text('notifications'),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  )
];
