import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tuwaiq_project_pulse/networking/_client/networking_api.dart';

import '../../model/user/user.dart';

part 'user_projects_state.dart';

class UserProjectsCubit extends Cubit<UserProjectsState> {
  final nwk = NetworkingApi.shared.profileApi;
  UserProjectsCubit() : super(UserProjectsInitial());
  var user = User();

  void loadProfile() async {
    // clearAlertFields();
    // emit(ProfileLoadingState());
    try {
      await nwk.fetchProfile();
      if (nwk.user == null || nwk.response?.statusCode == null) {
        throw Exception(nwk.errorMsg);
      }
      user = nwk.user!;
      print(user.id);
      // await _updateInputFields();
      emit(UpdateUIState());
    } catch (e) {
      print(e);
      // alertTitle = 'Oops';
      // alertMsg = '$e';
      // emit(ProfileErrorState());
    }
  }
}
