import 'package:bloodzen/responsive/mobile_screen_layout.dart';
import 'package:bloodzen/screens/home_screen.dart';
import 'package:bloodzen/screens/profile_screen.dart';
import 'package:flutter/material.dart';

import 'package:bloodzen/models/user.dart';
import 'package:bloodzen/providers/user_provider.dart';
import 'package:bloodzen/resources/firestore_method.dart';
import 'package:bloodzen/utils/utils.dart';
import 'package:bloodzen/widgets/button_widget.dart';
import 'package:bloodzen/widgets/request_text_input_widget.dart';
import 'package:bloodzen/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddDetailsScreen extends StatefulWidget {
  const AddDetailsScreen({Key? key}) : super(key: key);

  @override
  State<AddDetailsScreen> createState() => _AddDetailsScreenState();
}

class _AddDetailsScreenState extends State<AddDetailsScreen> {
  final TextEditingController _groupController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _groupController.dispose();
    _cityController.dispose();
    _mobileController.dispose();
  }

  bool _isLoading = false;

  void postDetails(String uid) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadDetails(uid,
          _cityController.text, _groupController.text, _mobileController.text);
      if (res == 'success') {
        setState(() {
          _isLoading = false;
        });
        //Provider.of<UserProvider>(context).refreshUser();

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MobileScreenLayout(),
          ),
        );
        showSnackBar('Details added!', context);
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(res, context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text('Required Details'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          _isLoading
              ? const LinearProgressIndicator()
              : const Padding(
                  padding: EdgeInsets.only(top: 0),
                ),
          const Divider(),
          RequestFieldWidget(
              label: "Your blood group",
              textEditingController: _groupController,
              hintText: "A+",
              textInputType: TextInputType.text),
          const SizedBox(height: 24),
          RequestFieldWidget(
              label: "Your city",
              textEditingController: _cityController,
              hintText: "Jaffna",
              textInputType: TextInputType.text),
          const SizedBox(height: 24),
          RequestFieldWidget(
              label: "Your mobile number",
              textEditingController: _mobileController,
              hintText: "0769838892",
              textInputType: TextInputType.text),
          const SizedBox(height: 14),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: Text("Submit"),
              onPressed: (() => postDetails(user.uid)),
            ),
          ),
        ],
      ),
    );
  }
}
