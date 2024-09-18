import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';
import 'package:tuwaiq_project_pulse/extensions/screen_size.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';
import 'package:tuwaiq_project_pulse/reusable_components/rating_stars.dart';
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
    final controller = PageController(viewportFraction: 0.8, keepPage: true);

    return Container(
      padding: EdgeInsets.only(top: 8),
      height: context.screenWidth * 0.60,
      width: context.screenWidth * 0.9,
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
      child: Column(
        children: [
          DotIndicator(
            count: 5,
            currentIndex: 2,
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: InkWell(
                      onTap: cubit == null ? () => () : cubit!.getImage,
                      child: cubit?.selectedImg == null
                          ? ClipRRect(
                              borderRadius: BR.circular(16),
                              child: const Placeholder())
                          : ClipRRect(
                              borderRadius: BR.circular(16),
                              child: Image.file(cubit!.selectedImg!)),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.projectName ?? 'None!',
                        maxLines: 1,
                      ).styled(size: 22, weight: FontWeight.bold),
                      Text('${project.bootcampName ?? ''} Bootcamp')
                          .styled(size: 18, weight: FontWeight.w600),
                      Text('${project.projectDescription}'),
                      Text(
                        DateTime.tryParse(project.createAt!) != null
                            ? DateFormat('y MMM')
                                .format(DateTime.tryParse(project.createAt!)!)
                            : '',
                      ).styled(size: 16, weight: FontWeight.w500),
                      RatingStars(rating: rating),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
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
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          width: 60.0,
          height: 8.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            shape: BoxShape.rectangle,
            color: index == currentIndex ? C.primary : C.bg1,
          ),
        );
      }),
    );
  }
}
