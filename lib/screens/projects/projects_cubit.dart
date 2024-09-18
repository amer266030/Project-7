import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/networking/_client/networking_api.dart';
import 'package:tuwaiq_project_pulse/screens/bootcamp_projects/bootcamp_projects_screen.dart';

import '../../managers/alert_mgr.dart';
import '../../model/project/project.dart';

part 'projects_state.dart';

class ProjectsCubit extends Cubit<ProjectsState> {
  final nwk = NetworkingApi.shared.publicApi;
  ProjectsCubit() : super(ProjectsInitial());
  // Alert Dialog
  bool isAlertVisible = false;
  var alertTitle = '';
  var alertMsg = '';
  // Projects
  List<Project> allProjects = [];
  List<Project> topRated = [];
  Map<String, List<Project>> groupedProjects = {};
  Project? selectedProject;
  var topRatedIdx = 0;

  void navigateToBootCampProjects(
          {required BuildContext context,
          required String title,
          required List<Project> projects}) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BootcampProjectsScreen(
                title: title,
                projects: projects,
              )));

  void fetchTopRatedProjects() {
    List<Project> sortedProjects =
        List.from(allProjects); // Create a copy of the list
    sortedProjects.sort((a, b) =>
        b.rating!.compareTo(a.rating!)); // Sort by rating in descending order
    topRated =
        sortedProjects.take(5).toList(); // Return only the top 3 projects
  }

  void groupProjectsByBootcamp() {
    Map<String, List<Project>> bootcampProjects = {};

    for (var project in allProjects) {
      // Group projects by bootcamp name
      if (project.bootcampName != null && project.bootcampName!.isNotEmpty) {
        bootcampProjects.putIfAbsent(project.bootcampName!, () => []);
        bootcampProjects[project.bootcampName!]!.add(project);
      }
    }
    groupedProjects = bootcampProjects;
  }

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
    emit(ProjectsLoadingState());
    try {
      await nwk.getProjects(
          name: null, from: 1, to: 10, bootcamp: null, type: null);
      if (nwk.projects == null) throw Exception(nwk.errorMsg);
      allProjects = nwk.projects ?? [];
      fetchTopRatedProjects();
      groupProjectsByBootcamp();
      emit(ProjectsUpdateUIState());
    } catch (e) {
      alertTitle = 'Oops';
      alertMsg = '$e';
      emit(ProjectsErrorState());
    }
  }

  void getProjectById(String projectId) async {
    clearAlertFields();
    emit(ProjectsLoadingState());
    try {
      await nwk.getProjectById(projectId: projectId);
      if (nwk.project == null) throw Exception(nwk.errorMsg);
      selectedProject = nwk.project;
      emit(ProjectsUpdateUIState());
    } catch (e) {
      alertTitle = 'Oops';
      alertMsg = '$e';
      emit(ProjectsErrorState());
    }
  }
}
