import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';
import 'package:tuwaiq_project_pulse/screens/project_details/project_details_cubit.dart';
import 'package:tuwaiq_project_pulse/utils/typedefs.dart';

import '../../../reusable_components/pdf_preview/pdf_preview.dart';
import '../../../reusable_components/popups/custom_popup_view.dart';

class PresentationView extends StatelessWidget {
  const PresentationView({super.key, this.pdfLink, required this.cubit});
  final ProjectDetailsCubit cubit;
  final String? pdfLink;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Presentation').styled(weight: FW.bold),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomPopupView(
                                title: "Presentation",
                                child: pdfLink != null
                                    ? PdfPreview(url: pdfLink)
                                    : const Text('None!'),
                                callback: () {
                                  Navigator.of(context).pop();
                                });
                          });
                    },
                    icon: Icon(CupertinoIcons.doc_text,
                        color: C.primary(brightness))),
                // Upload
                IconButton(
                    onPressed: cubit.pickPdfFile,
                    icon: Icon(CupertinoIcons.pencil_circle_fill,
                        color: C.primary(brightness)))
              ],
            )
            // Show
          ],
        ),
      ],
    );
  }
}
