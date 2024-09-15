import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/project/project.dart';
import '../../networking/_client/networking_api.dart';
part 'project_detail_bloc_state.dart';

class ProjectDetailBlocCubit extends Cubit<ProjectDetailBlocState> {
  final nwk = NetworkingApi.shared.publicApi;
  ProjectDetailBlocCubit() : super(ProjectDetailBlocInitial());
  // Alert Dialog
  bool isAlertVisible = false;
  var alertTitle = '';
  var alertMsg = '';
  // Project
  Project? selectedProject;
  String? projectId;

  void setProject() {}
}
