import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
                  children: const [
                    Text('Settings List Item'),
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
