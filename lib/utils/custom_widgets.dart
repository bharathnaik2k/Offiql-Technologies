import 'package:flutter/material.dart';

Text customText(
  String text, {
  TextOverflow overflow = TextOverflow.ellipsis,
  int maxLines = 1,
  FontWeight fontWeight = FontWeight.bold,
  Color color = Colors.black,
  double fontsize = 12.0,
}) {
  return Text(
    text,
    overflow: overflow,
    maxLines: maxLines,
    style: TextStyle(
      fontWeight: fontWeight,
      color: color,
      fontSize: fontsize,
    ),
  );
}
