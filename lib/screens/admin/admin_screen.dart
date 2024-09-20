import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';
import 'package:tuwaiq_project_pulse/reusable_components/buttons/elevated_btn_view.dart';
import 'package:tuwaiq_project_pulse/reusable_components/cards/bordered_card_view.dart';
import 'package:tuwaiq_project_pulse/reusable_components/images/background_img.dart';
import 'package:tuwaiq_project_pulse/screens/admin/admin_cubit.dart';
import 'package:tuwaiq_project_pulse/screens/admin/user_role.dart';
import 'package:tuwaiq_project_pulse/utils/typedefs.dart';

import '../../model/user/user.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<AdminCubit>();
        return Scaffold(
          appBar: AppBar(
              centerTitle: true,
              title: const Text('Admin').styled(size: 18, weight: FW.bold)),
          body: Stack(
            children: [
              const BackgroundImg(),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            BorderedCardView(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('User:').styled(
                                        color: Colors.black, weight: FW.bold),
                                    Card(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child:
                                            BlocBuilder<AdminCubit, AdminState>(
                                          builder: (context, state) {
                                            if (state is AdminInitial) {
                                              cubit.fetchUsers();
                                            }
                                            return DropdownButton<User>(
                                              value: cubit.selectedUser,
                                              onChanged: (User? user) {
                                                cubit.changeSelectedUser(user!);
                                              },
                                              items: cubit.allUsers
                                                  .map((User user) {
                                                return DropdownMenuItem<User>(
                                                    value: user,
                                                    child:
                                                        Text(user.email ?? '')
                                                            .styled(size: 10));
                                              }).toList(),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            BorderedCardView(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Role:').styled(
                                        color: Colors.black, weight: FW.bold),
                                    Card(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child:
                                            BlocBuilder<AdminCubit, AdminState>(
                                          builder: (context, state) {
                                            return DropdownButton<UserRole>(
                                              value: cubit.selectedRole,
                                              onChanged: (UserRole? newRole) {
                                                cubit.changeUserRole(newRole!);
                                              },
                                              items: UserRole.values
                                                  .map((UserRole role) {
                                                return DropdownMenuItem<
                                                    UserRole>(
                                                  value: role,
                                                  child: Text(role
                                                      .name), // Display the role name
                                                );
                                              }).toList(),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedBtnView(
                                title: 'Set User Role',
                                hasBorder: true,
                                callBack: cubit.saveChanges),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
