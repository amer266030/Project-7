import 'package:flutter/material.dart';

import '../extensions/color_ext.dart';
import '../utils/typedefs.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.max = 1,
      required this.controller,
      required this.validation});
  final String hintText;
  final Widget? prefixIcon;
  final int? max;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final Function(String value) validation;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: TextFormField(
        maxLines: max,
        minLines: 1,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        textCapitalization: TextCapitalization.none,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(4),
            prefixIcon: prefixIcon,
            prefixIconColor: C.primary(context),
            suffixIcon: suffixIcon,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: C.primary(context), width: 1),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: C.primary(context), width: 1)),
            filled: true,
            fillColor: C.secondary(context).withOpacity(0.5),
            hintText: hintText,
            hintStyle: const TS(
              color: Colors.grey,
            )),
        validator: (value) => validation(value ?? ''),
      ),
    );
  }
}
