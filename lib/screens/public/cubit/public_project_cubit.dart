import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/managers/alert_mgr.dart';
import 'package:tuwaiq_project_pulse/model/project/project.dart';
import 'package:tuwaiq_project_pulse/networking/_client/networking_api.dart';

part 'public_project_state.dart';

class PublicProjectCubit extends Cubit<PublicProjectState> {
    final nwk = NetworkingApi.shared.publicApi;
  PublicProjectCubit() : super(PublicProjectInitial());
  // Alert Dialog
  bool isAlertVisible = false;
  var alertTitle = '';
  var alertMsg = '';
  // Project
  Project? project;


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

  void getProject() async {
    try {
      await nwk.getProjectById(projectId: '1');
      if (nwk.project == null) throw Exception(nwk.errorMsg);
      project = nwk.project;
      emit(PublicProjectUpdateUIState());
    } catch (e) {
      alertTitle = 'Oops';
      alertMsg = '$e';
      emit(PublicProjectErrorState());
    }
  }
}
