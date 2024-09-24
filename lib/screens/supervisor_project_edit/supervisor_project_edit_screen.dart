import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';
import 'package:tuwaiq_project_pulse/extensions/date_ext.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';
import 'package:tuwaiq_project_pulse/model/project/project.dart';
import 'package:tuwaiq_project_pulse/reusable_components/buttons/elevated_btn_view.dart';
import 'package:tuwaiq_project_pulse/screens/supervisor_project_edit/supervisor_edit_cubit.dart';
import 'package:tuwaiq_project_pulse/screens/supervisor_project_edit/supervisor_list_item_view.dart';
import 'package:tuwaiq_project_pulse/utils/typedefs.dart';

class SupervisorProjectEditScreen extends StatelessWidget {
  const SupervisorProjectEditScreen({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return BlocProvider(
      create: (context) => SupervisorEditCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<SupervisorEditCubit>();
        return BlocListener<SupervisorEditCubit, SupervisorEditState>(
          listener: (context, state) {
            if (state is SuccessState) {
              cubit.showSnackBar(context, 'Changes Saved');
            }
            if (state is ErrorState) {
              cubit.showSnackBar(context, 'Error saving changes!');
            }
          },
          child: Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: const Text('Update Project').styled(
                    color: C.primary(brightness), size: 18, weight: FW.bold)),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    BlocBuilder<SupervisorEditCubit, SupervisorEditState>(
                      builder: (context, state) {
                        if (state is SupervisorEditInitial) {
                          cubit.initialLoad(project);
                        }
                        return Expanded(
                          child: ListView(
                            children: [
                              SupervisorListItemView(
                                  label: 'Can Edit',
                                  toggleValue: cubit.canEdit,
                                  callback: () => cubit.toggleCanEdit()),
                              SupervisorListItemView(
                                  label: 'is Public',
                                  toggleValue: cubit.isPublic,
                                  callback: () => cubit.toggleIsPublic()),
                              SupervisorListItemView(
                                  label: 'Allow Rating',
                                  toggleValue: cubit.canRate,
                                  callback: () => cubit.toggleCanRate()),
                              BlocBuilder<SupervisorEditCubit,
                                  SupervisorEditState>(
                                builder: (context, state) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Start Date:').styled(
                                          color: Colors.black, weight: FW.bold),
                                      Text(cubit.startDate.toFormattedString()),
                                      IconButton(
                                        onPressed: () => BottomPicker.date(
                                          pickerTitle: Text(
                                            'Select an End Date for the project',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: C.primary(brightness),
                                            ),
                                          ),
                                          dateOrder: DatePickerDateOrder.dmy,
                                          initialDateTime: DateTime.now(),
                                          maxDateTime: DateTime.now()
                                              .add(const Duration(days: 360)),
                                          minDateTime: DateTime.now()
                                              .add(const Duration(days: -1)),
                                          pickerTextStyle: const TextStyle(
                                            // color: C.text1,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                          onSubmit: (date) =>
                                              cubit.setStartDate(date),
                                        ).show(context),
                                        icon: Icon(Icons.calendar_month,
                                            color: C.primary(brightness)),
                                      )
                                    ],
                                  );
                                },
                              ),
                              BlocBuilder<SupervisorEditCubit,
                                  SupervisorEditState>(
                                builder: (context, state) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('End Date:').styled(
                                          color: Colors.black, weight: FW.bold),
                                      Text(cubit.endDate.toFormattedString()),
                                      IconButton(
                                        onPressed: () => BottomPicker.date(
                                          pickerTitle: Text(
                                            'Select an End Date for the project',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: C.primary(brightness),
                                            ),
                                          ),
                                          dateOrder: DatePickerDateOrder.dmy,
                                          initialDateTime: DateTime.now(),
                                          maxDateTime: DateTime.now()
                                              .add(const Duration(days: 360)),
                                          minDateTime: DateTime.now()
                                              .add(const Duration(days: -1)),
                                          pickerTextStyle: const TextStyle(
                                            // color: C.text1,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                          onSubmit: (date) =>
                                              cubit.setEndDate(date),
                                        ).show(context),
                                        icon: Icon(Icons.calendar_month,
                                            color: C.primary(brightness)),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    ElevatedBtnView(
                        title: 'Save Changes',
                        callBack: () =>
                            cubit.updateProject(project.projectId ?? ''))
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
