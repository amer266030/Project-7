
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';
import 'package:tuwaiq_project_pulse/model/project/project.dart';
import 'package:tuwaiq_project_pulse/reusable_components/cards/bordered_card_view.dart';
import 'package:tuwaiq_project_pulse/reusable_components/rating_stars_view.dart';
import 'package:tuwaiq_project_pulse/utils/typedefs.dart';

class ProjectDetailsCard extends StatelessWidget {
  const ProjectDetailsCard({super.key, required this.project});
  final Project project;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.5,
      child: BorderedCardView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: BR.circular(8),
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
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(project.projectName ?? '?').styled(
                            size: 14, weight: FontWeight.bold, lineLimit: 1),
                        Text(project.projectDescription ?? '').styled(
                            color: Colors.black,
                            size: 10,
                            weight: FontWeight.w300,
                            lineLimit: 2),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RatingStarsView(
                                rating: (project.rating as num).toDouble()),
                            Text(project.endDate.toString()).styled(size: 10),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
                onTap: () => (),
                child: const Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(CupertinoIcons.circle_fill, size: 32),
                    Icon(
                      CupertinoIcons.arrow_up_right_circle_fill,
                      size: 32,
                      color: Colors.white,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
