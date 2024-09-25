import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';
import 'package:tuwaiq_project_pulse/extensions/screen_size.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';
import 'package:tuwaiq_project_pulse/reusable_components/buttons/elevated_btn_view.dart';
import 'package:tuwaiq_project_pulse/reusable_components/cards/bordered_card_view.dart';
import 'package:tuwaiq_project_pulse/reusable_components/rating_stars_view.dart';
import 'package:tuwaiq_project_pulse/screens/project_details/project_details_cubit.dart';
import 'package:tuwaiq_project_pulse/utils/typedefs.dart';

class RatingCardView extends StatelessWidget {
  const RatingCardView({super.key, required this.rating, required this.cubit});
  final double rating;
  final ProjectDetailsCubit cubit;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return BorderedCardView(
      isSecondaryColor: false,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Rating').styled(weight: FW.bold),
                RatingStarsView(rating: rating),
                Text('10K Ratings')
                    .styled(color: Colors.black, weight: FW.w300),
              ],
            ),
            ElevatedBtnView(
              title: cubit.project.allowRating == true
                  ? 'Rating QR'
                  : 'Rating Closed',
              callBack: () => cubit.showPopup(
                context: context,
                title: 'Rating QR',
                child: SizedBox(
                  height: context.screenWidth * 0.7,
                  width: context.screenWidth * 0.7,
                  child: InkWell(
                    onTap: () => cubit.navigateToRatingScreen(context),
                    child: QrImageView(
                      data: cubit.project.projectId ?? '',
                      version: QrVersions.auto,
                      size: 320,
                      gapless: false,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
