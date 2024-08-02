import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormFields extends StatelessWidget {
  TextEditingController controller;
  String? hintText;
  String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  CustomTextFormFields(
      {super.key,
      required this.controller,
      this.validator,
      required this.hintText,
      this.keyboardType = TextInputType.text,
      this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            border: const OutlineInputBorder(),
            filled: false,
            hintText: hintText),
        validator: validator,
        inputFormatters: inputFormatters);
  }
}
