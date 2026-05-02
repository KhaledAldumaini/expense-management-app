import 'package:flutter/material.dart';

Widget buildTextField(
    String hint,
    TextEditingController controller,
    IconData icon, {
    bool isNumber = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.green),
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green.shade700, width: 2),
        ),
      ),
    );
  }