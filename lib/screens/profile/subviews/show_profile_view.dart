import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuwaiq_project_pulse/screens/profile/profile_cubit.dart';

class ShowProfileView extends StatelessWidget {
  const ShowProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    return ListView(
      children: [
        Text('First Name: ${cubit.user.firstName ?? 'None'}'),
        Text('Last Name: ${cubit.user.lastName ?? 'None'}'),
        Text('Image: ${cubit.user.imageUrl == null ? 'NO' : 'YES'}'),
        Text('ROLE: ${cubit.user.role ?? 'None'}'),
      ],
    );
  }
}
