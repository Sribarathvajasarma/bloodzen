import 'package:bloodzen/resources/auth_methods.dart';
import 'package:bloodzen/responsive/mobile_screen_layout.dart';
import 'package:bloodzen/responsive/responsive_layout_screen.dart';
import 'package:bloodzen/responsive/web_screen_layout.dart';
import 'package:bloodzen/screens/login_screen.dart';
import 'package:bloodzen/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: Image.asset(
          'assets/bloodzen.jpg',
          height: 32,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: Container(
        child: Text("MainScreen"),
      ),
    );
  }
}
