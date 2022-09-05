import 'package:bloodzen/screens/add_request_screen.dart';
import 'package:bloodzen/screens/home_screen.dart';
import 'package:bloodzen/screens/profile_screen.dart';
import 'package:flutter/material.dart';

const webScreenSize = 600;

const homeScreenItems = [
  HomeScreen(),
  Text("Search"),
  AddRequestScreen(),
  ProfileScreen(),
  Text('Profile'),
];
