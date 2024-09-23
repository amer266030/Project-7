import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';
import 'package:tuwaiq_project_pulse/model/project/project_images.dart';
import 'package:tuwaiq_project_pulse/screens/project_details/project_details_cubit.dart';
import 'package:tuwaiq_project_pulse/utils/typedefs.dart';

class ScreenShotsView extends StatelessWidget {
  const ScreenShotsView({super.key, required this.cubit, required this.images});
  final ProjectDetailsCubit cubit;
  final List<ProjectImages> images;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Screenshots').styled(weight: FW.bold),
            IconButton(
                onPressed: cubit.getScreenshots,
                icon: const Icon(CupertinoIcons.plus_circle_fill,
                    color: C.primary))
          ],
        ),
        images.isEmpty
            ? const Text('Not available!')
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.6,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: images.length,
                itemBuilder: (context, index) {
                  final image = images[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: image.url != null
                        ? Image.network(
                            image.url!,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                  child: Text('Image not available'));
                            },
                          )
                        : const Center(child: Text('No image')),
                  );
                },
              ),
      ],
    );
  }
}
