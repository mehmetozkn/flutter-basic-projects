import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

PreferredSize appBar(
  context, {
  Widget? right,
}) {
  return PreferredSize(
      child: AppBar(
        backgroundColor: Colors.black87,
        elevation: 1,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.topRight,
              width: MediaQuery.of(context).size.width * 0.2,
              child: right,
            ),
          ],
        ),
      ),
      preferredSize: Size.fromHeight(40));
}
