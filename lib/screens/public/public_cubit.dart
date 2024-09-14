import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/networking/_client/networking_api.dart';

import '../../managers/alert_mgr.dart';
import '../../model/project/project.dart';

part 'public_state.dart';

class PublicCubit extends Cubit<PublicState> {
  final nwk = NetworkingApi.shared.publicApi;
  PublicCubit() : super(PublicInitial());
  // Alert Dialog
  bool isAlertVisible = false;
  var alertTitle = '';
  var alertMsg = '';
  // Projects
  List<Project> projects = [];
  Project? selectedProject;

  void showAlert(BuildContext context, bool withDismiss) {
    AlertManager().showAlert(
      context: context,
      title: alertTitle,
      message: alertMsg,
      withDismiss: withDismiss ? true : false,
    );
  }

  void dismissAlert(BuildContext context) =>
      AlertManager().dismissPreviousAlert(context);

  void clearAlertFields() {
    alertTitle = '';
    alertMsg = '';
  }

  void getProjects() async {
    clearAlertFields();
    emit(PublicLoadingState());
    try {
      await nwk.getProjects(
          name: null, from: 1, to: 10, bootcamp: null, type: null);
      if (nwk.projects == null) throw Exception(nwk.errorMsg);
      projects = nwk.projects!;
      emit(PublicUpdateUIState());
    } catch (e) {
      alertTitle = 'Oops';
      alertMsg = '$e';
      emit(PublicErrorState());
    }
  }

  void getProjectById(String projectId) async {
    clearAlertFields();
    emit(PublicLoadingState());
    try {
      await nwk.getProjectById(projectId: projectId);
      if (nwk.project == null) throw Exception(nwk.errorMsg);
      selectedProject = nwk.project;
      emit(PublicUpdateUIState());
    } catch (e) {
      alertTitle = 'Oops';
      alertMsg = '$e';
      emit(PublicErrorState());
    }
  }
}
