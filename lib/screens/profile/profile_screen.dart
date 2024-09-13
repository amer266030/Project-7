import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Text('Profile Screen'),
              Expanded(
                child: ListView(
                  children: const [
                    Text('Profile List Item'),
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
