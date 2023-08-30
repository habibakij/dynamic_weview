import 'package:flutter/material.dart';
import 'package:qr_test/utils/style_management.dart';
import '../utils/common.dart';

class TextWidget {
  static titleTextField(String title, int isRight) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
      alignment: isRight == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: Text(
        title,
        style: isRight == 0
            ? StyleManagement.testStyleBlack14
            : StyleManagement.testStyleBlue14,
      ),
    );
  }

  static customToolbarBack(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 3.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        color: Colors.white,
        child: SizedBox(
          width: 50,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new,
                color: Colors.blue, size: 30.0),
            onPressed: () {
              Common.customToast("custom app bar", 0);
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }

  static carInfoItemWidget(String title, String subTitle) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: StyleManagement.testStyleBlack12,
          ),
          Text(
            subTitle,
            style: StyleManagement.testStyleBlack12,
          ),
        ],
      ),
    );
  }

  static textWithStyle(String text, TextStyle textStyle) {
    return Text(
      text,
      style: textStyle,
    );
  }
}
