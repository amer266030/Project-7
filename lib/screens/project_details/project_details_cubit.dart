import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tuwaiq_project_pulse/model/project/project.dart';
import 'package:tuwaiq_project_pulse/networking/_client/networking_api.dart';

import '../../extensions/img_ext.dart';

part 'project_details_state.dart';

class ProjectDetailsCubit extends Cubit<ProjectDetailsState> {
  ProjectDetailsCubit() : super(ProjectDetailsInitial());
  final userApi = NetworkingApi.shared.userApi;
  final supervisorApi = NetworkingApi.shared.supervisorApi;
  late Project project;

  File? selectedImg;

  void getImage() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    selectedImg = File(img?.path ?? '');
    updateImage();
    emit(UpdateUIState());
  }

  void updateImage() async {
    if (selectedImg != null) {
      try {
        await userApi.createLogo(
            projectId: project.projectId ?? '', img: selectedImg!);
        emit(SuccessState());
      } catch (_) {
        emit(ErrorState());
      }
    }
  }

  Future<void> updateProjectBase(Project project) async {
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
