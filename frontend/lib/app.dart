import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/themes/app_theme.dart';
import 'package:frontend/presentation/auth/auth_provider.dart';
import 'package:frontend/presentation/auth/auth_screen.dart';
import 'package:frontend/presentation/shell/main_shell.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return MaterialApp(
      title: 'Duty Scheduler',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: authState.status == AuthStatus.authenticated
          ? const MainShell()
          : const AuthScreen(),
    );
  }
}
