import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tuwaiq_project_pulse/extensions/date_ext.dart';
import 'package:tuwaiq_project_pulse/model/project/link_type.dart';
import 'package:tuwaiq_project_pulse/model/project/project.dart';
import 'package:tuwaiq_project_pulse/model/project/project_links.dart';
import 'package:tuwaiq_project_pulse/model/project/project_members.dart';
import 'package:tuwaiq_project_pulse/model/project/project_type.dart';
import 'package:tuwaiq_project_pulse/networking/_client/networking_api.dart';
import 'package:tuwaiq_project_pulse/screens/project_details/Link_management.dart';
import 'package:tuwaiq_project_pulse/screens/rating/rating_screen.dart';
import 'package:tuwaiq_project_pulse/screens/supervisor_project_edit/supervisor_project_edit_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../managers/auth_mgr.dart';
import '../../managers/popup_mgr.dart';
import '../../reusable_components/popups/animated_snackbar.dart';

part 'project_details_state.dart';

class ProjectDetailsCubit extends Cubit<ProjectDetailsState> {
  ProjectDetailsCubit() : super(ProjectDetailsInitial());
  final authMgr = GetIt.I.get<AuthMgr>();
  final userApi = NetworkingApi.shared.userApi;
  final supervisorApi = NetworkingApi.shared.supervisorApi;
  final publicApi = NetworkingApi.shared.publicApi;
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
  List<(String, String)> members = [];
  // Links
  var githubController = TextEditingController();
  var figmaController = TextEditingController();
  var videoController = TextEditingController();
  var pintresetController = TextEditingController();
  var googleController = TextEditingController();
  var appleController = TextEditingController();
  var androidController = TextEditingController();
  var webController = TextEditingController();
  // Team Members
  var member1IDController = TextEditingController();
  var member2IDController = TextEditingController();
  var member3IDController = TextEditingController();
  var member4IDController = TextEditingController();
  var member1RoleController = TextEditingController();
  var member2RoleController = TextEditingController();
  var member3RoleController = TextEditingController();
  var member4RoleController = TextEditingController();

  // Initial

  void loadProject(Project projectInitial) {
    project = projectInitial;
    titleController.text = project.projectName ?? '';
    descController.text = project.projectDescription ?? '';
    bootcampController.text = project.bootcampName ?? '';
    selectedType = project.type ?? ProjectType.ai;
    readOnly = !((project.adminId == authMgr.currentUserId) ||
        (project.userId == authMgr.currentUserId));
    loadLinks(project);
    _loadMembers(project);
  }

  void _loadMembers(Project project) {
    if (project.membersProject != null) {
      final members = project.membersProject!;

      // Ensure there are always 4 members (filling with empty ones if needed)
      final membersToDisplay = List.generate(4, (index) {
        return index < members.length
            ? members[index]
            : ProjectMembers(
                id: '', position: ''); // Empty member as a fallback
      });

      // Initialize the controllers for each member
      member1IDController = TextEditingController(text: membersToDisplay[0].id);
      member1RoleController =
          TextEditingController(text: membersToDisplay[0].position);

      member2IDController = TextEditingController(text: membersToDisplay[1].id);
      member2RoleController =
          TextEditingController(text: membersToDisplay[1].position);

      member3IDController = TextEditingController(text: membersToDisplay[2].id);
      member3RoleController =
          TextEditingController(text: membersToDisplay[2].position);

      member4IDController = TextEditingController(text: membersToDisplay[3].id);
      member4RoleController =
          TextEditingController(text: membersToDisplay[3].position);
    }
  }

  void reloadProject(String projectId) async {
    try {
      await publicApi.getProjectById(projectId: projectId);
      if (publicApi.project != null) {
        project = publicApi.project!;
        loadProject(project);
        emit(SuccessState('Project Loading Complete'));
      } else {
        emit(ErrorState('something wrong happened!'));
      }
    } catch (e) {
      emit(ErrorState('Could not reload Project'));
    }
  }

  void launchLink(String? link) async {
    if (link == null || link.isEmpty) {
      emit(NoUrlState());
    } else {
      final Uri url = Uri.parse(link);
      if (!await launchUrl(url)) {
        emit(NoUrlState());
      }
    }
  }

