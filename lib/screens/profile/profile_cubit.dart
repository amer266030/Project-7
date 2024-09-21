import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tuwaiq_project_pulse/model/user/user.dart';
import 'package:tuwaiq_project_pulse/screens/auth/auth_screen.dart';

import '../../managers/alert_mgr.dart';
import '../../managers/auth_mgr.dart';
import '../../networking/_client/networking_api.dart';

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
  // Alert Dialog
  bool isAlertVisible = false;
  var alertTitle = '';
  var alertMsg = '';
  // User
  User user = User();

  /* TO BE REMOVED */
  static const amerUserId = '8c534564-cf6e-42eb-9377-6c08a81debd2';

  ProfileCubit() : super(ProfileInitial());

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

  Future<void> _updateUserData() async {
    user.firstName = firstNameController.text;
    user.lastName = lastNameController.text;
    user.link?.bindlink = bindlinkController.text;
    user.link?.github = githubController.text;
    user.link?.linkedin = linkedinController.text;
    
  }

  Future<void> _updateInputFields() async {
    firstNameController.text = user.firstName ?? '';
    lastNameController.text = user.lastName ?? '';
    emailController.text = user.email ?? '';
    bindlinkController.text = user.link?.bindlink ?? '';
    githubController.text = user.link?.github ?? '';
    linkedinController.text = user.link?.linkedin ?? '';
  }

  Future<void> updateLogo() async {
    final picker = ImagePicker();
    final XFile? logo = await picker.pickImage(source: ImageSource.gallery);
    if (logo != null) {
      user.imageUrl = logo.path;
      emit(ProfileUpdateState());
    }
  }

  void logOut(BuildContext context) {
    authMgr.logOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AuthScreen()));
  }

  void copyIdToClipboard() {
    Clipboard.setData(ClipboardData(text: user.id ?? '')).then((_) {
      emit(ProfileIdCopiedState());
    });
  }
}
