import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tuwaiq_project_pulse/extensions/date_ext.dart';
import 'package:tuwaiq_project_pulse/managers/auth_mgr.dart';
import 'package:tuwaiq_project_pulse/model/user/user.dart';
import 'package:tuwaiq_project_pulse/networking/_client/networking_api.dart';

import '../../reusable_components/popups/animated_snackbar.dart';

part 'create_project_state.dart';

class CreateProjectCubit extends Cubit<CreateProjectState> {
  CreateProjectCubit() : super(CreateProjectInitial());
  var authMgr = GetIt.I.get<AuthMgr>();
  var supervisorApi = NetworkingApi.shared.supervisorApi;

  List<User> allUsers = [];
  User? selectedUser;
  DateTime selectedDate = DateTime.now();
  bool canEdit = false;
  var addedUserId = TextEditingController();

  void fetchUsers() => allUsers = authMgr.allUsers;

  void changeSelectedUser(User user) {
    selectedUser = user;
    emit(UpdateUIState());
  }

  void showSnackBar(BuildContext context, String msg) {
    animatedSnakbar(msg: msg).show(context);
  }

  void toggleCanEdit() {
    canEdit = !canEdit;
    emit(UpdateUIState());
  }

  void setSelectedDate(DateTime date) {
    selectedDate = date;
    emit(UpdateUIState());
  }

  void saveChanges() {
    if (addedUserId.text.isNotEmpty) {
      selectedUser = User(id: addedUserId.text);
    }
    if (selectedUser == null) {
      emit(ErrorState(msg: 'No User Selected!'));
    } else {
      var formattedDate = selectedDate.toFormattedString();

      supervisorApi.createProject(
          userId: selectedUser!.id!, endDate: formattedDate, edit: canEdit);
      emit(SuccessState());
    }
  }
}
