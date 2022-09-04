import 'dart:io';

import 'package:bloodzen/widgets/button_widget.dart';
import 'package:bloodzen/widgets/profile_widget.dart';
import 'package:bloodzen/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) => Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            leading: BackButton(),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.person),
              ),
            ],
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 32),
            physics: BouncingScrollPhysics(),
            children: [
              ProfileWidget(
                imagePath:
                    "https://images.unsplash.com/photo-1662221628987-704d38ca9fa1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
                onClicked: () async {},
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Username',
                text: "Barath",
                onChanged: (name) {},
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Email',
                text: "gsribarathvajasarma@gmail.com",
                onChanged: (email) {},
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'About',
                text:
                    "dsssssssssssssssssssssssssssssssssssssssssssssssssssssssss",
                maxLines: 5,
                onChanged: (about) {},
              ),
              const SizedBox(height: 14),
              Center(child: buildUpgradeButton()),
            ],
          ),
        ),
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Edit profile',
        onClicked: () {},
      );
}
