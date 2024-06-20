import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/bloc/theme_bloc.dart';
import '../../../../core/common/widgets/white_button.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Theme Switcher',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Switch between Dark and Light Themes:',
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WhiteButton(
                  button_title: 'Dark Mode',
                  radius: 10,
                  onPressed: () => themeBloc.add(
                    ThemeEvent.toggleDark,
                  ),
                  child: const Text('Dark'),
                ),
                const SizedBox(width: 10),
                WhiteButton(
                  button_title: 'Light Mode',
                  radius: 10,
                  onPressed: () => themeBloc.add(
                    ThemeEvent.toggleLight,
                  ),
                  child: const Text('Light'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
