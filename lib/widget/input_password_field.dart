import 'package:flutter/material.dart';
import '../utils/style_management.dart';

class InputPasswordField extends StatefulWidget {
  TextEditingController passwordController;
  String hintText;
  InputPasswordField(
      {Key? key, required this.passwordController, required this.hintText})
      : super(key: key);

  @override
  State<InputPasswordField> createState() => _InputPasswordFieldState();
}

class _InputPasswordFieldState extends State<InputPasswordField> {
  bool isHidden = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.0,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      padding: const EdgeInsets.only(left: 5.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        border: Border.all(color: const Color(0xFFB2BAFF)),
      ),
      alignment: Alignment.centerLeft,
      child: TextFormField(
        controller: widget.passwordController,
        style: StyleManagement.testStyleBlack14,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: StyleManagement.testStyleGrey14,
          suffixIcon: IconButton(
            icon: isHidden
                ? const Icon(Icons.visibility_outlined)
                : const Icon(Icons.visibility_off_outlined),
            onPressed: () {
              setState(() {
                isHidden = !isHidden;
              });
            },
          ),
          border: InputBorder.none,
          //border: OutlineInputBorder(borderSide: const BorderSide(), borderRadius: BorderRadius.circular(4)),
        ),
        obscureText: isHidden,
      ),
    );
  }
}
