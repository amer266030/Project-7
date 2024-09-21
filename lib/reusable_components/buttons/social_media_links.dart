import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';
import 'package:tuwaiq_project_pulse/reusable_components/buttons/elevated_btn_view.dart';
import 'package:tuwaiq_project_pulse/reusable_components/custom_text_field.dart';
import 'package:tuwaiq_project_pulse/reusable_components/popups/custom_popup_view.dart';
import 'package:tuwaiq_project_pulse/utils/validations.dart';

class SocialMediaLinks extends StatelessWidget {
  const SocialMediaLinks({
    super.key,
    required this.title,
    required this.hint,
    required this.controller,
    required this.icon,
  });

  final String title;
  final String hint;
  final TextEditingController controller;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomPopupView(
                title: "Update URL",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(title).styled(
                      size: 16,
                      weight: FontWeight.w600,
                    ),
                    CustomTextField(
                      controller: controller,
                      hintText: hint,
                      validation: Validations.emptyFieldValidation,
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: ElevatedBtnView(
                        title: 'Save',
                        callBack: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
                callback: () {
                  controller.text = '';
                  Navigator.of(context).pop();
                },
              );
            },
          );
        },
        icon: FaIcon(
          icon,
          color: C.bg2,
        ));
  }
}
