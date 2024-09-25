import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';
import 'package:tuwaiq_project_pulse/reusable_components/images/logo_view.dart';
import 'package:tuwaiq_project_pulse/reusable_components/rating_stars_view.dart';
import 'package:tuwaiq_project_pulse/screens/project_details/project_details_cubit.dart';
import 'package:tuwaiq_project_pulse/screens/projects/projects_cubit.dart';
import '../../model/project/project.dart';
import '../../utils/typedefs.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProjectCardView extends StatelessWidget {
  const ProjectCardView(
      {super.key,
      required this.project,
      this.cubit,
      this.pageController,
      this.withIndicator = true,
      this.projectsCubit});
  final Project project;
  final ProjectDetailsCubit? cubit;
  final ProjectsCubit? projectsCubit;

  final bool withIndicator;
  final PageController? pageController;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final double rating = double.tryParse('${project.rating}') ?? 0;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border(
          right: BorderSide(
            width: 7,
            color: C.primary(brightness),
          ),
          bottom: BorderSide(
            width: 7,
            color: C.primary(brightness),
          ),
        ),
        color: C.secondary(brightness).withOpacity(0.7),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 16.0, bottom: 8, left: 16, right: 16),
        child: Column(
          children: [
            if (withIndicator)
              SmoothPageIndicator(
                controller: pageController!,
                count: 5,
                effect: WormEffect(
                  activeDotColor: C.primary(brightness),
                  dotColor: C.text(brightness).withOpacity(0.5),
                  dotHeight: 8,
                  dotWidth: 62,
                  spacing: 4,
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 24.0),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: InkWell(
                          onTap: cubit == null ? () => () : cubit!.getImage,
                          child: ClipRRect(
                            borderRadius: BR.circular(16),
                            child: project.logoUrl == null
                                ? const LogoView()
                                : Image.network(
                                    project.logoUrl!,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.projectName ?? 'None!',
                          maxLines: 1,
                        ).styled(
                            size: 14, weight: FontWeight.bold, lineLimit: 1),
                        Text(project.bootcampName ?? '')
                            .styled(size: 12, weight: FontWeight.w400),
                        Text(project.projectDescription ?? '').styled(
                            color: Colors.black,
                            size: 10,
                            weight: FontWeight.w300,
                            lineLimit: 2),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RatingStarsView(rating: rating),
                Text(
                  DateTime.tryParse(project.createAt ?? '') != null
                      ? DateFormat('y MMM')
                          .format(DateTime.tryParse(project.createAt ?? '')!)
                      : '',
                ).styled(size: 12, weight: FontWeight.w500),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(CupertinoIcons.circle_fill, size: 32),
                    IconButton(
                        onPressed: () => (),
                        icon: Icon(
                          CupertinoIcons.arrow_up_right_circle_fill,
                          size: 32,
                          color: C.secondary(brightness),
                        )),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
