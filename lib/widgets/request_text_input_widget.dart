import 'package:flutter/material.dart';

// class RequestFieldWidget extends StatefulWidget {
//   final String label;
//   final TextEditingController textEditingController;
//   final String hintText;
//   final TextInputType textInputType;

//   const RequestFieldWidget({
//     Key? key,
//     required this.label,
//     required this.textEditingController,
//     required this.hintText,
//     required this.textInputType

//   }) : super(key: key);

//   @override
//   _RequestFieldWidgetState createState() => _RequestFieldWidgetState();
// }

// class _RequestFieldWidgetState extends State<RequestFieldWidget> {

//   @override
//   Widget build(BuildContext context) =>
//         Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             widget.label,
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//           ),
//           const SizedBox(height: 8),
//           TextField(
//             controller: textEditingController,
//             decoration: InputDecoration(
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),

//           ),
//         ],
//       );
// }

class RequestFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController textEditingController;
  final String hintText;
  final TextInputType textInputType;

  const RequestFieldWidget(
      {Key? key,
      required this.label,
      required this.textEditingController,
      required this.hintText,
      required this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: textEditingController,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}
