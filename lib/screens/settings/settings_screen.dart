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
                          projectId: projectId, img: Image.network('')),
                      child: const Text('Create Logo'),
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
