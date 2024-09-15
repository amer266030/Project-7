import 'package:flutter/material.dart';
import 'package:tuwaiq_project_pulse/networking/_client/networking_api.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  final projectId = 'p-JGqY6xjCAK';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Text('Settings Screen'),
              Expanded(
                child: ListView(
                  children: [
                    TextButton(
                      onPressed: () => NetworkingApi.shared.userApi.createLogo(
                          projectId: projectId,
                          img: AssetImage('assets/defaultImg.png')),
                      child: const Text('Create Logo'),
                    ),
                    TextButton(
                      onPressed: () => NetworkingApi.shared.userApi.createProjectBase(
                          projectId: projectId,
                          ),
                      child: const Text('Create project base'),
                    ),
                    TextButton(
                      onPressed: () => NetworkingApi.shared.userApi.createLinks(
                          projectId: projectId,
                          ),
                      child: const Text('Create project Link'),
                    ),
                    TextButton(
                      onPressed: () => NetworkingApi.shared.userApi.createMembers(
                          projectId: projectId,
                          ),
                      child: const Text('Create project Link'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
