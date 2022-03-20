import 'package:flutter/material.dart';

Container textFieldBuilder(
    {int height = 40,
    @required TextEditingController? textEditingController,
    Icon? icon,
    String? hintText,
    TextAlign textAlign = TextAlign.center}) {
  return Container(
    height: double.parse(height.toString()),
    padding: EdgeInsets.only(left: 16, right: 16),
    decoration: BoxDecoration(
      color: Colors.grey.withOpacity(0.28),
      borderRadius: BorderRadius.circular(4),
    ),
    margin: EdgeInsets.only(left: 16, right: 16, bottom: 4, top: 4),
    child: TextFormField(
      keyboardType: TextInputType.name,
      maxLines: 1,
      textAlign: textAlign,
      controller: textEditingController,
      style: TextStyle(
          color: Colors.black,
          fontFamily: "RobotoMedium",
          decoration: TextDecoration.none,
          fontSize: 18),
      decoration: InputDecoration(
        icon: icon,
        border: InputBorder.none,
        hintText: hintText,
        fillColor: Colors.transparent,
        isDense: true,
      ),
    ),
  );
}
