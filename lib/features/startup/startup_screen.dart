import 'package:app_project/core/routes/route.dart';

import 'package:app_project/features/services/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StartupScreen extends StatefulWidget {
  const StartupScreen({super.key});

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  @override
  void initState() {
    super.initState();

    checkOnboarding();
  }

  Future<void> checkOnboarding() async {
    final bool onboardingSeen = await PreferencesService.isOnboardingSeen();

    if (!mounted) return;

    if (onboardingSeen) {
      // Second time when i visit
      context.go(Routes.signup);
    } else {
      // First time when i visit
      context.go(Routes.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
