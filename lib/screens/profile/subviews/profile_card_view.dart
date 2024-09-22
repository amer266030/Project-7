import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';

import '../../../extensions/color_ext.dart';
import '../../../reusable_components/cards/bordered_card_view.dart';
import '../../../utils/typedefs.dart';
import '../profile_cubit.dart';

class ProfileCardView extends StatelessWidget {
  const ProfileCardView(this.cubit, {super.key});
  final ProfileCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        BorderedCardView(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ClipOval(
                      child: cubit.user.imageUrl == null
                          ? const Placeholder()
                          : Image.network(
                              cubit.user.imageUrl!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${cubit.user.firstName ?? '?'} ${cubit.user.lastName ?? '?'}')
                            .styled(context: context, weight: FW.bold),
                        Text(cubit.user.id ?? '?').styled(
                            context: context, size: 10, weight: FW.w400),
                        Text(cubit.user.email ?? '?').styled(
                            context: context, size: 10, weight: FW.w400),
                      ],
                    ),
                    IconButton(
                      icon: Icon(
                        CupertinoIcons.doc_on_clipboard_fill,
                        color: C.primary(context),
                        size: 12,
                      ),
                      onPressed: cubit.copyIdToClipboard,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BR.circular(24),
            side: BorderSide(color: C.primary(context), width: 1),
          ),
          borderOnForeground: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Text(cubit.user.role ?? '?')
                .styled(context: context, size: 12, weight: FW.bold),
          ),
        ),
      ],
    );
  }
}
