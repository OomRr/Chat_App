import 'package:flutter/material.dart';
void showSnackBar(BuildContext context,text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),),);
}