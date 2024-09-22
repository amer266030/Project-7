import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';
import 'package:tuwaiq_project_pulse/extensions/date_ext.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';
import 'package:tuwaiq_project_pulse/reusable_components/buttons/elevated_btn_view.dart';
import 'package:tuwaiq_project_pulse/reusable_components/images/background_img.dart';
import 'package:tuwaiq_project_pulse/screens/create_project/create_project_cubit.dart';

import '../../model/user/user.dart';
import '../../reusable_components/cards/bordered_card_view.dart';
import '../../utils/typedefs.dart';

class CreateProjectScreen extends StatelessWidget {
  const CreateProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateProjectCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<CreateProjectCubit>();
        return Scaffold(
          appBar: AppBar(
              centerTitle: true,
              title: const Text('Create Project')
                  .styled(context: context, size: 18, weight: FW.bold)),
          body: Stack(
            children: [
              const BackgroundImg(),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            BorderedCardView(
                              isSecondaryColor: false,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('User:').styled(
                                            context: context,
                                            color: Colors.black,
                                            weight: FW.bold),
                                        Card(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: BlocBuilder<
                                                CreateProjectCubit,
                                                CreateProjectState>(
                                              builder: (context, state) {
                                                if (state
                                                    is CreateProjectInitial) {
                                                  cubit.fetchUsers();
                                                }
                                                return DropdownButton<User>(
                                                  value: cubit.selectedUser,
                                                  onChanged: (User? user) {
                                                    cubit.changeSelectedUser(
                                                        user!);
                                                  },
                                                  items: cubit.allUsers
                                                      .map((User user) {
                                                    return DropdownMenuItem<
                                                            User>(
                                                        value: user,
                                                        child: Text(
                                                                user.email ??
                                                                    '')
                                                            .styled(
                                                                context:
                                                                    context,
                                                                size: 10));
                                                  }).toList(),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    BlocBuilder<CreateProjectCubit,
                                        CreateProjectState>(
                                      builder: (context, state) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(cubit.canEdit
                                                      ? 'Edit Enabled'
                                                      : 'Edit Disabled')
                                                  .styled(
                                                    context: context, 
                                                      color: Colors.black,
                                                      weight: FW.bold),
                                              Switch(
                                                value: cubit.canEdit,
                                                onChanged: (_) =>
                                                    cubit.toggleCanEdit(),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    BlocBuilder<CreateProjectCubit,
                                        CreateProjectState>(
                                      builder: (context, state) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('End Date:').styled(
                                              context: context, 
                                                color: Colors.black,
                                                weight: FW.bold),
                                            Text(cubit.selectedDate
                                                .toFormattedString()),
                                            IconButton(
                                              onPressed: () =>
                                                  BottomPicker.date(
                                                pickerTitle:  Text(
                                                  'Select an End Date for the project',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: C.primary(context),
                                                  ),
                                                ),
                                                dateOrder:
                                                    DatePickerDateOrder.dmy,
                                                initialDateTime: DateTime.now(),
                                                maxDateTime: DateTime.now().add(
                                                    const Duration(days: 360)),
                                                minDateTime: DateTime.now().add(
                                                    const Duration(days: -1)),
                                                pickerTextStyle:
                                                    const TextStyle(
                                                  // color: C.text1,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                                onSubmit: (date) =>
                                                    cubit.setSelectedDate(date),
                                              ).show(context),
                                              icon: Icon(Icons.calendar_month,
                                                  color: C.primary(context)),
                                            )
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedBtnView(
                                title: 'Create',
                                hasBorder: true,
                                callBack: cubit.saveChanges),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
