import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tuwaiq_project_pulse/networking/_client/networking_api.dart';
import 'package:tuwaiq_project_pulse/screens/project_details/project_details_screen.dart';

import '../../managers/alert_mgr.dart';
import '../../model/project/project.dart';
import '../../model/user/user.dart';

part 'user_projects_state.dart';

class UserProjectsCubit extends Cubit<UserProjectsState> {
  final nwk = NetworkingApi.shared.profileApi;
  // Alert Dialog
  bool isAlertVisible = false;
  var alertTitle = '';
  var alertMsg = '';
  // User
  var user = User();

  UserProjectsCubit() : super(UserProjectsInitial());

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

  void navigateToDetails(BuildContext context, Project project) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProjectDetailsScreen(project: project)));

  void loadProfile() async {
    clearAlertFields();
    emit(UserProjectsLoadingState());
    Future.delayed(const Duration(seconds: 2));
    try {
      await nwk.fetchProfile();
      if (nwk.user == null) throw Exception(nwk.errorMsg);
      user = nwk.user!;
      // await _updateInputFields();
      emit(UpdateUIState());
    } catch (e) {
      alertTitle = 'Oops';
      alertMsg = nwk.errorMsg;
      emit(UserProjectsErrorState());
    }
  }
}
