import 'package:bloodzen/screens/edit_profile_screen.dart';
import 'package:bloodzen/widgets/button_widget.dart';
import 'package:bloodzen/widgets/numbers_widget.dart';
import 'package:flutter/material.dart';
import 'package:bloodzen/widgets/profile_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void buttonPress() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditProfilePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text('Profile'),
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              imagePath:
                  "https://images.unsplash.com/photo-1662221628987-704d38ca9fa1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
              onClicked: () async {},
            ),
            const SizedBox(
              height: 24,
            ),
            buildName(),
            const SizedBox(height: 14),
            Center(child: buildUpgradeButton()),
            const SizedBox(height: 14),
            NumbersWidget(),
            const SizedBox(height: 48),
            buildAbout()
          ],
        ));
  }

  Widget buildName() => Column(
        children: [
          Text(
            "Barath",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            "gsribarathvajasarma@gmail.com",
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Edit profile',
        onClicked: buttonPress,
      );

  Widget buildAbout() => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee",
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
