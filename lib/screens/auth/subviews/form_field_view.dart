import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../extensions/color_ext.dart';
import '../../../reusable_components/custom_text_field.dart';
import '../../../utils/typedefs.dart';
import '../../../utils/validations.dart';

class FormFieldView extends StatelessWidget {
  const FormFieldView({
    super.key,
    required this.controller,
    required this.title,
    required this.hint,
    required this.icon,
    this.isRequired = true,
    this.validation = Validations.none,
  });
  final TextEditingController controller;
  final String title;
  final String hint;
  final IconData icon;
  final bool isRequired;
  final Function(String value) validation;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TS(fontSize: 18, fontWeight: FW.w600)),
            if (isRequired)
              const Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Icon(
                  CupertinoIcons.staroflife_fill,
                  size: 12,
                  color: C.primary(context),
                ),
              ),
          ],
        ),
        CustomTextField(
            controller: controller,
            hintText: hint,
            prefixIcon: Icon(icon),
            validation: validation),
      ],
    );
  }
}
