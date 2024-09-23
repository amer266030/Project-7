import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tuwaiq_project_pulse/extensions/date_ext.dart';
import 'package:tuwaiq_project_pulse/model/project/project.dart';
import 'package:tuwaiq_project_pulse/model/project/project_type.dart';
import 'package:tuwaiq_project_pulse/networking/_client/networking_api.dart';

import '../../managers/auth_mgr.dart';
import '../../managers/popup_mgr.dart';
import '../../reusable_components/popups/animated_snackbar.dart';

part 'project_details_state.dart';

class ProjectDetailsCubit extends Cubit<ProjectDetailsState> {
  ProjectDetailsCubit() : super(ProjectDetailsInitial());
  final authMgr = GetIt.I.get<AuthMgr>();
  final userApi = NetworkingApi.shared.userApi;
  final supervisorApi = NetworkingApi.shared.supervisorApi;
  var project = Project();
  bool readOnly = true;
  // Editing Fields
  var titleController = TextEditingController();
  var descController = TextEditingController();
  var bootcampController = TextEditingController();
  ProjectType selectedType = ProjectType.ai;
  File? logo;
  List<File> screens = [];
  File? presentation;
  // Links
  var githubController = TextEditingController();
  var figmaController = TextEditingController();
  var videoController = TextEditingController();
  var pintresetController = TextEditingController();
  var googleController = TextEditingController();
  var appleController = TextEditingController();
  var androidController = TextEditingController();
  var webController = TextEditingController();

  // Initial

  void loadProject(Project projectInitial) {
    project = projectInitial;
    titleController.text = project.projectName ?? '';
    descController.text = project.projectDescription ?? '';
    bootcampController.text = project.bootcampName ?? '';
    selectedType = project.type ?? ProjectType.ai;
    readOnly = !((project.adminId == authMgr.currentUserId) ||
        (project.userId == authMgr.currentUserId));
  }

  // UI

  // SnackBar
  void showSnackBar({
    required BuildContext context,
    required String msg,
    AnimatedSnackBarType type = AnimatedSnackBarType.success,
  }) {
    if (context.mounted) animatedSnakbar(msg: msg, type: type).show(context);
  }

  // Popup
  void showPopup(
          {required BuildContext context,
          required String title,
          required Widget child}) =>
      PopupMgr().showPopup(context: context, title: title, child: child);

  // Logo
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
        emit(SuccessState('Logo updated'));
      } catch (_) {
        emit(ErrorState('Error: ${userApi.errorMsg}'));
      }
    }
  }

  // Screenshots

  void getScreenshots() async {
    final images = await ImagePicker().pickMultiImage();
    for (var img in images) {
      screens.add(File(img.path));
    }
    updateScreenshots();
  }

  void updateScreenshots() async {
    try {
      await userApi.createImages(
          projectId: project.projectId ?? '', fileImages: screens);
      emit(SuccessState('Screenshots added!'));
    } catch (_) {
      emit(ErrorState('Error: ${userApi.errorMsg}'));
    }
  }

  // Presentation

  void pickPdfFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      File file = File(result.files.single.path!);
      presentation = file;
    }

    if (presentation != null) {
      try {
        userApi.createProjectPresentation(
            projectId: project.projectId ?? '', presentation: presentation!);
        emit(SuccessState('presentation uploaded'));
      } catch (_) {
        emit(ErrorState('Error: ${userApi.errorMsg}'));
      }
    }

    emit(UpdateUIState());
  }

  void changeType(ProjectType type) {
    selectedType = type;
    emit(UpdateUIState());
  }

  void _updateProjectFields() {
    project.projectName = titleController.text;
    project.projectDescription = descController.text;
    project.bootcampName = bootcampController.text;
    project.type = selectedType;
    project.startDate = project.startDate?.toSlashDate();
    project.endDate = project.endDate?.toSlashDate();
    project.presentationDate = project.presentationDate?.toSlashDate();
  }

  // Supervisor
  Future<void> updateProjectBase() async {
    _updateProjectFields();
    emit(LoadingState());
    if (project.adminId != authMgr.currentUserId) {
      emit(ErrorState('You do not have permission to edit this!'));
    } else {
      try {
        await userApi.createProjectBase(project: project);
        emit(SuccessState('Project Base Updated!'));
      } catch (e) {
        emit(ErrorState('Error: ${userApi.errorMsg}'));
      }
    }
  }

  Future<void> updateLinks() async {
    _updateProjectFields();
    emit(LoadingState());
    if (readOnly) {
      emit(ErrorState('You do not have permission to edit this!'));
    } else {
      try {
        await userApi.createLinks(
            projectId: project.projectId ?? '',
            links: project.linksProject ?? []);
        emit(SuccessState('Project Base Updated!'));
      } catch (e) {
        emit(ErrorState('Error: ${userApi.errorMsg}'));
      }
    }
  }

  Future<void> deleteProject() async {
    emit(LoadingState());
    try {
      await supervisorApi.deleteProject(
          projectId: project.projectId ?? '',
          endDate: project.endDate ?? DateTime.now().toFormattedString(),
          canEdit: project.allowEdit ?? false,
          isPublic: project.isPublic ?? false);
      emit(SuccessState('Project Deleted!'));
      await Future.delayed(const Duration(seconds: 2));
      emit(ProjectDeletedState());
    } catch (e) {
      emit(ErrorState('Error: ${userApi.errorMsg}'));
    }
  }

  Future<void> makePublic(Project project) async {
    emit(LoadingState());
    try {
      await supervisorApi.updateProject(
        projectId: project.projectId ?? '',
        endDate: DateTime.now(),
        canEdit: true,
        canRate: true,
        isPublic: true,
      );
      emit(SuccessState('Project is now Public!'));
    } catch (e) {
      emit(ErrorState('Error: ${userApi.errorMsg}'));
    }
  }
}
