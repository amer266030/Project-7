import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuwaiq_project_pulse/model/user.dart';
import '../../managers/alert_mgr.dart';
import '../../networking/_client/networking_api.dart';
import 'package:flutter/material.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final nwk = NetworkingApi.shared.profileApi;
  // Changing Forms
  var isEdit = false;
  // Input Fields
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();

  // Alert Dialog
  bool isAlertVisible = false;
  var alertTitle = '';
  var alertMsg = '';
  var user = User();

  ProfileCubit() : super(ProfileInitial());

  String headerTitle() => isEdit ? 'Edit Profile' : 'Profile Overview';

  void toggleIsEdit() {
    isEdit = !isEdit;
    emit(ProfileUpdateState());
  }

  void showAlert(BuildContext context) {
    AlertManager().showAlert(
      context: context,
      title: alertTitle,
      message: alertMsg,
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
      if (nwk.user == null) throw Exception('Could not load user profile');
      user = nwk.user!;
      await _updateInputFields();
      emit(ProfileUpdateState());
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
  }

  Future<void> _updateInputFields() async {
    firstNameController.text = user.firstName ?? '';
    lastNameController.text = user.lastName ?? '';
  }
}
