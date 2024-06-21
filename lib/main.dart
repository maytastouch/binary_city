import 'dart:io';
import 'dart:io' show Platform;
import 'package:binary_city/core/theme/bloc/theme_state.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:binary_city/core/common/dashboard/presentation/pages/dashboard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:window_size/window_size.dart';

import 'core/common/dashboard/presentation/bloc/selected_index.dart';
import 'core/constants/constants.dart';
import 'core/theme/bloc/theme_bloc.dart';
import 'init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  if (!kIsWeb) {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      setWindowTitle('Binary City');
      setWindowMaxSize(
          const Size(AppConstants.maxWidth, AppConstants.maxHeight));
      setWindowMinSize(
          const Size(AppConstants.minWidth, AppConstants.minHeight));
    }
  }

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SelectedIndexBloc(),
        ),
        BlocProvider(
          create: (_) => ThemeBloc(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Binary City',
          theme: state.themeData,
          home: const DashBoard(),
        );
      },
    );
  }
}