  void navigateToEdit(BuildContext context) {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => SupervisorProjectEditScreen(project: project),
      ),
    )
        .then((_) {
      reloadProject(project.projectId ?? '');
    });
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

  void navigateToRatingScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RatingScreen(
          projectId: project.projectId ?? '',
        ),
      ),
    );
  }

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
    project.startDate = project.startDate == null
        ? DateTime.now().toFormattedString()
        : project.startDate?.toSlashDate();
    project.endDate = project.endDate == null
        ? DateTime.now().toFormattedString()
        : project.endDate?.toSlashDate();
    project.presentationDate = project.presentationDate == null
        ? DateTime.now().toFormattedString()
        : project.presentationDate?.toSlashDate();
  }

  void _updateProjectLinks() {
    List<ProjectLinks> links = [];

    // Check each controller and add to the list if not empty
    if (githubController.text.isNotEmpty) {
      links
          .add(ProjectLinks(url: githubController.text, type: LinkType.github));
    }

    if (figmaController.text.isNotEmpty) {
      links.add(ProjectLinks(url: figmaController.text, type: LinkType.figma));
    }

    if (videoController.text.isNotEmpty) {
      links.add(ProjectLinks(url: videoController.text, type: LinkType.video));
    }

    if (pintresetController.text.isNotEmpty) {
      links.add(ProjectLinks(
          url: pintresetController.text, type: LinkType.pinterest));
    }

    if (googleController.text.isNotEmpty) {
      links.add(
          ProjectLinks(url: googleController.text, type: LinkType.playstore));
    }

    if (appleController.text.isNotEmpty) {
      links.add(
          ProjectLinks(url: appleController.text, type: LinkType.applestore));
    }

    if (androidController.text.isNotEmpty) {
      links.add(ProjectLinks(url: androidController.text, type: LinkType.apk));
    }

    if (webController.text.isNotEmpty) {
      links.add(ProjectLinks(url: webController.text, type: LinkType.weblink));
    }

    // Update the project links
    project.linksProject = links.isEmpty ? null : links;
    print(links.length);
  }

  // API

  Future<void> updateProjectBase() async {
    _updateProjectFields();
    emit(LoadingState());
    try {
      await userApi.createProjectBase(project: project);
      emit(SuccessState('Project Base Updated!'));
    } catch (e) {
      emit(ErrorState('Error: ${userApi.errorMsg}'));
    }
  }

  Future<void> updateLinks() async {
    _updateProjectLinks();
    emit(LoadingState());
    try {
      await userApi.createLinks(
          projectId: project.projectId ?? '',
          links: project.linksProject ?? []);
      emit(SuccessState('Project Base Updated!'));
    } catch (e) {
      emit(ErrorState('Error: ${userApi.errorMsg}'));
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
      emit(ErrorState('Error: ${supervisorApi.errorMsg}'));
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
      emit(ErrorState('Error: ${supervisorApi.errorMsg}'));
    }
  }

  Future<void> updateMembers(Project project) async {
    emit(LoadingState());

    try {
      final List<(String, String)> nonEmptyMembers = [];

      // Collect non-empty members
      if (member1IDController.text.isNotEmpty &&
          member1RoleController.text.isNotEmpty) {
        nonEmptyMembers
            .add((member1IDController.text, member1RoleController.text));
      }
      if (member2IDController.text.isNotEmpty &&
          member2RoleController.text.isNotEmpty) {
        nonEmptyMembers
            .add((member2IDController.text, member2RoleController.text));
      }
      if (member3IDController.text.isNotEmpty &&
          member3RoleController.text.isNotEmpty) {
        nonEmptyMembers
            .add((member3IDController.text, member3RoleController.text));
      }
      if (member4IDController.text.isNotEmpty &&
          member4RoleController.text.isNotEmpty) {
        nonEmptyMembers
            .add((member4IDController.text, member4RoleController.text));
      }

      if (nonEmptyMembers.isNotEmpty) {
        await userApi.createMembers(
          projectId: project.projectId ?? '',
          members: nonEmptyMembers, // Pass the tuple list
        );
        emit(SuccessState('Members Updated'));
      } else {
        emit(ErrorState('No members to update.'));
      }
    } catch (e) {
      emit(ErrorState('Error: ${userApi.errorMsg}'));
    }
  }
}
