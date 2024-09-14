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

  void getProjects() async {
    try {
      await nwk.getProjects(
          name: 'hop', from: 1, to: 3, bootcamp: 'flutter', type: 'website');
      if (nwk.response == null) throw Exception(nwk.errorMsg);
      if (nwk.projects == null) throw Exception(nwk.errorMsg);
      projects = nwk.projects!;
      print(projects.length);
      emit(PublicUpdateUIState());
    } catch (e) {
      alertTitle = 'Oops';
      alertMsg = '$e';
      emit(PublicErrorState());
    }
  }
}
