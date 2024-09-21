import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tuwaiq_project_pulse/model/user/user.dart';
import 'package:tuwaiq_project_pulse/screens/auth/auth_screen.dart';
import 'package:tuwaiq_project_pulse/screens/user_projects/user_projects_screen.dart';

import '../../managers/alert_mgr.dart';
import '../../managers/auth_mgr.dart';
import '../../managers/popup_mgr.dart';
import '../../networking/_client/networking_api.dart';
import '../admin/admin_screen.dart';
import '../create_project/create_project_screen.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final nwk = NetworkingApi.shared.profileApi;
  final adminApi = NetworkingApi.shared.adminApi;
  final authMgr = GetIt.I.get<AuthMgr>();
  // Changing Forms
  var isEdit = false;
  // Input Fields
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var githubController = TextEditingController();
  var bindlinkController = TextEditingController();
  var linkedinController = TextEditingController();
  var resumeController = TextEditingController();
  // Alert Dialog
  bool isAlertVisible = false;
  var alertTitle = '';
  var alertMsg = '';
  // User
  User user = User();

  ProfileCubit() : super(ProfileInitial());

  // UI

  String headerTitle() => isEdit ? 'Edit Profile' : 'Profile Overview';

  void toggleIsEdit() {
    isEdit = !isEdit;
    emit(UpdateUIState());
  }

  void copyIdToClipboard() {
    Clipboard.setData(ClipboardData(text: user.id ?? '')).then((_) {
      emit(IdCopiedState());
    });
  }

  Future<void> _updateUserData() async {
    user.firstName = firstNameController.text;
    user.lastName = lastNameController.text;
    user.imageUrl = 'https://picsum.photos/200/200';
    user.link?.bindlink = bindlinkController.text;
    user.link?.github = githubController.text;
    user.link?.linkedin = linkedinController.text;
    user.resumeUrl = resumeController.text;
    user.link?.resume = resumeController.text;
  }

  Future<void> _updateInputFields() async {
    firstNameController.text = user.firstName ?? '';
    lastNameController.text = user.lastName ?? '';
    emailController.text = user.email ?? '';
    bindlinkController.text = user.link?.bindlink ?? '';
    githubController.text = user.link?.github ?? '';
    linkedinController.text = user.link?.linkedin ?? '';
    resumeController.text = user.link?.resume ?? '';
  }

  // Alert

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

  void showPopup(
          {required BuildContext context,
          required String title,
          required Widget child}) =>
      PopupMgr().showPopup(context: context, title: title, child: child);

  // Snackbar

  void showSnackBar(BuildContext context, String msg) {}

  // Navigation

  void navigateToUserProjects(BuildContext context) =>
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const UserProjectsScreen()));

  void navigateToAdminScreen(BuildContext context) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const AdminScreen()));

  void navigateToSupervisorScreen(BuildContext context) =>
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const CreateProjectScreen()));

  // API & User Mgmt

  void loadProfile() async {
    clearAlertFields();
    emit(LoadingState());
    try {
      await nwk.fetchProfile();
      if (nwk.user == null) throw Exception(nwk.errorMsg);
      user = nwk.user!;
      await _updateInputFields();
      emit(UpdateUIState());
    } catch (e) {
      alertTitle = 'Oops';
      alertMsg = '$e';
      emit(ErrorState());
    }
  }

  void updateProfile() async {
    clearAlertFields();
    emit(LoadingState());
    try {
      await _updateUserData();
      await nwk.updateProfile(user);
      toggleIsEdit();
      emit(SuccessState());
    } catch (e) {
      if (e is DioException) {
        alertTitle = 'Status Code: ${e.response?.statusCode}';
        alertMsg = 'Error Message: ${e.message}';
        emit(ErrorState());
      } else {
        alertTitle = 'Error: $e';
        alertMsg = 'Something wrong happened!, please try again later';
        emit(ErrorState());
      }
    }
  }

  Future<void> updateLogo() async {
    user.imageUrl =
        'https://picsum.photos/200/200?random=${DateTime.now().millisecondsSinceEpoch}';
    emit(UpdateUIState());
  }

  void logOut(BuildContext context) {
    authMgr.logOut();
    if (!context.mounted) return;
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AuthScreen()));
  }
}
