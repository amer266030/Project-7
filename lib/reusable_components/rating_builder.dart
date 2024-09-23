
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';
import 'package:tuwaiq_project_pulse/screens/rating/rating_cubit.dart';

class RatingBuilder extends StatelessWidget {
  const RatingBuilder({
    super.key,
    required this.cubit,
    required this.title,
  });

  final RatingCubit cubit;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title).styled(
          size: 16,
          color: Colors.black,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('1').styled(
              size: 18,
              color: C.primary(context),
            ),
            BlocBuilder<RatingCubit, RatingState>(
              builder: (context, state) {
                return RatingBar.builder(
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 10,
                  itemSize: 24,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: C.primary(context),
                  ),
                  onRatingUpdate: (newRating) {
                    cubit.updateRating(newRating);
                  },
                );
              },
            ),
            Text('10').styled(
              size: 18,
              color: C.primary(context),
            ),
          ],
        ),
        Divider(),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
