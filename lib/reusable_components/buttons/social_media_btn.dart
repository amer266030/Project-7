import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';
import 'package:tuwaiq_project_pulse/reusable_components/buttons/elevated_btn_view.dart';
import 'package:tuwaiq_project_pulse/reusable_components/custom_text_field.dart';
import 'package:tuwaiq_project_pulse/reusable_components/popups/custom_popup_view.dart';
import 'package:tuwaiq_project_pulse/utils/validations.dart';
import 'package:tuwaiq_project_pulse/reusable_components/popups/animated_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaBtn extends StatelessWidget {
  const SocialMediaBtn({
    super.key,
    required this.title,
    required this.hint,
    required this.controller,
    required this.icon,
    this.canEdit = true,
    this.smallIcon = false,
  });

  final String title;
  final String hint;
  final TextEditingController controller;
  final IconData icon;
  final bool canEdit;
  final bool smallIcon;

  void _showPopup(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomPopupView(
          title: "Update URL",
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(title).styled(
                  size: 16, weight: FontWeight.w600, color: C.text(brightness)),
              CustomTextField(
                controller: controller,
                hintText: hint,
                validation: Validations.none,
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ElevatedBtnView(
                  title: 'Save',
                  callBack: () {
                    Navigator.of(context).pop();
                    animatedSnakbar(msg: 'URL saved successfully')
                        .show(context);
                  },
                ),
              ),
            ],
          ),
          callback: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Future<void> _openUrl() async {
    final url = controller.text;
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return InkWell(
        onTap: canEdit ? () => _showPopup(context) : () => _openUrl(),
        child: smallIcon
            ? Icon(icon, size: 16, color: Colors.black)
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: FaIcon(icon, color: C.bg2(brightness), size: 30),
              ));
  }
}
