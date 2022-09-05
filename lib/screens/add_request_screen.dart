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

class AddRequestScreen extends StatefulWidget {
  const AddRequestScreen({Key? key}) : super(key: key);

  @override
  State<AddRequestScreen> createState() => _AddRequestScreenState();
}

class _AddRequestScreenState extends State<AddRequestScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _groupController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _groupController.dispose();
    _dateController.dispose();
    _descriptionController.dispose();
  }

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime dateTime = DateTime.now();
  bool showDate = false;
  bool showTime = false;
  bool showDateTime = false;
  bool _isLoading = false;

  // Select for Date
  Future<DateTime> _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
    return selectedDate;
  }

// Select for Time
  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (selected != null && selected != selectedTime) {
      setState(() {
        selectedTime = selected;
      });
    }
    return selectedTime;
  }
  // select date time picker

  Future _selectDateTime(BuildContext context) async {
    final date = await _selectDate(context);
    if (date == null) return;

    final time = await _selectTime(context);

    if (time == null) return;
    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  String getDate() {
    // ignore: unnecessary_null_comparison
    if (selectedDate == null) {
      return 'select date';
    } else {
      return DateFormat('MMM d, yyyy').format(selectedDate);
    }
  }

  String getDateTime() {
    // ignore: unnecessary_null_comparison
    if (dateTime == null) {
      return 'select date timer';
    } else {
      return DateFormat('yyyy-MM-dd HH: ss a').format(dateTime);
    }
  }

  String getTime(TimeOfDay tod) {
    final now = DateTime.now();

    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();
    return format.format(dt);
  }

  void postRequest(
    String uid,
    String username,
    String profImage,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      // print(_descriptionController.text);
      // print(uid);
      // print(_nameController.text);
      // print(profImage);
      // print(getDateTime());

      String res = await FirestoreMethods().uploadRequest(
          _descriptionController.text,
          uid,
          _nameController.text,
          profImage,
          getDateTime().toString(),
          _groupController.text);
      if (res == 'success') {
        setState(() {
          _isLoading = false;
        });
        showSnackBar('Request posted!', context);
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
          Text("Need Before"),
          showDateTime ? Text(getDateTime()) : const SizedBox(),
          const SizedBox(height: 24),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _selectDateTime(context);
                      showDateTime = true;
                    },
                    child: const Text('Select'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: Text("Add request"),
              onPressed: (() =>
                  postRequest(user.uid, user.username, user.photoUrl)),
            ),
          ),
        ],
      ),
    );
  }
}
