import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:tuwaiq_project_pulse/extensions/date_ext.dart';
import 'package:tuwaiq_project_pulse/networking/_client/networking_api.dart';

import '../../model/project/project.dart';
import '../../reusable_components/popups/animated_snackbar.dart';

part 'supervisor_edit_state.dart';

class SupervisorEditCubit extends Cubit<SupervisorEditState> {
  SupervisorEditCubit() : super(SupervisorEditInitial());
  final api = NetworkingApi.shared.supervisorApi;

  bool canEdit = false;
  bool isPublic = false;
  bool canRate = false;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  void initialLoad(Project project) {
    canEdit = project.allowEdit ?? false;
    isPublic = project.isPublic ?? false;
    canRate = project.allowRating ?? false;
    startDate = project.startDate?.toSlashDate().toDateTime() ?? DateTime.now();
    endDate = project.endDate?.toSlashDate().toDateTime() ?? DateTime.now();

    // emit(UpdateUIState());
  }

  void showSnackBar(BuildContext context, String msg) {
    if (context.mounted) {
      animatedSnakbar(msg: msg).show(context);
    }
  }

  void toggleCanEdit() {
    canEdit = !canEdit;
    emit(UpdateUIState());
  }

  void toggleIsPublic() {
    isPublic = !isPublic;
    emit(UpdateUIState());
  }

  void toggleCanRate() {
    canRate = !canRate;
    emit(UpdateUIState());
  }

  void setStartDate(DateTime date) {
    startDate = date;
    emit(UpdateUIState());
  }

  void setEndDate(DateTime date) {
    endDate = date;
    emit(UpdateUIState());
  }

  Future<void> updateProject(String projectId) async {
    try {
      await api.updateProject(
          projectId: projectId,
          endDate: endDate,
          canEdit: canEdit,
          canRate: canRate,
          isPublic: isPublic);
      emit(SuccessState());
    } catch (e) {
      print('Error $e');
      emit(ErrorState());
    }
  }
}
