import 'package:flutter/material.dart';
import 'package:cashew_cart/core/colors.dart';

class CustomIconTextField extends StatelessWidget {
  const CustomIconTextField({
    required this.icon,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    super.key,
  });
  final IconData icon;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        style: const TextStyle(color: Colors.black),
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xffF3F3F3),
          prefixIcon: Icon(icon),
          hintText: hintText,
          hintStyle: const TextStyle(color: kAuthentificationPageTextColor),
          prefixIconColor: const Color(0xff626262),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Color(0xffA8A8A9),
              width: 1,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Color(0xffA8A8A9),
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
