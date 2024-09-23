import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';
import 'package:tuwaiq_project_pulse/model/project/project.dart';
import 'package:tuwaiq_project_pulse/reusable_components/buttons/custom_text_btn_view.dart';
import 'package:tuwaiq_project_pulse/reusable_components/cards/bordered_card_view.dart';
import 'package:tuwaiq_project_pulse/reusable_components/cards/project_details_card.dart';
import 'package:tuwaiq_project_pulse/reusable_components/custom_text_field.dart';
import 'package:tuwaiq_project_pulse/reusable_components/images/background_img.dart';
import 'package:tuwaiq_project_pulse/screens/rating/rating_cubit.dart';
import 'package:tuwaiq_project_pulse/utils/typedefs.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tuwaiq_project_pulse/utils/validations.dart';

class RatingScreen extends StatelessWidget {
  const RatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RatingCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<RatingCubit>();
        return Scaffold(
          backgroundColor: C.bg1(context),
          body: Stack(children: [
            const BackgroundImg(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              CupertinoIcons.arrow_left,
                              color: C.primary(context),
                            )),
                        const Text('Rating').styled(
                          size: 18,
                          weight: FW.bold,
                          /* ADD
              
                              color: C.text(context)
                               */
                        ),
                        CustomTextBtn(
                          title: "Send",
                          callback: () {},
                        )
                      ],
                    ),

                    /* Replace
                        replace the folowing code with ProjectDetailsCard class
                         */
                    AspectRatio(
                      aspectRatio: 2.5,
                      child: BorderedCardView(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: ClipRRect(
                                      borderRadius: BR.circular(8),
                                      child: Image.asset("assets/logo.png")),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("title").styled(
                                            size: 14,
                                            weight: FontWeight.bold,
                                            lineLimit: 1),
                                        Text("sub title").styled(
                                            color: Colors.black,
                                            size: 10,
                                            weight: FontWeight.w300,
                                            lineLimit: 2),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    BorderedCardView(
                        isSecondaryColor: false,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              RatingBuilder(
                                cubit: cubit,
                                title: 'Project Idea',
                              ),
                              RatingBuilder(
                                cubit: cubit,
                                title: 'Project Design',
                              ),
                              RatingBuilder(
                                cubit: cubit,
                                title: 'Project Tools',
                              ),
                              RatingBuilder(
                                cubit: cubit,
                                title: 'Project Presentation',
                              ),
                              RatingBuilder(
                                cubit: cubit,
                                title: 'Project ', //??
                              ),
                            ],
                          ),
                        )),
                    BorderedCardView(
                      isSecondaryColor: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Commints').styled(
                            size: 16,
                            color: Colors.black,
                          ),
                          CustomTextField(
                            hintText: "Commints",
                            controller: cubit.commintController,
                            validation: Validations.emptyFieldValidation,
                            max: 4,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ]),
        );
      }),
    );
  }
}

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
