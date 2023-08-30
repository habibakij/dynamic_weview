import 'package:flutter/material.dart';
import '../utils/style_management.dart';

class InputTextField extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  int isPhone, isAddress;
  InputTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.isPhone,
      required this.isAddress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      padding: const EdgeInsets.only(left: 5.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        border: Border.all(color: const Color(0xFFB2BAFF)),
      ),
      alignment: Alignment.centerLeft,
      child: TextFormField(
        controller: controller,
        style: StyleManagement.testStyleBlack14,
        keyboardType: isPhone == 1
            ? TextInputType.phone
            : isAddress == 1
                ? TextInputType.emailAddress
                : TextInputType.text,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: StyleManagement.testStyleGrey14,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
