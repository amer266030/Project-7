import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tuwaiq_project_pulse/model/user/user.dart';
import 'package:tuwaiq_project_pulse/screens/auth/auth_screen.dart';
import 'package:tuwaiq_project_pulse/screens/user_projects/user_projects_screen.dart';

import '../../managers/alert_mgr.dart';
import '../../managers/auth_mgr.dart';
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
    emit(ProfileUpdateState());
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

  Future<void> _updateUserData() async {
    user.firstName = firstNameController.text;
    user.lastName = lastNameController.text;
  }

  Future<void> _updateInputFields() async {
    firstNameController.text = user.firstName ?? '';
    lastNameController.text = user.lastName ?? '';
  }

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
    emit(ProfileLoadingState());
    try {
      await nwk.fetchProfile();
      if (nwk.user == null) throw Exception(nwk.errorMsg);
      user = nwk.user!;
      await _updateInputFields();
      emit(ProfileUpdateState());
    } catch (e) {
      alertTitle = 'Oops';
      alertMsg = '$e';
      emit(ProfileErrorState());
    }
  }

  void updateProfile() async {
    clearAlertFields();
    emit(ProfileLoadingState());
    try {
      await _updateUserData();
      await nwk.updateProfile(user);
      toggleIsEdit();
    } catch (e) {
      if (e is DioException) {
        alertTitle = 'Status Code: ${e.response?.statusCode}';
        alertMsg = 'Error Message: ${e.message}';
        emit(ProfileErrorState());
      } else {
        alertTitle = '';
        alertMsg = 'Something wrong happened!, please try again later';
        emit(ProfileErrorState());
      }
    }
  }

  void logOut(BuildContext context) async {
    await authMgr.logOut();
    if (!context.mounted) return;
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AuthScreen()));
  }
}
