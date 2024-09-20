import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tuwaiq_project_pulse/managers/auth_mgr.dart';
import 'package:tuwaiq_project_pulse/model/user/user.dart';
import 'package:tuwaiq_project_pulse/networking/_client/networking_api.dart';
import 'package:tuwaiq_project_pulse/screens/admin/user_role.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitial());
  var authMgr = GetIt.I.get<AuthMgr>();
  var adminApi = NetworkingApi.shared.adminApi;

  List<User> allUsers = [];
  User? selectedUser;
  var selectedRole = UserRole.user;

  void fetchUsers() => allUsers = authMgr.allUsers;

  void changeSelectedUser(User user) {
    selectedUser = user;
    emit(UpdateUIState());
  }

  void changeUserRole(UserRole role) {
    selectedRole = role;
    emit(UpdateUIState());
  }

  void saveChanges() {
    if (selectedUser == null) {
      emit(ErrorState());
    } else {
      adminApi.changeUserRole(
          userId: selectedUser!.id!, role: selectedRole.name);
      emit(SuccessState());
    }
  }
}
