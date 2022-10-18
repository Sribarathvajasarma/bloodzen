import 'package:bloodzen/screens/profile_screen.dart';
import 'package:flutter/material.dart';

import '../resources/firestore_method.dart';
import '../utils/utils.dart';
import '../widgets/request_text_input_widget.dart';

class EditDetailScreen extends StatefulWidget {
  final snap;

  const EditDetailScreen({Key? key, required this.snap}) : super(key: key);

  @override
  State<EditDetailScreen> createState() => _EditDetailScreenState();
}

class _EditDetailScreenState extends State<EditDetailScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _groupController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.snap['username']);
    _groupController = TextEditingController(text: widget.snap['bloodGrp']);
    _descriptionController =
        TextEditingController(text: widget.snap['description']);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _groupController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
  }

  bool _isLoading = false;

  void EditDetails(String requestId) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FirestoreMethods().editDetails(
          requestId,
          _nameController.text,
          _groupController.text,
          _descriptionController.text);
      if (res == 'success') {
        setState(() {
          _isLoading = false;
        });

        Navigator.of(context).pop();
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
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text('Add Request'),
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
              label: "Name",
              textEditingController: _nameController,
              hintText: "Your name",
              textInputType: TextInputType.text),
          const SizedBox(height: 24),
          RequestFieldWidget(
              label: "Blood Group",
              textEditingController: _groupController,
              hintText: "Required blood group",
              textInputType: TextInputType.text),
          const SizedBox(height: 24),
          RequestFieldWidget(
              label: "Description",
              textEditingController: _descriptionController,
              hintText: "Description...",
              textInputType: TextInputType.text),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: Text("Edit"),
              onPressed: (() => EditDetails(widget.snap['requestId'])),
            ),
          ),
        ],
      ),
    );
  }
}
