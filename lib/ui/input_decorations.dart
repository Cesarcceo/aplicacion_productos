import 'package:flutter/material.dart';

class inputDecorations{
  static InputDecoration authInputDecorations({
    required String hintText,
    required String labelText,
    IconData? prefixIcon
  }){
    return InputDecoration(
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.deepPurple,
        )
      ),
      focusedBorder: const  UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.deepPurple,
          width: 2,
        )
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Colors.grey
      ),
      prefixIcon: prefixIcon!=null 
      ? const Icon(Icons.alternate_email_sharp, color: Colors.deepPurple) : null
    );
  }
}