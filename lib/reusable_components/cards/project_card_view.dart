import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';
import 'package:tuwaiq_project_pulse/reusable_components/rating_stars_view.dart';
import 'package:tuwaiq_project_pulse/screens/project_details/project_details_cubit.dart';
import '../../model/project/project.dart';
import '../../utils/typedefs.dart';

class ProjectCardView extends StatelessWidget {
  const ProjectCardView({super.key, required this.project, this.cubit});
  final Project project;
  final ProjectDetailsCubit? cubit;

  @override
  Widget build(BuildContext context) {
    final double rating = double.tryParse('${project.rating}') ?? 0;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: const Border(
          right: BorderSide(
            width: 7,
            color: C.primary,
          ),
          bottom: BorderSide(
            width: 7,
            color: C.primary,
          ),
        ),
        color: C.secondaryWOpacity,
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 16.0, bottom: 8, left: 16, right: 16),
        child: Column(
          children: [
            const DotIndicator(
              count: 5,
              currentIndex: 0,
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
                                ? const Placeholder()
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
                        icon: const Icon(
                          CupertinoIcons.arrow_up_right_circle_fill,
                          size: 32,
                          color: Colors.white,
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

class DotIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;

  const DotIndicator(
      {super.key, required this.count, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 2.0),
            height: 6.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              shape: BoxShape.rectangle,
              color: index == currentIndex ? C.primary : C.bg1,
            ),
          ),
        );
      }),
    );
  }
}
