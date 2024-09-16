import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuwaiq_project_pulse/screens/profile/profile_cubit.dart';

class ShowProfileView extends StatelessWidget {
  const ShowProfileView({super.key, required this.cubit});
  final ProfileCubit cubit;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ProfileCubit>();
    return ListView(
      children: [
        Text('First Name: ${cubit.user.id ?? 'None'}'),
        Text('First Name: ${cubit.user.firstName ?? 'None'}'),
        Text('Last Name: ${cubit.user.lastName ?? 'None'}'),
        Text('Image: ${cubit.user.imageUrl == null ? 'NO' : 'YES'}'),
        Text('ROLE: ${cubit.user.role ?? 'None'}'),
        TextButton(onPressed: () => (), child: Text('Change User Role'))
      ],
    );
  }
}
