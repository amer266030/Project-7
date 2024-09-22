import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tuwaiq_project_pulse/extensions/date_ext.dart';
import 'package:tuwaiq_project_pulse/model/project/project.dart';
import 'package:tuwaiq_project_pulse/model/project/project_type.dart';
import 'package:tuwaiq_project_pulse/networking/_client/networking_api.dart';

part 'project_details_state.dart';

class ProjectDetailsCubit extends Cubit<ProjectDetailsState> {
  ProjectDetailsCubit() : super(ProjectDetailsInitial());
  final userApi = NetworkingApi.shared.userApi;
  final supervisorApi = NetworkingApi.shared.supervisorApi;
  var project = Project();
  // Editing Fields
  var titleController = TextEditingController();
  var descController = TextEditingController();
  var bootcampController = TextEditingController();
  ProjectType? type;
  File? logo;

  void getImage() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    logo = File(img?.path ?? '');
    updateImage();
    emit(UpdateUIState());
  }

  void updateImage() async {
    if (logo != null) {
      try {
        await userApi.createLogo(
            projectId: project.projectId ?? '', img: logo!);
        emit(SuccessState());
      } catch (_) {
        emit(ErrorState());
      }
    }
  }

  void loadProject(Project projectInitial) {
    project = projectInitial;
    titleController.text = project.projectName ?? '';
    descController.text = project.projectDescription ?? '';
    bootcampController.text = project.bootcampName ?? '';
    type = project.type ?? ProjectType.ai;
  }

  void _updateProjectFields() {
    project.projectName = titleController.text;
    project.projectDescription = descController.text;
    project.bootcampName = bootcampController.text;
    project.type = type;
    project.startDate = project.startDate?.toSlashDate();
    project.endDate = project.endDate?.toSlashDate();
    project.presentationDate = project.presentationDate?.toSlashDate();
  }

  Future<void> updateProjectBase(Project project) async {
    _updateProjectFields();
    try {
      await userApi.createProjectBase(project: project);
    } catch (e) {
      emit(ErrorState());
    }
  }

  Future<void> makePublic(Project project) async {
    try {
      await supervisorApi.updateProject(
        projectId: project.projectId ?? '',
        endDate: DateTime.now(),
        canEdit: true,
        canRate: true,
        isPublic: true,
      );
      emit(SuccessState());
    } catch (e) {
      emit(ErrorState());
    }
  }
}
