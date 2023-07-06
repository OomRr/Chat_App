import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key, this.pass = false, this.hintText, this.onChanged});

  String? hintText;

  Function(String)? onChanged;
  bool? pass;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: pass!,
      validator: (data) {
        if (data!.isEmpty) return 'field is required';
      },
      onChanged: onChanged,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        suffixIconColor: Colors.white,
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
